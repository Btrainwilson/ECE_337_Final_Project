// $Id: $
// File name:   byte_transmitter.sv
// Created:     4/16/2018
// Author:      "Stan who drives a Ford"
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Module for complete byte transmission

module byte_transmitter
(
	input wire clk,
	input wire n_rst,
	input wire [7:0] FSM_byte, // byte from FSM
	input wire [7:0] FIFO_byte, // byte from FIFO
	input wire load_en, 	//Loads the mux_byte into the parallel to serial register
	input reg select,			//0 = FIFO_byte, 1 = FSM byte
	input wire idle,			// Sync Idle switch for encoder
	input wire Tim_rst,			// Timer sync reset
	input wire Tim_en,			// Timer sync enable
	input wire eop,				// Encoder eop
	output wire d_plus,
	output wire d_minus,
	output wire Load_Byte,			// Indicates that a byte is completed
	output wire [7:0] byte_out,		// Number of bytes broadcasted by device in 64 byte burst
	output wire EOD				// Rollover flag signaling that 64 bytes have been broadcast
	
	
);
	wire shift_enable; // Tells byte_register to shift, also tells timer to increment bit counter in a byte by 1
	wire to_stuffer; // Connects register output to stuffer input
	wire new_bit;  // Timer indicator that 8 clock pulses have passed
	wire to_encoder; // Raw value from bit-stuffer to encoder

	// Import Byte_register
	Byte_Register incoming_byte(.clk(clk), .n_rst(n_rst), .load_en(load_en), .shift_enable(shift_enable),
			.select(select), .FSM_byte(FSM_byte), .FIFO_byte(FIFO_byte), .out_bit(to_stuffer));
	
	// Import timer
	USB_Timer  TX_timer(.clk(clk), .n_rst(n_rst), .bit_sent(shift_enable), .Tim_rst(Tim_rst), .Tim_en(Tim_en),
			.new_bit(new_bit), .byte_out(byte_out), .EOD(EOD), .Load_Byte(Load_Byte));

	// Import Bit Stuffer
	bit_stuff bit_stuffer(.clk(clk), .n_rst(n_rst), .send_next_bit(new_bit), .data_bit(to_stuffer),
				.Tim_en(Tim_en), .raw_to_encoder(to_encoder), .shift_enable(shift_enable));

	// Import Encoder
	Encoder TX_encode(.clk(clk), .n_rst(n_rst), .Data_In(to_encoder), .eop(eop), .idle(idle), .d_plus(d_plus),
			.d_minus(d_minus)); 

endmodule
