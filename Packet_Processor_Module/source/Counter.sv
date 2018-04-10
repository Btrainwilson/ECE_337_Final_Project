// $Id: $
// File name:   Counter.sv
// Created:     4/7/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Counter for Bytes

module Counter
(
	input 	wire clk,
		wire n_rst,
		wire byte_received,
		wire cnt_rst,
	output  wire [3:0] count

);

	flex_counter #(4) counter (.clk(clk),.n_rst(n_rst),.count_out(count),.rollover_val(4'b1111),.count_enable(byte_received),.clear(cnt_rst));


endmodule
