// $Id: $
// File name:   timer.sv
// Created:     2/22/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: timer block

module timer 
(
	input wire clk,
	input wire n_rst,
	input wire d_edge,
	input wire rcving,
	output reg shift_enable,
	output wire byte_received

);


	reg [3:0] back_count_bus;
	
	//Stage one of Flex Counter

	reg waste;


	flex_counter #(4) shift_timer 
	(
	.clk(clk),
	.n_rst(n_rst),
	.clear(d_edge),
	.count_enable(rcving),
	.rollover_val(4'd8),
	.count_out(back_count_bus),
	.rollover_flag(waste));

	always_comb
	begin
	if(back_count_bus == 4'd2)
			shift_enable = 1'b1;
		else
			shift_enable = 1'b0;
	
	end


	//Stage Two of Flex Counter
	flex_counter #(4) byte_counter 
	(
	.clk(clk),
	.n_rst(n_rst),
	.clear(~rcving),
	.count_enable(shift_enable),
	.rollover_val(4'd8),
	.rollover_flag(byte_received)
);


endmodule
