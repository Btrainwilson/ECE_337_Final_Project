// $Id: $
// File name:   tb_edge_detect
// Created:     2/16/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: edge detector test bench

`timescale 1ns / 10ps

module tb_edge_detect();

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
	wire tb_d_edge;
	

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	// DUT Port map
	edge_detect DUT(.clk(tb_clk), .n_rst(tb_n_rst), .d_plus(tb_d_plus), .d_edge(tb_d_edge));
	
	// Test bench main process
	initial
	begin
		// Initialize all of the test inputs
		tb_n_rst	= 1'b1;		// Initialize to be inactive
		tb_d_plus	= 1'b1;		// Initialize to idle

		#(0.1);
		
		// Test Case 1: Power-on Reset of the DUT

		#(0.1);
		tb_n_rst	= 1'b0; 	// Activate reset
		tb_d_plus	= 1'b0;		// Set to be 
		#(CLK_PERIOD * 0.5);

		//Test Sequence
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_n_rst	= 1'b1;
		//Test Sequence of all edges
		tb_d_plus	= 1'b1;	 
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b0;	 
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
		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_d_plus	= 1'b0;	 
		@(posedge tb_clk); 
		@(negedge tb_clk);
	end
endmodule
