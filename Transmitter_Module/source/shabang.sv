// $Id: $
// File name:   shabang.sv
// Created:     4/23/2018
// Author:      "Stanford and Sons"
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: The whole shabang

module shabang
(
	input wire w_clk, // Ethernet Clock
	input wire r_clk, // USB Clock
	input wire n_rst,
	input wire Ethernet_In,  // Ethernet goes in, USB comes out
	input wire rx_d_plus,
	input wire rx_d_minus,

	output wire tx_d_plus,
	output wire tx_d_minus,
	output wire is_txing // transmission line used for output enable on USB
	
);
	wire r_en; // read enable for FIFO
	wire fifo_ready; // ready line for FIFO
	wire fifo_empty; // empty line for FIFO
	wire [7:0] r_data; // readline data from FIFO

	// Bring in the Packet_Storage (Ethernet and FIFO)
	Packet_Storage Ethernet_input(.w_clk(w_clk), .r_clk(r_clk), .n_rst(n_rst),
			.Ethernet_In(Ethernet_In), .r_en(r_en), .ready(fifo_ready),
			.empty(fifo_empty), .r_data(r_data));

	// Bring in the transceiver (USB)
	transceiver USB_output(.clk(r_clk), .n_rst(n_rst), .FIFO_byte(r_data),
				.fifo_ready(fifo_ready), .tx_d_plus(tx_d_plus),
				.tx_d_minus(tx_d_minus), .rx_d_plus(rx_d_plus),
				.rx_d_minus(rx_d_minus), .fifo_r_enable(r_en),
				.is_txing(is_txing));
	
	
	

endmodule