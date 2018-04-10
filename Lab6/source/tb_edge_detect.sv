// $Id: $
// File name:   tb_edge_detect.sv
// Created:     2/18/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 6: edge detector tb

`timescale 1ns / 10ps

module tb_edge_detect();

	// Define local parameters used by the test bench
	localparam	NORM_CLK_PERIOD		= 10 * 100 / 96; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)

	// Declare DUT portmap signals
	reg tb_d_plus;
	reg tb_d_edge;
	reg tb_n_rst;
	reg tb_clk;

	// Declare test bench signals
	integer tb_test_num;
	reg tb_expected_output;
	integer i;
	reg [7:0] tb_test_vector;
	

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(NORM_CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(NORM_CLK_PERIOD/2.0);
	end

	// DUT Port map
	edge_detect DUT(.clk(tb_clk), .n_rst(tb_n_rst), .d_plus(tb_d_plus), .d_edge(tb_d_edge));

	// Test bench main process
	initial
	begin
		// Power-on reset of DUT
		tb_n_rst = 1'b0;
		tb_d_plus = 0;
		@(negedge tb_clk)
		@(negedge tb_clk)
		tb_n_rst = 1'b1;
		@(negedge tb_clk)
		@(negedge tb_clk)
	
		// Exhaustive Test of eop combinational logic

		for (tb_test_num = 0; tb_test_num < 5; tb_test_num += 1)
		begin
			@(negedge tb_clk)
			tb_d_plus = tb_test_num[0];
			
			tb_expected_output = (tb_test_num[0] != tb_test_num[1]);
			
			@(negedge tb_clk)
			tb_d_plus = tb_test_num[1];

			@(negedge tb_clk)

			assert(tb_d_edge == tb_expected_output)
				$info("Test %d output: CORRECT", tb_test_num);
			else
				$error("Test %d output: INCORRECT", tb_test_num);

		end
		@(negedge tb_clk)
		tb_n_rst = 1'b0;
		@(negedge tb_clk)
		tb_n_rst = 1'b1;
		tb_d_plus = 1'b1;
		@(negedge tb_clk);
		tb_n_rst = 1'b0; // should lower edge detect halfway into pulse

	end
endmodule

