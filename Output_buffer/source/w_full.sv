// $Id: $
// File name:   w_full.sv
// Created:     4/17/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: logic block used for write pointer, full, and ready flag logic
module w_full
(
	input wire w_en,
	input wire w_clk,
	input wire n_rst,
	input wire [7:0] r_count_sync,
	output reg full,
	//output reg ready,
	output reg [6:0] w_count,
	output reg [7:0] wptr
);

reg [7:0] w_binary;
wire [7:0] w_gray_n;
wire [7:0] w_binary_n;
wire full_n;
wire ready_n;

always @ (posedge w_clk, negedge n_rst) begin
	if(n_rst == 0) begin
		w_binary <= 0;
		wptr <= 0;
		full <= 1'b0;
		//ready <= 1'b0;
	end
	else begin
		w_binary <= w_binary_n;
		wptr <= w_gray_n;
		full <= full_n;
		//ready <= ready_n;
	end
end

assign w_binary_n = w_binary + (w_en & ~full);
assign w_gray_n = (w_binary_n >> 1) ^ w_binary_n;
assign w_count = w_binary[6:0];
//assign ready_n = 
assign full_n = ((w_gray_n[7] != r_count_sync[7]) && (w_gray_n[6] != r_count_sync[6]) & (w_gray_n[5:0] == r_count_sync[5:0]));


endmodule
