// $Id: $
// File name:   Packet_Processor.sv
// Created:     4/7/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: packet processor full design

module Packet_Processor
(
	input 	wire clk,
		wire n_rst,
		wire FULL,
		wire Ethernet_In,
	output	wire w_enable,
		wire [7:0] E_Data,
		wire Ethernet_Out
);

	//Initial Stage
	assign Ethernet_Out = Ethernet_In;

	//Sync Stage
	reg Sync_Ether;

	sync_high Synchronizer (.clk(clk),.n_rst(n_rst),.async_in(Ethernet_In),.sync_out(Sync_Ether));

	//Decoder Stage
	reg e_orig;
	reg Sample;
	reg Shift_Enable;
	reg Idle;

	Decoder Manchester_Decoder(.clk(clk),.n_rst(n_rst),.Sample(Sample),.Shift_Enable(Shift_Enable),.e_orig(e_orig),.Sync_Ether(Sync_Ether),.Idle(Idle));

	//Edge Detector Stage
	reg d_edge;
	
	edge_detect Edge_Detector(.clk(clk),.n_rst(n_rst),.d_edge(d_edge),.d_plus(Sync_Ether));

	//Timer Stage
	reg reset;
	reg rcving;
	reg byte_received;

	Timer Timer_Control(.clk(clk),.n_rst(n_rst),.rcving(rcving),.reset(reset),.byte_received(byte_received),.d_edge(d_edge),.Sample(Sample),.Shift_Enable(Shift_Enable));

	//Counter Stage
	reg cnt_rst;
	reg [3:0] count;
	Counter Counter_Controller (.clk(clk),.n_rst(n_rst),.byte_received(byte_received),.cnt_rst(cnt_rst),.count(count));

	//Shift Register
	shift_register_2 Shift_Register(.clk(clk),.n_rst(n_rst),.shift_enable(Shift_Enable),.d_orig(e_orig),.rcv_data(E_Data));


	//ERCU Stage
	reg ERCU_w;

	ERCU ERCU_FSM(.clk(clk),.n_rst(n_rst),.d_edge(d_edge),.Idle(Idle),.E_Data(E_Data),.count(count),.ERCU_w(ERCU_w),.reset(reset),.cnt_rst(cnt_rst),.rcving(rcving));

	//w_enable logic

	assign w_enable = byte_received & ERCU_w &! FULL;
	


endmodule
