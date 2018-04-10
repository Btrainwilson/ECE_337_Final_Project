// $Id: $
// File name:   tb_Timer.sv
// Created:     4/7/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Timer Test Bench
`timescale 1ns / 10ps
module tb_Timer();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 1;
	localparam	FF_SETUP_TIME	= 0.190;
	localparam	FF_HOLD_TIME	= 0.100;
	localparam	CHECK_DELAY 	= (CLK_PERIOD - FF_SETUP_TIME); // Check right before the setup time starts
	
	localparam	RESET_OUTPUT_VALUE	= 1'b0;

	//Test Variables
	reg tb_clk;
	reg tb_n_rst;
	reg tb_d_edge;
	reg tb_rcving;
	reg tb_reset;
	reg tb_byte_received;
	reg tb_Shift_Enable;
	reg tb_Sample;

	// DUT Port map
	Timer DUT(.clk(tb_clk), .n_rst(tb_n_rst), .d_edge(tb_d_edge),.rcving(tb_rcving),.reset(tb_reset),.byte_received(tb_byte_received),.Shift_Enable(tb_Shift_Enable),.Sample(tb_Sample));

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	initial begin
	tb_n_rst = 1'b0;
	@(posedge tb_clk);
	tb_n_rst = 1'b1;
	tb_rcving = 1'b1;
	tb_d_edge = 1'b0;
	tb_reset = 1'b0;

	end

endmodule
