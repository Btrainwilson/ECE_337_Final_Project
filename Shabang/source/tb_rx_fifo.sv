// $Id: $
// File name:   tb_rx_fifo.sv
// Created:     2/18/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 6 (Beating a dead horse, part 1): FIFO tb

`timescale 1ns / 10ps

module tb_rx_fifo();

	// Define local parameters used by the test bench
	localparam	NORM_CLK_PERIOD		= 10 * 100 / 96; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)

	// Declare DUT portmap signals
	reg tb_r_enable;
	reg tb_w_enable;
	reg [7:0] tb_w_data;
	reg [7:0] tb_r_data;
	reg tb_empty;
	reg tb_full;
	reg tb_n_rst;
	reg tb_clk;

	// Declare test bench signals
	integer tb_test_num;
	
	

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(NORM_CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(NORM_CLK_PERIOD/2.0);
	end

	// DUT Port map
	rx_fifo DUT(.clk(tb_clk), .n_rst(tb_n_rst), .r_enable(tb_r_enable), .w_enable(tb_w_enable), .w_data(tb_w_data), .r_data(tb_r_data), .empty(tb_empty), .full(tb_full));

	// Test bench main process
	initial
	begin
		tb_r_enable = 0;
		tb_w_enable = 0;
		tb_w_data = '0;
		tb_test_num = 0;
				
		
		// Power-on reset of DUT
		tb_n_rst = 1'b0;
		@(negedge tb_clk)
		@(negedge tb_clk)
		tb_n_rst = 1'b1;
		@(negedge tb_clk)
		@(negedge tb_clk)

		// Load the buffer until it's full.

		while (tb_full != 1)
		begin
			// fill er up.  ding ding.

			@(negedge tb_clk)
			tb_w_data = tb_test_num[7:0];
			tb_w_enable = 1;
			tb_test_num += 1;
		end
		$info("BUFFER FULL");
		tb_w_enable = 0;

		tb_r_enable = 1;
		@(tb_empty);
		tb_r_enable = 0;
		$info("BUFFER EMPTY");

		@(negedge tb_clk)
		tb_w_enable = 1;
		tb_w_data = '1;
		@(negedge tb_clk)
		tb_w_data = '0;
		@(negedge tb_clk)
		tb_w_enable = 0;
		tb_r_enable = 1;
		@(tb_empty);
		$info( "mission accomplished - GWB");
		tb_n_rst = 1'b0;
	end
endmodule
