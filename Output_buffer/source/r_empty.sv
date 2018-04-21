// $Id: $
// File name:   r_empty.sv
// Created:     4/17/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: logic block for read pointer and empty-flag
module r_empty
(
	input wire r_clk,
	input wire n_rst,
	input wire r_en,
	input wire [7:0] w_count_sync,
	output reg empty,
	output reg [7:0] rptr,
	output reg [6:0] r_count
);

reg [7:0] r_binary;
wire [7:0] r_gray_n;
wire [7:0] r_binary_n;
wire empty_n;

always_ff @ (posedge r_clk, negedge n_rst) begin
	if(n_rst == 0) begin
		r_binary <= 0;
		rptr <= 0;
		empty <= 1'b1;
	end
	else begin
		r_binary <= r_binary_n;
		rptr <= r_gray_n;
		empty <= empty_n;
	end
end

assign r_count = r_binary[6:0];
assign r_binary_n = r_binary + (r_en & ~empty);
assign r_gray_n =  (r_binary_n >> 1) ^ r_binary_n;
assign empty_n = (r_gray_n == w_count_sync);

endmodule
