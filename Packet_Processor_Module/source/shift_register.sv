// $Id: $
// File name:   shift_register.sv
// Created:     2/17/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: 8 bit shift register

module shift_register
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire d_orig,
	output wire [7:0] rcv_data

);

	flex_stp_sr  #(8,1) shift_stp (.clk(clk),.n_rst(n_rst),.shift_enable(shift_enable),.serial_in(d_orig),.parallel_out(rcv_data));
	

endmodule
