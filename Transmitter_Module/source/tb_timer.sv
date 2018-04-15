// $Id: $
// File name:   tb_timer.sv
// Created:     2/21/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab6: Timer testbench
`timescale 1ns / 10ps

module tb_timer();

	// Define local parameters used by the test bench
	localparam	NORM_CLK_PERIOD		= 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)

	// Declare DUT portmap signals
	reg tb_d_edge;
	reg tb_rcving;
	reg tb_shift_enable;
	reg tb_byte_received;
	reg tb_n_rst;
	reg tb_clk;

	// Declare test bench signals
	integer tb_test_num;
	reg tb_expected_output;
	reg [7:0] unencoded;
	integer i;
	integer j;
	reg first_bit;
	
	

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(NORM_CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(NORM_CLK_PERIOD/2.0);
	end

	// DUT Port map
	timer DUT(.clk(tb_clk), .n_rst(tb_n_rst), .d_edge(tb_d_edge), .shift_enable(tb_shift_enable), .rcving(tb_rcving),
			 .byte_received(tb_byte_received));

	// Test vector struct
	//typedef struct
	//{
	//	reg first_bit; // Bit prior to encoded message
	//	reg [7:0] unencoded;
	//} testVector;


	task resetDUT;
	begin
		// Power-on reset of DUT
		tb_n_rst = 1'b0;
		@(negedge tb_clk);
		@(negedge tb_clk);
		tb_n_rst = 1'b1;
		@(negedge tb_clk);
		@(negedge tb_clk);

	end
	endtask

	initial // TESTBENCH: BEGIN
	begin
		// Enable the count
		tb_rcving = 0;
		tb_d_edge = 0;
		i = 0;
		j = 0;
		tb_test_num = 0;

	// power-on reset
		resetDUT();
		tb_rcving = 1;
		

		// Test 1: Count all the way up to byte_received
		tb_test_num += 1;
		for(i = 0; i < 8; i++)
		begin
			for(j = 0; j < 8; j++)
			begin
				@(negedge tb_clk);
				if (j == 2)
				begin
					assert(tb_shift_enable == 1)
						$info("Shift_enable high: CORRECT");
					else
						$error("Shift_enable low: INCORRECT");
				end
				else
				begin
					assert(tb_shift_enable == 0)
						$info("Shift_enable low: CORRECT");
					else
						$error("Shift_enable high: INCORRECT");
				end

				if (j == 3 && i == 7)
				begin
					assert(tb_byte_received == 1)
						$info("byte_received high: CORRECT");
					else
						$error("byte_received low: INCORRECT");
				end
				
			end
		end
		
		// Test 2: d_edge override
		tb_test_num += 1;
		tb_rcving = 0;
		resetDUT();
		@(negedge tb_clk);
		
		
		tb_rcving = 1;
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		tb_d_edge = 1;
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		
		assert(tb_shift_enable == 0)
			$info("d_edge override: CORRECT");
		else
			$error("d_edge override: INCORRECT");

		// Test 3: rcving clear
		tb_test_num += 1;
		tb_rcving = 1;
		tb_d_edge = 0;
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		tb_rcving = 0;

		// Look at internal count value, should go to 0.
		
	
	end
endmodule
