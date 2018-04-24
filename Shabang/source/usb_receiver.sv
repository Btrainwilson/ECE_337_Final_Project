// $Id: $
// File name:   usb_receiver.sv
// Created:     2/13/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB top level design

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
	//Synchronizer Inputs
	wire d_plus_sync;
	wire d_minus_sync;

	sync_high sync_d_plus (.clk(clk),.n_rst(n_rst),.async_in(d_plus),.sync_out(d_plus_sync));
	sync_high sync_d_minus(.clk(clk),.n_rst(n_rst),.async_in(d_minus),.sync_out(d_minus_sync));

	//Decoder
	wire shift_enable_bus;
	wire eop_bus;
	wire d_orig_bus;

	decode Decode_Block (.clk(clk),.n_rst(n_rst),.d_plus(d_plus_sync),.shift_enable(shift_enable_bus),.eop(eop_bus),.d_orig(d_orig_bus));
	//EOP Detector

	eop_detect EOP_DETECT_BLOCK
(
	.d_plus(d_plus_sync),
	.d_minus(d_minus_sync),
	.eop(eop_bus)
);

	//Timer
	wire d_edge_bus;
	wire byte_received_bus;
	
	timer Timer_Block (.clk(clk),.n_rst(n_rst),.rcving(rcving),.shift_enable(shift_enable_bus),.d_edge(d_edge_bus),.byte_received(byte_received_bus));

	//D Edge detector

	edge_detect D_EDGE_Block
(
	.clk(clk),
	.n_rst(n_rst),
	.d_plus(d_plus_sync),
	.d_edge(d_edge_bus)

);

	//Shift Register

	wire [7:0] rcv_data_bus;
	
	shift_register Shift_Reg_Block(.clk(clk),.n_rst(n_rst),.d_orig(d_orig_bus),.rcv_data(rcv_data_bus),.shift_enable(shift_enable_bus));

	//RCU Controller
	wire w_enable_bus;

	rcu RCU_Block (.clk(clk),.n_rst(n_rst),.rcv_data(rcv_data_bus),.eop(eop_bus),.d_edge(d_edge_bus),.shift_enable(shift_enable_bus),.w_enable(w_enable_bus),.byte_received(byte_received_bus),.rcving(rcving),.r_error(r_error));

	//rx_fifo
	rx_fifo FIFO_Block(.clk(clk),.n_rst(n_rst),.r_enable(r_enable),.w_enable(w_enable_bus),.w_data(rcv_data_bus),.r_data(r_data),.empty(empty),.full(full));

endmodule 
