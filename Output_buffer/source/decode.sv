// $Id: $
// File name:   decode.sv
// Created:     2/19/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: decode block to remove NRZ encoding from incoming data
module decode
(
	input wire clk,
	input wire n_rst,
	input wire d_plus,
	input wire shift_enable,
	input wire eop,
	output wire d_orig
);

reg d_plus_curr;
reg d_plus_last;
reg next;


always_ff @ (posedge clk, negedge n_rst) begin
	if(n_rst == 0) begin
		d_plus_curr <= 1;
		d_plus_last <= 1;
	end
	else begin
		d_plus_curr <= d_plus;
		d_plus_last <= next;
	end
end

always_comb begin
	if(shift_enable == 1) begin
		if(eop == 1) begin
			next = 1;
		end
		else begin
			next = d_plus;
		end
	end
	else begin
		next = d_plus_last;
	end	
end

assign d_orig = ~(d_plus_curr ^ d_plus_last);
endmodule
