// $Id: $
// File name:   Packet_Storage.sv
// Created:     4/23/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Combined FIFO and Packet Processor Wrapper
`timescale 1ns / 10ps
module Packet_Storage (
	input wire w_clk,
	input wire r_clk,
	input wire n_rst,
	input wire Ethernet_In,
	input wire r_en,
	output reg ready,
	output reg empty,
	output reg [7:0] r_data


);

	//Busses
	reg full_flag;
	reg w_en;
	reg [7:0]E_Data_Bus;

Packet_Processor P_Processor
(
	.clk(w_clk),
	.n_rst(n_rst),
	.FULL(full_flag),
	.Ethernet_In(Ethernet_In),
	.w_enable(w_en),
	.E_Data(E_Data_Bus),
	.Ethernet_Out(E_Out)
);

output_buffer FIFO
(
	.w_clk(w_clk),
	.r_clk(r_clk),
	.n_rst(n_rst),
	.w_enable(w_en),
	.r_enable(r_en),
	.w_data(E_Data_Bus),
	.r_data(r_data),
	.ready(ready),
	.empty(empty),
	.full(full_flag)
);


endmodule
