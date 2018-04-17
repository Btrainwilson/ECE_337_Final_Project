// $Id: $
// File name:   tb_Byte_Register.sv
// Created:     4/13/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: test bench for Byte register

`timescale 1ns / 10ps

module tb_Byte_Register 
();

	localparam	CLK_PERIOD		= 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.

	// Declare DUT portmap signals
	reg tb_n_rst;
	reg tb_clk;	
	reg [7:0] tb_FSM_byte;
	reg [7:0] tb_FIFO_byte;
	reg tb_load_en;
	reg tb_select;
	reg tb_out_bit;	
	
	// Clock generation blocks
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end	
	
	Byte_Register DUT(.clk(tb_clk), .n_rst(tb_n_rst), .FSM_byte(tb_FSM_byte), .FIFO_byte(tb_FIFO_byte),
			.load_en(tb_load_en)



endmodule
