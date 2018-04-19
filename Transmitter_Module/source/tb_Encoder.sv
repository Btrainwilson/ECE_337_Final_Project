// $Id: $
// File name:   tb_USB_Timer.sv
// Created:     4/13/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB Timer Module




`timescale 1ns / 10ps
module tb_Encoder
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


	
		reg tb_n_rst;
		reg tb_Data_In;
		reg tb_eop;
		reg tb_idle;
		reg tb_d_plus;
		reg tb_d_minus;
		int test_num;
		

	//DUT Map
	generate
	Encoder DUT(.clk(tb_clk),.n_rst(tb_n_rst),.Data_In(tb_Data_In),.eop(tb_eop),.idle(tb_idle),
	.d_plus(tb_d_plus),.d_minus(tb_d_minus));
	endgenerate

	initial
	begin

	//Test Sequence
	@(posedge tb_clk); 
	@(negedge tb_clk);
	test_num = 0;
	tb_n_rst	= 1'b0;

	@(negedge tb_clk);
	@(negedge tb_clk);
	
	tb_n_rst = 1;

	// Test 1: 
	
	end

endmodule
