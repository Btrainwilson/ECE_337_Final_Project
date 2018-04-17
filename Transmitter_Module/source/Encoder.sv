// $Id: $
// File name:   Encoder.sv
// Created:     4/10/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB Transmittion Encoder

module Encoder
(
	input 	wire Data_In,
		wire clk,
		wire n_rst,
		wire eop,
		wire idle,
		wire new_bit, // shift_enable, notifies encoder that a stable bit is ready for "latching/broadcasting"
	output	reg d_plus,
		reg d_minus
);		// to operate from FSM: 1) Enable timer and load byte
		//			2) Let bit propogate through stuffer
		//			3) Turn idle off, new_bit on
		//			4) First encoded bit should show up at this clock cycle.
	reg next_d_plus;
	reg next_d_minus;

	always_ff @(posedge clk, negedge n_rst)
	begin: Encoder_Logic
		if(n_rst == 1'b0) begin
			d_plus <= 1'b1;
			d_minus <= 1'b0;
		end
		else begin
			d_plus <= next_d_plus;
			d_minus <= next_d_minus;
		end
	end

	always_comb
	begin:  NEXT_STATE
		next_d_plus = d_plus;
		next_d_minus = d_minus; // Avoid latches
		
		if(idle == 1'b1)
		begin
			next_d_plus = 1'b1;
			next_d_minus = 1'b0;
		end
		else
		begin
			if (eop == 1)
			begin
				next_d_plus = 1'b0;
				next_d_minus = 1'b0;
			end
			else
			begin
				if (Data_In == 0 & new_bit)
				begin
					next_d_plus = !d_plus;
					next_d_minus = !d_minus;
				end
			end
		end
		
	end
	


endmodule
