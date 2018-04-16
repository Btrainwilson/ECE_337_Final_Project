// $Id: $
// File name:   tb_USB_Timer.sv
// Created:     4/13/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB Timer Module




`timescale 1ns / 10ps
module tb_bit_stuff
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
		reg tb_send_next_bit;
		reg tb_Tim_en;
		reg tb_raw_to_encoder;
		reg tb_shift_enable;
		reg tb_data_bit;
		

	//DUT Map
	generate
	bit_stuff DUT(.clk(tb_clk),.n_rst(tb_n_rst),.send_next_bit(tb_send_next_bit),.Tim_en(tb_Tim_en),.raw_to_encoder(tb_raw_to_encoder),.shift_enable(tb_shift_enable),.data_bit(tb_data_bit));
	endgenerate

	initial
	begin
	//Test Sequence
	tb_send_next_bit = 0;
	tb_Tim_en = 0;
	tb_data_bit = 1;
	
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_n_rst	= 1'b0;

	@(negedge tb_clk);
	tb_n_rst = 1;
	tb_Tim_en = 1;
	tb_send_next_bit = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_data_bit = 0;
	
	
	
	end

endmodule
