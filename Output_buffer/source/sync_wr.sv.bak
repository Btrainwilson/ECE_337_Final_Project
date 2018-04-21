// $Id: $
// File name:   sync_wr.sv
// Created:     4/17/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: module used to synchronize write pointer to read clock domain to generate empty condition to FIFO
module sync_wr
(
	input wire r_clk,
	input wire n_rst,
	input wire [7:0] w_count,
	output reg [7:0] w_count_sync
);

reg [7:0] Q1;

always @ (posedge r_clk, negedge n_rst) begin
	if(n_rst == 0) begin
		Q1 <= 0;
		w_count_sync <= 0;
	end
	else begin
		Q1 <= w_count;
		w_count_sync <= Q1;
	end
end
endmodule
