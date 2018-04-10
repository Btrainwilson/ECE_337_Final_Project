// $Id: $
// File name:   tb_flex_counter.sv
// Created:     1/30/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: test bench for counter
`timescale 1ns / 10ps
module tb_flex_counter
#(parameter NUM_CNT_BITS = 4)
();


	// Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay

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
tb_flex_counter_DUT #(.BITS(NUM_CNT_BITS))  stp_default(.tb_clk);
endmodule

module tb_flex_counter_DUT 
#(parameter BITS = 4) 
(input wire tb_clk);
	//Variables
	reg tb_n_rst;
	reg tb_clear;
	reg tb_count_en;
	reg [BITS-1:0] tb_roll_val;
	reg [BITS-1:0] tb_count;
	reg tb_roll_flag;

	integer i,j;


	//DUT Map
	generate
	flex_counter DUT(.clk(tb_clk),.n_rst(tb_n_rst),.clear(tb_clear),.count_enable(tb_count_en),.rollover_val(tb_roll_val),.count_out(tb_count),.rollover_flag(tb_roll_flag));
	endgenerate

	//Clocking Stuff
	
	clocking cb @(posedge tb_clk);
 		// 1step means 1 time precision unit, 10ps for this module. We assume the hold time is less than 200ps.
		default input #1step output #100ps; // Setup time (01CLK -> 10D) is 94 ps
		output #800ps n_rst = tb_n_rst; // FIXME: Removal time (01CLK -> 01R) is 281.25ps, but this needs to be 800 to prevent metastable value warnings
		output clear = tb_clear,
			count_enable = tb_count_en,
			rollover_val = tb_roll_val;
		input count_out = tb_count,
			rollover_flag = tb_roll_flag;
	endclocking

	// Default Configuration Test bench main process
	initial
	begin
	integer 
	tb_n_rst;
	tb_clear = 1'b0;
	tb_count_en = 1'b0;
	tb_roll_val = BITS - 1;

			
	// Power-on Reset of the DUT
	// Assume we start at negative edge. Immediately assert reset at first negative edge
	// without using clocking block in order to avoid metastable value warnings
	@(negedge tb_clk);
	tb_n_rst	<= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
	@cb;
	cb.n_rst	<= 1'b1; 	// Deactivate the chip reset
	
	// Wait for a while to see normal operation
	@cb;
	@cb;
		// Test 1: Check for Proper Reset w/ Idle (serial_in=1) input during reset signal

	cb.n_rst <= 1'b0;
	cb.count_enable <= 1'b1;

	@cb; // Measure slightly before the second clock edge
	@cb;

	cb.n_rst <= 1'b1;
	cb.count_enable <= 1'b1;

	@cb; // Measure slightly before the second clock edge
	@cb;

	cb.n_rst <= 1'b1;
	cb.count_enable <= 1'b0;

	@cb; // Measure slightly before the second clock edge
	@cb;
	cb.clear <= 1'b1;

	@cb;

	cb.n_rst <= 1'b1;
	cb.count_enable <= 1'b0;
	cb.clear <= 1'b0;

	@cb; // Measure slightly before the second clock edge
	@cb;

	cb.n_rst <= 1'b1;
	cb.count_enable <= 1'b1;
	cb.rollover_val <= 0;

	@cb; // Measure slightly before the second clock edge
	@cb;

	for(i = 0; i <= BITS ** 2; i = i + 1)begin
			cb.rollover_val <= i;
		for(j = 0; j <= i + 2; j = j + 1)begin
			cb.clear <= cb.rollover_flag;
			@(negedge tb_clk);
			@(posedge tb_clk);
		end

	end
	
	end

endmodule

