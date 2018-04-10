// $Id: $
// File name:   edge_detect.sv
// Created:     2/19/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Edge Detector Block for USB reciever
module edge_detect
(
	input wire clk,
	input wire n_rst,
	input wire d_plus,
	output wire d_edge
);

reg d_plus_curr = 1;
reg d_plus_last = 1;

always_ff @ (posedge clk, negedge n_rst) begin
	if(n_rst == 0) begin
		d_plus_curr <= 1;
		d_plus_last <= 1;
	end
	else begin
		d_plus_curr <= d_plus;
		d_plus_last <= d_plus_curr;
	end
end

assign d_edge = (d_plus_curr != d_plus_last) ? 1'b1 : 1'b0;
endmodule
