// $Id: $
// File name:   timer.sv
// Created:     2/21/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab6: Sample timer

module timer
	(
	input wire clk,
	input wire n_rst,
	input wire d_edge,
	input wire rcving,
	output wire shift_enable,
	output wire byte_received
	);
	wire [3:0] sampling_count;

	// Declare the two counters to be used.
	flex_counter #(.NUM_CNT_BITS(4)) samplingTimer (.clk(clk), .n_rst(n_rst), .clear(d_edge | ~rcving), .count_enable(rcving),
			.rollover_val(4'd8), .count_out(sampling_count), .rollover_flag());

	flex_counter #(.NUM_CNT_BITS(4)) sampleCount (.clk(clk), .n_rst(n_rst), .clear(~rcving | byte_received), .count_enable(shift_enable),
			.rollover_val(4'd8), .count_out(), .rollover_flag(byte_received));

	assign shift_enable = (sampling_count == 4'd3);

endmodule
