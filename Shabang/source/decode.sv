// $Id: $
// File name:   decode.sv
// Created:     2/13/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Decode Block


module decode 
(
	input wire clk,
	input wire n_rst,
	input wire d_plus,
	input wire shift_enable,
	input wire eop,
	output reg d_orig
);
	reg stored;
	wire out_d_orig;

	//Register for Decode Block
	always_ff @ (posedge clk, negedge n_rst)
		begin
			if(1'b0 == n_rst)begin
				stored <= 1'b1;
				d_orig <= 1'b1;
			end
			else begin
				if(eop & shift_enable) begin
					stored <= 1'b1;
				end
				else if(shift_enable) begin
					stored <= d_plus;
				end
					d_orig <= out_d_orig;
			end
		end

	assign out_d_orig = ~(stored ^ d_plus);



endmodule
