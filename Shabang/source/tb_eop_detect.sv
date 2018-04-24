// $Id: $
// File name:   tb_eop_detect.sv
// Created:     2/18/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 6: EOP detector testbench

`timescale 1ns / 10ps

module tb_eop_detect();

	// Define local parameters used by the test bench
	localparam	NORM_CLK_PERIOD		= 10 * 100 / 96; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)

	// Declare DUT portmap signals
	reg tb_d_plus;
	reg tb_d_minus;
	wire tb_eop;
	reg tb_clk;

	// Declare test bench signals
	integer tb_test_num;
	reg tb_expected_output;
	

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(NORM_CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(NORM_CLK_PERIOD/2.0);
	end

	// DUT Port map
	eop_detect DUT(.d_plus(tb_d_plus), .d_minus(tb_d_minus), .eop(tb_eop));

	// Test bench main process
	initial
	begin
	
		// Exhaustive Test of eop combinational logic

		for (tb_test_num = 0; tb_test_num < 5; tb_test_num += 1)
		begin
			@(negedge tb_clk)
			tb_d_plus = tb_test_num[0];
			tb_d_minus = tb_test_num[1];
			
			tb_expected_output = ~((tb_d_plus)|(tb_d_minus));
			
			@(negedge tb_clk)

			assert(tb_eop == tb_expected_output)
				$info("Test %d output: CORRECT", tb_test_num);
			else
				$error("Test %d output: INCORRECT", tb_test_num);

		end

	end

endmodule

	
