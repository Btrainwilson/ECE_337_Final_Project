// $Id: $
// File name:   Byte_Register.sv
// Created:     4/13/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Byte Register. Wrapper for a p_t_s shift register and control logic

module Byte_Register
(
	input 	wire clk,
		wire n_rst,
		wire load_en, 	//Loads the mux_byte into the parallel to serial register
		wire shift_enable,	//Shifts out bit from register
		reg select,			//0 = FIFO_byte, 1 = FSM byte
		reg [7:0]FSM_byte,	//Byte from FSM
		reg [7:0]FIFO_byte,	//byte from fifo
	output 	wire out_bit		//out bit from register
		

);

	//MUX Selector
	reg [7:0] mux_byte;
	always_comb begin
		if(select)
			mux_byte = FSM_byte;
		else
			mux_byte = FIFO_byte;
	end

	//Shift Register 
	flex_pts_sr #(.NUM_BITS(8), .SHIFT_MSB(0)) shiftreg (.clk(clk), .n_rst(n_rst), .shift_enable(shift_enable), .serial_out(out_bit), .parallel_in(mux_byte),.load_enable(load_en));

endmodule
