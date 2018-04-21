// $Id: $
// File name:   transmitter.sv
// Created:     4/20/2018
// Author:      "Stan who drives a Ford"
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Transmitter portion of USB transceiver.

module transmitter
(
	input wire clk,
	input wire n_rst,
	input wire send_nak, // From receiver with love
	input wire send_data, // From receiver with love
	input wire [7:0] FIFO_byte,  // From FIFO with love
	
	output wire fifo_r_enable,	// Tells fifo to move on to next value in storage
	output wire is_txing, // Tells receiver that transmitter is transmitting, LINE ENABLE
	output wire d_plus,  // USB out
	output wire d_minus  // USB out
);
	// Signal wires
	wire Load_Byte;  // From byte transmitter, signals 1 byte sent
	reg [7:0] FSM_byte; // TXPU ready-to-go bytes
	wire EOD; // From Byte transmitter, signals 64 bytes are sent
	reg load_en; // Load enable for the byte transmitter
	reg select; // Mux selector for the byte transmitter chooses whether to send FIFO
			// or TXPU byte
	reg Tim_rst; // Resets timer's internal 64-byte counter
	reg Tim_en; // Enables the timer to transmit
	reg eop; // This Signal...
	reg eop_new_bit; // ...and this one need to be asserted to send EOP
	reg calc_crc; // Tells CRC module to calculate CRC on current data streaming over
	reg send_crc; // Tells CRC module to transmit its calculated CRC through the bitstuffer
	

	// Bring in the txpu
	txpu Controller(.clk(clk), .n_rst(n_rst), .Load_Byte(Load_Byte),
			.send_nak(send_nak), .send_data(send_data), .EOD(EOD),
			.FSM_byte(FSM_byte), .load_en(load_en), .select(select),
			.Tim_rst(Tim_rst), .Tim_en(Tim_en), .eop(eop),
			.eop_new_bit(eop_new_bit), .calc_crc(calc_crc),
			.send_crc(send_crc), .is_txing(is_txing), 
			.fifo_r_enable(fifo_r_enable));

	// Bring in the byte_transmitter
	byte_transmitter Pipeline(.clk(clk), .n_rst(n_rst), .FSM_byte(FSM_byte),
				.FIFO_byte(FIFO_byte), .load_en(load_en),
				.select(select), .idle(!is_txing), .Tim_rst(Tim_rst),
				.Tim_en(Tim_en), .eop(eop), .eop_new_bit(eop_new_bit),
				.d_plus(d_plus), .d_minus(d_minus), .Load_Byte(Load_Byte),
				.EOD(EOD));
			
endmodule