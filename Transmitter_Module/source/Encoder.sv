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
		wire new_bit,
	output	reg d_plus,
		reg d_minus
);

	always_ff @(posedge clk, negedge n_rst)
	begin: Encoder_Logic
		if(n_rst == 1'b0) begin
			d_plus <= 1'b1;
			d_minus <= 1'b0;
		end
		else if(new_bit == 1) begin
			if(eop == 1) begin
				d_plus <= 1'b0;
				d_minus <= 1'b0;
			end else
				if(Data_In == 0) begin
					d_plus <= !d_plus;
					d_minus <= !d_plus;
				end
			end
		end
	end


endmodule
