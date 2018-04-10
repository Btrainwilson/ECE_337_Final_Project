// $Id: $
// File name:   Decoder
// Created:     4/7/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Manchester Decoder

module Decoder 
(
	input 	wire Sync_Ether,
		wire Sample,
		wire Shift_Enable,
		wire clk,
		wire n_rst,
	output	wire e_orig,
		reg Idle
);


	reg prev_sample;
	reg new_sample;
	reg p_idle;
	
	//REDO: MORE INTUITION

	//Register for Manchester Decoder
	always_ff @ (posedge clk, negedge n_rst)
		begin
			if(1'b0 == n_rst)begin
				prev_sample <= 0;
				new_sample <= 0;
			end
			else begin
				if(Sample == 1)begin
					prev_sample <= new_sample;
					new_sample <= Sync_Ether;
				end

				Idle <= p_idle;
			end
		end

	//Output Values
	assign e_orig = new_sample;
	assign p_idle = new_sample & Shift_Enable & prev_sample;




endmodule
