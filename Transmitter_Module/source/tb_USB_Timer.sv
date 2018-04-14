// $Id: $
// File name:   tb_USB_Timer.sv
// Created:     4/13/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB Timer Module




`timescale 1ns / 10ps
module tb_USB_Timer
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
		reg tb_bit_sent;
		reg tb_Tim_rst;
		reg tb_Tim_en;
		reg tb_new_bit;
		reg [7:0]tb_byte_out;
		reg tb_EOD;
		reg tb_Load_Byte;

	//DUT Map
	generate
	USB_Timer DUT(.clk(tb_clk),.n_rst(tb_n_rst),.bit_sent(tb_bit_sent),.Tim_rst(tb_Tim_rst),.Tim_en(tb_Tim_en),.new_bit(tb_new_bit),.byte_out(tb_byte_out),.EOD(tb_EOD),.Load_Byte(tb_Load_Byte));
	endgenerate

	initial
	begin
	//Test Sequence
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_n_rst	= 1'b0;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_n_rst= 1'b1;
	tb_bit_sent = 1'b0;
	tb_Tim_en = 1'b1;
	tb_Tim_rst = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
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
	tb_bit_sent = 1'b1;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_sent = 1'b0;
	end

endmodule
