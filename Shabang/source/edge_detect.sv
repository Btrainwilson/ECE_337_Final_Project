// $Id: $
// File name:   edge_detect.sv
// Created:     2/16/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: edge_detector circuit 


module edge_detect
(
	input wire clk,
	input wire n_rst,
	input wire d_plus,
	output wire d_edge

);
	//Sampling Variables
	reg prev_sample;
	reg curr_sample;

	always @ (negedge n_rst, posedge clk)
		begin : REG_LOGIC
			if(1'b0 == n_rst)
			begin
				//Idle Phase
				prev_sample	<= 1'b1; 
				curr_sample	<= 1'b1; 
			end
			else
			begin
				//Edge Detection
				prev_sample <= curr_sample;
				curr_sample <= d_plus;
			end
		end

		assign d_edge = prev_sample ^ curr_sample;


endmodule
