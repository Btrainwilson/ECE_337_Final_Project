// $Id: $
// File name:   receiver.sv
// Created:     4/17/2018
// Author:      "Stan who drives a Ford."
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Receiver portion of USB transceiver (controller and receiver).
// 

module receiver
(
	input wire d_plus,  // USB high line
	input wire d_minus, // USB low line
	input wire fifo_ready, // ready flag from Jackson's FIFO
	input wire clk,
	input wire n_rst,
	input wire is_tx_active, // asserted from TXPU when TXPU is transmitting
    	output reg send_data, // control signal to the TXPU
    	output reg send_nak // control signal to TXPU
);
	wire fifo_empty;  // empty flag for fifo
	//wire fifo_ready;  // ready flag from Jackson's FIFO
	wire eop;	  // eop detection from usb_receiver
	wire [7:0] fifo_bus; // usb_receiver fifo output bus
	wire read_rcv_fifo; // controls the USB receiver FIFO read enable
	
	// RXPU *crosses arms*
	rxpu RXPU_OF_DESTINY(.clk(clk), .n_rst(n_rst), .is_tx_active(is_tx_active), .is_rcv_empty(fifo_empty),
			     .is_eop_rcvd(eop), .is_data_ready(fifo_ready), .rcv_bus(fifo_bus), 
				.read_rcv_fifo(read_rcv_fifo), .send_data(send_data), .send_nak(send_nak));

	// USB_RECEIVER
	usb_receiver USB_RECEIVER(.clk(clk), .n_rst(n_rst), .d_plus(d_plus), .d_minus(d_minus),
				.r_enable(read_rcv_fifo), .r_data(fifo_bus), .empty(fifo_empty), .eop(eop));
endmodule
