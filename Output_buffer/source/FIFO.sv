// $Id: $
// File name:   FIFO.sv
// Created:     4/10/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: FIFO buffer for Ethernet-to-USB packet statisitc Collector
module FIFO
(
	input wire w_clk,
	input wire r_clk,
	input wire n_rst,
	input wire w_enable,
	input wire r_enable,
	input wire [7:0] data_in,
	output wire [7:0] data_out,
	output wire ready,
	output wire empty,
	output wire full
);

reg [7:0] w_counter;
reg [7:0] r_counter;
reg [7:0] count;
