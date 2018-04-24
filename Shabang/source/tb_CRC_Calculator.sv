// $Id: $
// File name:   tb_CRC_Calculator.sv
// Created:     4/20/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Test Bench for CRC Calculator
`timescale 1ns / 10ps
module tb_CRC_Calculator();

// Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 10;
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
		reg tb_bit_in;
		reg tb_new_bit;
		reg tb_reset;
		reg tb_CRC_Calc;
		reg tb_CRC_Send;
		reg tb_serial_out;

CRC_Calculator CRC_Module(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.bit_in(tb_bit_in),			//Shift in new bit
		.new_bit(tb_new_bit),			//new bit to be shifted in
		.reset(tb_reset),			//Synchronous reset 
		.CRC_Calc(tb_CRC_Calc),			//Signal for performing CRC_Calc and CRC_Send
		.CRC_Send(tb_CRC_Send),			//Signal to tell TXPU it is ready to transmit CRC bytes (1:1) (CRC = 1 While CRC is sending)
		.serial_out(tb_serial_out)			//Serial out for transmitting to bit stuffer
		
 
);

	initial begin
	tb_bit_in = 1'b1;
	tb_new_bit = 1'b1;
	tb_reset = 1'b0;
	tb_CRC_Calc = 1'b0;
	//Test Sequence
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_n_rst	= 1'b0;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_n_rst= 1'b1;
	tb_new_bit = 1'b1;
	tb_reset = 1'b0;
	tb_CRC_Calc = 1'b0;
	@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;

@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;

@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_bit_in = 1'b1;
@(posedge tb_clk); 
	@(negedge tb_clk);
	tb_CRC_Calc = 1'b1;
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
@(posedge tb_clk); 
	@(negedge tb_clk);
@(posedge tb_clk); 
	@(negedge tb_clk);
@(posedge tb_clk); 
	@(negedge tb_clk);
@(posedge tb_clk); 
	@(negedge tb_clk);
@(posedge tb_clk); 
	@(negedge tb_clk);@(posedge tb_clk); 
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
	@(negedge tb_clk);@(posedge tb_clk); 
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
	@(negedge tb_clk);@(posedge tb_clk); 
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
	@(negedge tb_clk);@(posedge tb_clk); 
	@(negedge tb_clk);
@(posedge tb_clk); 
	@(negedge tb_clk);
@(posedge tb_clk); 
	@(negedge tb_clk);
@(posedge tb_clk); 
	@(negedge tb_clk);
tb_CRC_Calc = 1'b0;
	end

endmodule
