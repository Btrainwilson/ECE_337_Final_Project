// $Id: $
// File name:   tb_flex_counter.sv
// Created:     1/25/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 3: 5.1: Flexible Counter Test Bench.

`timescale 1ns / 10ps

module tb_flex_counter();

	// Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;  //400 MHz Clock
	
	// Shared Test Variables
	reg tb_clk;
	
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	// Default Config Test Variables & constants
	localparam NUM_BITS = 4;

	tb_flex_counter_DUT #(.NUM_CNT_BITS(NUM_BITS)) flex_counter_config (.tb_clk);

	
endmodule

module tb_flex_counter_DUT

	#(
	parameter NUM_CNT_BITS
	)
	
	(
	input wire tb_clk
	);

	localparam MAX_BIT = NUM_CNT_BITS - 1;

	integer tb_test_num;
	integer tb_fail_count;
	integer tb_i;
	integer tb_expected_count;
	integer tb_max_count;
	reg tb_n_rst;
	reg tb_clear;
	reg tb_count_enable;
	reg [NUM_CNT_BITS - 1: 0] tb_rollover_val;
	reg [NUM_CNT_BITS - 1: 0] tb_count_out;
	reg tb_rollover_flag;

	flex_counter DUT (
	.clk(tb_clk), 
	.n_rst(tb_n_rst), 
	.clear(tb_clear), 
	.count_enable(tb_count_enable),
	.rollover_val(tb_rollover_val),
	.count_out(tb_count_out),
	.rollover_flag(tb_rollover_flag)
	);

	clocking cb @(posedge tb_clk);
 		// 1step means 1 time precision unit, 10ps for this module. We assume the hold time is less than 200ps.
		default input #1step output #100ps; // Setup time (01CLK -> 10D) is 94 ps
		output #800ps n_rst = tb_n_rst; // FIXME: Removal time (01CLK -> 01R) is 281.25ps, but this needs to be 800 to prevent metastable value warnings
		output clear = tb_clear,
			count_enable = tb_count_enable,
			rollover_val = tb_rollover_val;
		input count_out = tb_count_out,
			rollover_flag = tb_rollover_flag;
	endclocking

	// Default Configuration Test bench main process
	initial
	begin
		// Initialize all of the test inputs
		tb_n_rst		= 1'b1;				// Initialize to be inactive
		// Initialize parallel in to be idle values
		tb_clear		= 1'b0;
		tb_count_enable		= 1'b0;				// Initialize to be inactive
		tb_rollover_val		= '1;				// Initialize to be inactive
		tb_test_num 		= 0;
		
		// Power-on Reset of the DUT
		// Assume we start at positive edge. Immediately assert reset at first negative edge
		// without using clocking block in order to avoid metastable value warnings
		@(negedge tb_clk);
		tb_n_rst	<= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
		@cb;
		cb.n_rst	<= 1'b1; 	// Deactivate the chip reset
		
		// Wait for a while to see normal operation
		@cb;

	// Test 1: Check for Reset override of enable bit
		tb_test_num = tb_test_num + 1;
		
		cb.clear  <= 1'b0;
		cb.count_enable <= 1'b1;
		cb.n_rst	<= 1'b0;
		cb.rollover_val	<= '1;
		// Wait two cycles, long enough for the reset to get to the DUT, and to receive
		// the response back
		@cb;
		@cb;
		// Check that the output is idle
		if (cb.count_out == 0 && cb.rollover_flag == 0)
			$info("Test Case %0d:: PASSED", tb_test_num);
		else // Test case failed
			$error("Test Case %0d:: FAILED", tb_test_num);

	// Test 2: Count to just below rollover value
		tb_test_num = tb_test_num + 1;

		cb.clear  <= 1'b0;
		cb.count_enable <= 1'b1;
		cb.n_rst	<= 1'b1;
		cb.rollover_val	<= '1;
		

		// Begin counting.  Check every iteration until rollover value is reached.		
		tb_expected_count = 0;
		tb_fail_count = 0;
		tb_max_count = 0;
		tb_max_count[MAX_BIT:0] = '1;

		for(tb_i = 0; tb_i < tb_max_count; tb_i = tb_i + 1)
		begin
			//@cb;			
			#(2.5/2.0);
			
			
			if (tb_count_out != tb_expected_count)
			begin
				tb_fail_count = tb_fail_count + 1;
			end

			#(2.5/2.0);
			tb_expected_count = tb_expected_count + 1;
		end

		// Check for proper counting and rollover flag	
		if (tb_fail_count == 0)
			$info("Test Case %0d:: PASSED", tb_test_num);
		else // Test case failed
			$error("Test Case %0d:: FAILED", tb_test_num);
		
		tb_expected_count = 0;
		tb_fail_count = 0;

	// Test 3: Rollover flag and maintenance of Rollover Flag	
	tb_test_num = tb_test_num + 1;
	cb.count_enable <= 1'b0;
	
	@cb;
	@cb;
	@cb;

	// Check if value rolled over to 1.
	if (tb_count_out == tb_max_count && tb_rollover_flag == 1)
		$info("Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Test Case %0d:: FAILED", tb_test_num);

	



	// Test 4: Rollover
	#(2.5/2.0);
	tb_test_num = tb_test_num + 1;	
	cb.count_enable <= 1'b1;
	#(2.5/2.0);
	@cb;
	@cb;
	
	#(2.5/2.0);
	// Check if value rolled over to 1.
	if (tb_count_out == 1)
		$info("Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Test Case %0d:: FAILED", tb_test_num);
	#(2.5/2.0);
	
	
	

	// Test 5: Test clear override of enable

	cb.clear  <= 1'b1;
	cb.count_enable <= 1'b1;

	@cb;
	tb_test_num = tb_test_num + 1;
	@cb;
	@cb;

	#(2.5/2.0);
	// Check to see if count is cleared.	
	if (tb_count_out == 0)
		$info("Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Test Case %0d:: FAILED", tb_test_num);
	#(2.5/2.0);	


	// Test 6: Moving the rollover up
	tb_test_num = tb_test_num + 1;
	cb.rollover_val <= 0;
	#(2.5/2.0);
	cb.clear  <= 1'b0;
	cb.count_enable <= 1'b1;
	cb.rollover_val[MAX_BIT-1:0] <= '1;
	#(2.5/2.0);

	// Begin counting.  Check every iteration until rollover value is reached.		
		tb_expected_count = 0;
		tb_fail_count = 0;
		tb_max_count = 0;
		tb_max_count[MAX_BIT-1:0] = '1;

		for(tb_i = 0; tb_i < tb_max_count; tb_i = tb_i + 1)
		begin
			//@cb;			
			#(2.5/2.0);
			
			
			if (tb_count_out != tb_expected_count)
			begin
				tb_fail_count = tb_fail_count + 1;
			end

			#(2.5/2.0);
			tb_expected_count = tb_expected_count + 1;
		end
		#(2.5/2.0);
		tb_rollover_val <= tb_rollover_val + 1;
		#(2.5/2.0);
		#(2.5/2.0);
		if (tb_rollover_flag == 0)
		begin
			tb_fail_count = tb_fail_count + 1;
		end
		#(2.5/2.0);
		@cb;
		

	// Check for proper counting and rollover flag	
		if (tb_fail_count == 0)
			$info("Test Case %0d:: PASSED", tb_test_num);
		else // Test case failed
			$error("Test Case %0d:: FAILED", tb_test_num);
		
		tb_expected_count = 0;
		tb_fail_count = 0;

	// Test 7 : Moving the rollover down
		tb_test_num = tb_test_num + 1;
		@cb;//Rollover to 1
		@cb;// count to 2
		#(2.5/2.0);
		tb_rollover_val = 2;
		#(2.5/2.0);
		// count is now at 3, and is above rollover
		#(2.5/2.0);
		// check to see that flag didn't falsely trigger
		if (tb_rollover_flag == 0)
			$info("Test Case %0d:: PASSED", tb_test_num);
		else // Test case failed
			$error("Test Case %0d:: FAILED", tb_test_num);
		#(2.5/2.0);
		

	
	tb_clear = 0;
	tb_expected_count = '0;
	tb_fail_count = '0;
	tb_i = '0;
	tb_max_count = '0;
	tb_rollover_val = '0;
	tb_test_num = '0;
	@cb;

	tb_clear = 1;
	tb_expected_count = '1;
	tb_fail_count = '1;
	tb_i = '1;
	tb_max_count = '1;
	tb_rollover_val = '1;
	tb_test_num = '1;
	@cb;
	
	tb_clear = 0;
	tb_expected_count = '0;
	tb_fail_count = '0;
	tb_i = '0;
	tb_max_count = '0;
	tb_rollover_val = '0;
	tb_test_num = '0;
	@cb;
	end
	
	
endmodule
