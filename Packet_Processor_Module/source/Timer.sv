// $Id: $
// File name:   Timer.sv
// Created:     4/7/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Timer for Processor

module Timer
(

	input 	wire clk,
		wire n_rst,
		wire d_edge,
		wire rcving,
		wire reset,
	output 	wire byte_received,
		wire Shift_Enable,
		wire Sample

);
	//Sample Generator
	wire [2:0]c_out;
	wire roll_sample;

	flex_counter #(.NUM_CNT_BITS(3)) Sample_Generator(.clk(clk),.n_rst(n_rst),.clear(d_edge),.count_enable(rcving),.rollover_val(3'b101),.count_out(c_out),.rollover_flag(roll_sample));

	assign Sample = (roll_sample | (c_out == 3'b000 ? 1 : 0));

	//Shift Enable Generator
	wire s_clr;
	wire [1:0]s_out;

	//Assignment for input
	//reg false_shift;
	//assign Shift_Enable = (c_out == 3'b001 ? 1 : 0) & !false_shift;
	assign s_clr = reset | Shift_Enable;
	

	flex_counter #(.NUM_CNT_BITS(2)) Shift_Enable_Generator (.clk(clk),.n_rst(n_rst),.clear(s_clr),.count_enable(Sample),.count_out(s_out),.rollover_val(2'b10),.rollover_flag(Shift_Enable));

	//Bit Counter
	wire b_clr;
	wire [3:0]b_out;
	assign b_clr = reset | byte_received;

	flex_counter #(.NUM_CNT_BITS(4)) Bit_Counter (.clk(clk),.n_rst(n_rst),.clear(b_clr),.count_enable(Shift_Enable),.count_out(b_out),.rollover_val(4'b1000),.rollover_flag(byte_received));

	



endmodule
