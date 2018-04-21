// $Id: $
// File name:   shift_register.sv
// Created:     2/26/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: shift register used for usb receiver
`timescale 1ns / 10ps
module shift_register
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire d_orig,
	output reg [7:0] rcv_data
);

flex_stp_sr #(.NUM_BITS(8),.SHIFT_MSB(0)) SR (.clk(clk), .n_rst(n_rst), .shift_enable(shift_enable), .serial_in(d_orig), .parallel_out(rcv_data));

endmodule
