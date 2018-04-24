// $Id: $
// File name:   Timer.sv
// Created:     4/7/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Timer for Processor
`timescale 1ns / 10ps
module Timer
(

	input 	wire clk,
	input	wire n_rst,
	input	wire d_edge,
	input	wire rcving,
	input	wire reset,
	output 	reg byte_received,
	output	reg Shift_Enable,
	output	reg Sample

);
	//Sample Generator
	reg [2:0]c_out;
	reg roll_sample;

	flex_counter #(.NUM_CNT_BITS(3)) Sample_Generator(.clk(clk),.n_rst(n_rst),.clear(d_edge),.count_enable(rcving),.rollover_val(3'b101),.count_out(c_out),.rollover_flag(roll_sample));
	
	always_comb begin
	if((c_out == 3'b000) || (roll_sample))
		Sample = 1;
	else
		Sample = 0;

	end

	//Shift Enable Generator
	reg s_clr;
	reg [1:0]s_out;

	//Assignment for input
	//reg false_shift;
	//assign Shift_Enable = (c_out == 3'b001 ? 1 : 0) & !false_shift;
	always_comb begin
	s_clr = reset || Shift_Enable;
	end

	flex_counter #(.NUM_CNT_BITS(2)) Shift_Enable_Generator (.clk(clk),.n_rst(n_rst),.clear(s_clr),.count_enable(Sample),.count_out(s_out),.rollover_val(2'b10),.rollover_flag(Shift_Enable));

	//Bit Counter
	reg b_clr;
	reg [3:0]b_out;
	always_comb begin
	b_clr = reset || byte_received;
	end
	flex_counter #(.NUM_CNT_BITS(4)) Bit_Counter (.clk(clk),.n_rst(n_rst),.clear(b_clr),.count_enable(Shift_Enable),.count_out(b_out),.rollover_val(4'b1000),.rollover_flag(byte_received));

	



endmodule
