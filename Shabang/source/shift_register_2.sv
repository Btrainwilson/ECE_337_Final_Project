// $Id: $
// File name:   shift_register_2.sv
// Created:     4/23/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: new shift register for pp

module shift_register_2
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire d_orig,
	output wire [7:0] rcv_data

);

	flex_stp_sr  #(8,1) shift_stp (.clk(clk),.n_rst(n_rst),.shift_enable(shift_enable),.serial_in(d_orig),.parallel_out(rcv_data));
	

endmodule
