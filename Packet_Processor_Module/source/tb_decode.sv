// $Id: $
// File name:   tb_decode.sv
// Created:     2/16/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry

`timescale 1ns / 10ps

module tb_decode();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 1;
	localparam	FF_SETUP_TIME	= 0.190;
	localparam	FF_HOLD_TIME	= 0.100;
	localparam	CHECK_DELAY 	= (CLK_PERIOD - FF_SETUP_TIME); // Check right before the setup time starts
	
	localparam	RESET_OUTPUT_VALUE	= 1'b0;
	
	// Declare DUT portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_d_plus;
	reg tb_shift_enable;
	reg tb_eop;
	reg tb_d_orig;
	

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	// DUT Port map
	decode DUT(.clk(tb_clk), .n_rst(tb_n_rst), .d_plus(tb_d_plus), .shift_enable(tb_shift_enable),.eop(tb_eop),.d_orig(tb_d_orig));
	
	// Test bench main process
	initial
	begin
		tb_shift_enable = 1'b0;
		tb_eop = 1'b0;
		// Initialize all of the test inputs
		tb_n_rst	= 1'b1;		// Initialize to be inactive
		tb_d_plus	= 1'b1;		// Initialize to idle
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_n_rst	= 1'b0;		// Initialize to be inactive
		tb_d_plus	= 1'b0;		// Initialize to idle
		//Test Sequence
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_n_rst	= 1'b1;

		//Test Sequence of all edges
		tb_d_plus	= 1'b0;	 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b1;	 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b1;	 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b0;	 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b1;	 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b1;	 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b0;	
		tb_shift_enable = 1'b1; 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b0;	 
		tb_shift_enable = 1'b0;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_shift_enable = 1'b1; 
		tb_eop = 1'b1;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_shift_enable = 1'b0; 
		tb_eop = 1'b0;
		tb_d_plus	= 1'b1;	
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_eop = 1'b1;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_eop = 1'b0;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b1;	
		tb_shift_enable = 1'b1; 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b1;	
		tb_shift_enable = 1'b0; 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b0;

	end
endmodule
