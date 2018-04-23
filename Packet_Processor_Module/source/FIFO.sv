// $Id: $
// File name:   FIFO.sv
// Created:     4/10/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: FIFO buffer for Ethernet-to-USB packet statisitc Collector
`timescale 1ns/10ps
module FIFO
(
	input wire w_clk,
	input wire r_clk,
	input wire n_rst,
	input wire w_enable,
	input wire r_enable,
	input wire [7:0] data_in,
	output reg [7:0] data_out,
	//output wire ready,
	output wire empty,
	output wire full
);


wire [6:0] w_count;
wire [6:0] r_count;
wire [7:0] wptr;
wire [7:0] rptr;
wire [7:0] r_count_sync;
wire [7:0] w_count_sync;

sync_rw RW (.r_count_sync(r_count_sync), .r_count(rptr), .w_clk(w_clk), .n_rst(n_rst));

sync_wr WR(.w_count_sync(w_count_sync), .w_count(wptr), .r_clk(r_clk), .n_rst(n_rst));

mem MEM (.w_en(w_enable), .w_clk(w_clk), .full(full), .w_count(w_count), .r_count(r_count), .data_in(data_in), .data_out(data_out));

w_full FL (.w_en(w_enable), .w_clk(w_clk), .n_rst(n_rst), .r_count_sync(r_count_sync), .full(full), .w_count(w_count), .wptr(wptr));

r_empty EM (.r_en(r_enable), .r_clk(r_clk), .n_rst(n_rst), .w_count_sync(w_count_sync), .empty(empty), .r_count(r_count), .rptr(rptr));

endmodule
