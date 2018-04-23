// $Id: $
// File name:   sync_rw.sv
// Created:     4/17/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: synchronize the read pointer to the write clock domain to be used to generate full condition of FIFO
module sync_rw
(
	input wire w_clk,
	input wire n_rst,
	input wire [7:0] r_count,
	output reg [7:0] r_count_sync
);

reg [7:0] Q1;

always_ff @ (posedge w_clk, negedge n_rst) begin
	if(n_rst == 0) begin
		Q1 <= 0;
		r_count_sync <= 0;
	end
	else begin
		Q1 <= r_count;
		r_count_sync <= Q1;
	end
end
endmodule
