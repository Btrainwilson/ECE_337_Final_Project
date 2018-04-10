// $Id: $
// File name:   decode.sv
// Created:     2/18/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 6: USB decoder

module decode
	(
	input wire clk,
	input wire n_rst,
	input wire d_plus,
	input wire shift_enable,
	input wire eop,
	output reg d_orig
	);
	
	reg d_plus_sync;
	reg next_d_orig;
	reg nextinternal;
	reg internal;

	always_ff @(posedge clk, negedge n_rst)
	begin: REGISTERS
		if (n_rst == 0)
		begin
			d_plus_sync <= 1;
			internal <= 1;
			d_orig <= 1;
		end
		else
		begin
			d_plus_sync <= d_plus;
			internal <= nextinternal;
			d_orig <= next_d_orig; 
		end
	end

	always_comb
	begin: NEXT_STATE
		nextinternal = internal;
		next_d_orig = 0;
		if ((eop)&(shift_enable))
		begin
			nextinternal = 1;
			next_d_orig = 0; // I assume this is a don't care, but just to be redundant.
		end
		else if ((~eop) & (shift_enable))
		begin
			nextinternal = d_plus_sync;
			if (internal == d_plus_sync)
			begin
				next_d_orig = 1;
			end
			else
			begin
				next_d_orig = 0;
			end
		end
		else if (~shift_enable)
		begin
			if (internal != d_plus_sync)
			begin
				next_d_orig = 0;
			end
			else
			begin
				next_d_orig = 1;
			end

		end
	end


endmodule
