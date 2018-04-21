// $Id: $
// File name:   flex_pio_si.sv
// Created:     4/20/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Flexible Parallel in and out with serial in
`timescale 1ns / 10ps
module flex_pio_si
#(
	parameter NUM_BITS = 4

)
(
	input reg clk,			// !
	input reg n_rst,		// !
	input reg shift_enable,		//Shifts all values to the left
	input reg s_reset,
	input reg serial_in,
	input reg load_enable,
	input reg [NUM_BITS - 1:0]parallel_in,
	output reg [NUM_BITS - 1:0] parallel_out,
	output reg serial_out
);
	reg [NUM_BITS - 1: 0] tmp_reg;
	always_comb begin
	parallel_out = {serial_out , tmp_reg[NUM_BITS - 2: 0]};
	end

	genvar i;
		generate
		//Create Last One
		always_ff @ (posedge clk, negedge n_rst)						
			begin
			if(1'b0 == n_rst)
				begin
					serial_out <= 1'b0;
					tmp_reg[0] <= 1'b0;
				end
			else
				begin
					if(load_enable == 1'b1)begin
						serial_out <= parallel_in[NUM_BITS - 1];
						tmp_reg[0] <= parallel_in[0];

					end else if(shift_enable == 1'b1) begin
						serial_out <= tmp_reg[NUM_BITS - 2];
						tmp_reg[0] <= serial_in;
						
					end  else if(s_reset == 1'b1) begin
						tmp_reg[0] <= 1'b0;
						
					end

				end
			end
			
			for(i = (NUM_BITS - 2); i >= 1 ; i = i - 1)
						begin


							always_ff @ (posedge clk, negedge n_rst)
								begin
								if(1'b0 == n_rst)
									begin
										tmp_reg[i] <= 1'b0;
									end
								else
									begin
										if(load_enable == 1'b1)begin
											tmp_reg[i] <= parallel_in[i];

										end else if(shift_enable == 1'b1) begin
											tmp_reg[i] <= tmp_reg[i - 1];
						
										end else if(s_reset == 1'b1) begin
											tmp_reg[i] <= 1'b0;
						
										end

									end
								end

						end

endgenerate

	


endmodule
