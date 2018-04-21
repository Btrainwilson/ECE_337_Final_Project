// $Id: $
// File name:   flex_counter.sv
// Created:     1/30/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Flexible and Scalable Counter with Controlled Rollover
module flex_counter
#(
	parameter NUM_CNT_BITS = 4
)
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,
	input wire [(NUM_CNT_BITS-1):0] rollover_val,
	output reg [(NUM_CNT_BITS-1):0] count_out,
	output reg rollover_flag
);

reg [(NUM_CNT_BITS-1):0] next;
reg next_flag;

always_ff @ (posedge clk, negedge n_rst)
begin
	if(n_rst == 0)
	begin
		count_out <= 0;
		rollover_flag <= 0;
	end
	else
	begin
		count_out <= next;
		rollover_flag <= next_flag;
	end
end

	always_comb
	begin	
		if (clear == 1) begin
			next = '0;
			next_flag = '0;
		end
		else begin
			if (count_enable == 0) begin
				next = count_out;
				next_flag = rollover_flag;
			end
			else begin
				next = count_out + 1;
				next_flag = 1'b0;
				if (count_out == rollover_val)
					next = 1;	
				if (next == rollover_val)
					next_flag = 1'b1;	
			end
		end
	end
endmodule						
