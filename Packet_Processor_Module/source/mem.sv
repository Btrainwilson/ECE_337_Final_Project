// $Id: $
// File name:   mem.sv
// Created:     4/17/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: memory for the FIFO block
module mem
(
	input wire w_en,
	input wire w_clk,
	input wire full,
	input wire [6:0] w_count,
	input wire [6:0] r_count,
	input wire [7:0] data_in,
	output wire [7:0] data_out
);

reg [7:0] array [0:127];

always_ff @ (posedge w_clk) begin
	if((w_en == 1) && (full == 0)) begin
		array[w_count] <= data_in;
	end
end 

assign data_out = array[r_count];

endmodule
