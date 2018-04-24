// $Id: $
// File name:   tb_timer.sv
// Created:     2/22/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Timer

`timescale 1ns / 10ps
module tb_timer
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
	reg tb_d_edge;
	reg tb_rcving;
	reg tb_shift_enable;
	reg tb_byte_received;

	//DUT Map
	generate
	timer DUT(.clk(tb_clk),.n_rst(tb_n_rst),.rcving(tb_rcving),.shift_enable(tb_shift_enable),.d_edge(tb_d_edge),.byte_received(tb_byte_received));
	endgenerate

	initial
	begin
	//Test Sequence
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_n_rst	= 1'b0;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_n_rst	= 1'b1;
	tb_d_edge = 1'b0;
	tb_rcving = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_d_edge = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_d_edge = 1'b0;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);
	@(posedge tb_clk); 
	@(negedge tb_clk);




	end

endmodule

