// $Id: $
// File name:   flex_counter.sv
// Created:     1/30/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: flexible counter

module flex_counter
#(
	parameter NUM_CNT_BITS = 4
)
(
	input reg clk,
	input reg n_rst,
	input reg clear,
	input reg count_enable,
	input reg [NUM_CNT_BITS-1:0]rollover_val,
	output reg [NUM_CNT_BITS-1:0]count_out,
	output reg rollover_flag 
	

);
	always_ff @ (posedge clk, negedge n_rst)
		begin
		if(1'b0 == n_rst)begin
			//Reset Asynchronously 
			count_out = 0;
			rollover_flag = 0;
		end
		else
			if(clear)
				begin
					//Reset synchronously
					count_out = 0;
					rollover_flag = 0;
				end
			else if(count_enable)
				begin
					count_out = count_out + 1;
					if(count_out == rollover_val + 1)begin
						count_out = 1;
						rollover_flag = 0;
					end
					else if(count_out == rollover_val)begin
						rollover_flag = 1;
					end else begin
						rollover_flag = 0;
					end

						

				end
			else
				count_out = count_out;
		end


endmodule
