// $Id: $
// File name:   usb_receiver.sv
// Created:     2/21/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: .

module usb_receiver
	(
	input wire clk,
	input wire n_rst,
	input wire d_plus,
	input wire d_minus,
	input wire r_enable,
	output wire [7:0] r_data,
	output wire empty,
	output wire full,
	output wire rcving,
	output wire r_error
	);
	// Internal ports
	wire d_plus_sync;
	wire d_minus_sync;
	wire eop;
	wire shift_enable;
	wire d_orig;
	wire d_edge;
	wire byte_received;
	wire [7:0] rcv_data;
	wire w_enable;
	

	// Module declarations

	// d_plus synchronizer
	sync high (.clk(clk), .n_rst(n_rst), .async_in(d_plus), .sync_out(d_plus_sync));

	// d_minus synchronizer
	sync low (.clk(clk), .n_rst(n_rst), .async_in(d_minus), .sync_out(d_minus_sync));

	// EOP detector
	eop_detect EOPDETECTOR (.d_plus(d_plus_sync), .d_minus(d_minus_sync), .eop(eop));

	// Decoder
	decode DECODER(.clk(clk), .n_rst(n_rst), .d_plus(d_plus_sync), .shift_enable(shift_enable), .eop(eop), .d_orig(d_orig));

	// EDGE DETECTOR
	edge_detect EDGEDETECTOR (.clk(clk), .n_rst(n_rst), .d_plus(d_plus_sync), .d_edge(d_edge));

	// TIMER
	timer SAMPLETIMER (.clk(clk), .n_rst(n_rst), .d_edge(d_edge), .rcving(rcving), .shift_enable(shift_enable), 
			.byte_received(byte_received));

	// SHIFTREG
	shift_register SHIFTREG(.clk(clk), .n_rst(n_rst), .shift_enable(shift_enable), .d_orig(d_orig), .rcv_data(rcv_data));

	// RCU
	rcu CONTROLLER(.clk(clk), .n_rst(n_rst), .d_edge(d_edge), .eop(eop), .shift_enable(shift_enable), .rcv_data(rcv_data),
			.byte_received(byte_received), .rcving(rcving), .w_enable(w_enable), .r_error(r_error));

	// FIFO
	rx_fifo FIFO(.clk(clk), .n_rst(n_rst), .r_enable(r_enable), .w_enable(w_enable), .w_data(rcv_data), .r_data(r_data), 
			.empty(empty), .full(full));
endmodule
