// $Id: $
// File name:   transceiver.sv
// Created:     4/22/2018
// Author:      "Stan who drives a Ford"
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB transceiver

module transceiver
(
	input wire clk,
	input wire n_rst,
	input wire [7:0] FIFO_byte,
	input wire fifo_ready,  // ready flag from Jackson's FIFO

	output tri1 d_plus,
	output tri1 d_minus,	
	//output reg d_plus,
	//output reg d_minus,
	output wire fifo_r_enable,
	output wire is_txing // For testbenches, allows interaction between transceiver
	// and testbench "transceiver"	
);
	wire send_nak; // RX line that tells TX to send nak
	wire send_data; // RX line that tells TX to send data
	reg tx_d_plus; // TX d_plus line
	wire tx_d_minus;	// TX d_minus line
	reg rx_d_plus;	// RX d_plus line
	wire rx_d_minus; // RX d_minus line
	
	// Transmitter
	transmitter TX(.clk(clk), .n_rst(n_rst), .send_nak(send_nak),
		       .send_data(send_data), .FIFO_byte(FIFO_byte),
			.fifo_r_enable(fifo_r_enable), .is_txing(is_txing),
			.d_plus(tx_d_plus), .d_minus(tx_d_minus));

	// Receiver
	receiver RX(.clk(clk), .n_rst(n_rst), .d_plus(rx_d_plus),
		    .d_minus(rx_d_minus), .fifo_ready(fifo_ready),
		    .is_tx_active(is_txing), .send_data(send_data),
		    .send_nak(send_nak)
		    );

	// Tri-state bus

	// d_plus side
	assign d_plus = (is_txing) ? tx_d_plus : 1'bz;
	assign rx_d_plus = d_plus;
	
	//always @ (is_txing)
	//begin
	//	if (is_txing == 1)
	//	begin
	//		d_plus = tx_d_plus;
	//	end
	//	else
	//	begin
	//		d_plus = 'bz;
	//	end
	//end

	//assign rx_d_plus = d_plus & !(is_txing);

	// d_minus side
	assign d_minus = (is_txing) ? tx_d_minus : 1'bz;
	assign rx_d_minus = d_minus;

	//always @ (is_txing)
	//begin
	//	if (is_txing == 1)
	//	begin
	//		d_minus = tx_d_minus;
	//	end
	//	else
	//	begin
	//		d_minus = 'bz;
	//	end
	//end

	assign rx_d_minus = d_minus & !(is_txing);


endmodule
