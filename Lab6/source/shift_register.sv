// $Id: $
// File name:   shift_register.sv
// Created:     2/21/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab6: Shift register for storing bytes

module shift_register	
	(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire d_orig,
	output reg [7:0] rcv_data
	);

	flex_stp_sr #(.NUM_BITS(8), .SHIFT_MSB(0)) shiftreg (.clk(clk), .n_rst(n_rst), .shift_enable(shift_enable), .serial_in(d_orig), .parallel_out(rcv_data));
endmodule
