// $Id: $
// File name:   tb_shabang.sv
// Created:     4/23/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Shabang full test bench
`timescale 1ns / 10ps
module tb_shabang();

//Inputs to shabang
	reg tb_w_clk; // Ethernet Clock
	reg tb_r_clk; // USB Clock
	reg tb_n_rst;
	reg tb_Ethernet_In; // Ethernet goes in, USB comes out
	reg tb_rx_d_plus;
	reg tb_rx_d_minus;

	reg tb_tx_d_plus;
	reg tb_tx_d_minus;
	reg tb_is_txing; // transmission line used for output enable on USB

	shabang Full_Design(.w_clk(tb_w_clk),.r_clk(tb_r_clk),.n_rst(tb_n_rst),	.Ethernet_In(tb_Ethernet_In),.rx_d_plus(tb_rx_d_plus),.rx_d_minus(tb_rx_d_minus),.tx_d_plus(tb_tx_d_plus),.tx_d_minus(tb_d_minus),.is_txing(tb_is_txing));

endmodule
