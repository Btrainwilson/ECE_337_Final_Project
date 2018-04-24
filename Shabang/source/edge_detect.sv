// $Id: $
// File name:   edge_detect.sv
// Created:     2/18/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 6: Edge Detector

module edge_detect
	(
	input wire clk,
	input wire n_rst,
	input wire d_plus,
	output wire d_edge
	);

	reg d_plus_sync;
	reg d_plus_sync_prev;

	always_ff @(posedge clk, negedge n_rst)
	begin: REGISTERS
		if(n_rst == 0)
		begin
			d_plus_sync <= 1;
			d_plus_sync_prev <= 1;
		end
		else
		begin
			d_plus_sync_prev <= d_plus_sync;			
			d_plus_sync <= d_plus;
			
		end
	end

	assign d_edge = (d_plus_sync ^ d_plus_sync_prev);
	
endmodule
