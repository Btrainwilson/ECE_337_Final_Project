// $Id: $
// File name:   sr_9bit.sv
// Created:     2/5/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: SR 9 bit

//WORKS!
module sr_9bit (
	input wire clk,
	n_rst,
	shift_strobe,
	serial_in,
	output wire [7:0] packet_data,
	wire stop_bit

);

	reg [8:0] full_9;

flex_stp_sr  #(9,0) bit_9_SR (.clk(clk), .n_rst(n_rst), .shift_enable(shift_strobe), .serial_in(serial_in), .parallel_out(full_9));

	assign stop_bit = full_9[8];
	assign packet_data = full_9[7:0];


endmodule
