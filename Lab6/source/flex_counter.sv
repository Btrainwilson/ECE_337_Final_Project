// $Id: $
// File name:   flex_counter.sv
// Created:     1/25/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 3: 5.1: Flexible size counte


module flex_counter
	#(
	parameter NUM_CNT_BITS = 4
	)
	(
	input wire clk, n_rst, clear, count_enable,
	input wire [NUM_CNT_BITS - 1: 0] rollover_val,
	output reg [NUM_CNT_BITS - 1: 0] count_out,
	output reg rollover_flag
	);

	reg [NUM_CNT_BITS - 1: 0] next_count=0;
	reg next_flag=0;

	// Register setup
	always_ff @(posedge clk, negedge n_rst)
	begin: 				Register
		if (n_rst == 1'b0)
		begin
			count_out <= 0;
			rollover_flag <= 0;
		end
		else
		begin
			count_out <= next_count;
			rollover_flag <= next_flag;
		end
	end	

	// Counter Logic
	always_comb
	begin: 				Counter
		//next_count = 0;
		//next_flag = 0;
		if (clear == 1'b1)
		begin
			next_count = 0;
			//next_flag = 0;
		end
		
		else if (count_enable == 1'b1)
		begin
			//next_count = count_out + 1;
			if (count_out >= rollover_val)
			begin
				next_count = 1;
			end
			else
			begin
				next_count = count_out + 1;
			end
				
		end
		else
		begin
			next_count = count_out;
		end
		/*if ((count_out == rollover_val))
		begin
			next_flag = 1;
		end
		else
		begin
			next_flag = 0;
		end*/
	end

	// Flag logic
	always_comb
	begin: FLAG
		//next_flag = 0;
		//next_count = 0;
		if(count_enable == 1)
		begin
			if (next_count >= (rollover_val))
				begin
					next_flag = 1;
				end
				else
				begin
					next_flag = 0;
				end
		end
		else
		begin
			if ((count_out == rollover_val) && ~clear)  // MOD NOTE: 2/21 added the not clear condition for sampling counters
			begin
				next_flag = 1;
			end
			else
			begin
				next_flag = 0;
			end
		end
	end

endmodule
