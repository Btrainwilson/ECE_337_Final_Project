// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/28/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: flexible shift register
`timescale 1ns / 100ps
module flex_stp_sr
#(
	parameter NUM_BITS = 4,
	parameter SHIFT_MSB = 1

)
(
	input reg clk,
	input reg n_rst,
	input reg shift_enable,
	input reg serial_in,
	output reg [NUM_BITS - 1:0]parallel_out
);



			genvar i;
			generate
				if(1 == SHIFT_MSB)begin
					
					always_ff @ (posedge clk, negedge n_rst)
									
								begin
								if(1'b0 == n_rst)
									begin
										parallel_out[0] <= 1'b1;
									end
								else
									begin
										if(1'b1 == shift_enable)
											begin
												parallel_out[0] <= serial_in;
											end

										else
											begin
												parallel_out[0] <= parallel_out[0];
											end

									end
								end

						

					//Generate the rest				

					for(i = 1; i <= (NUM_BITS - 1); i = i + 1)
						begin


							always_ff @ (posedge clk, negedge n_rst)
								begin
								if(1'b0 == n_rst)
									begin
										parallel_out[i] <= 1'b1;
									end
								else
									begin
										if(1'b1 == shift_enable)
											begin
												parallel_out[i] <= parallel_out[i-1];
											end

										else
											begin
												parallel_out[i] <= parallel_out[i];
											end

									end
								end

						end
				end else begin

					always_ff @ (posedge clk, negedge n_rst)
								begin
								if(1'b0 == n_rst)
									begin
										parallel_out[NUM_BITS - 1] <= 1'b1;
									end
								else
									begin
										if(1'b1 == shift_enable)
											begin
												parallel_out[NUM_BITS - 1] <= serial_in;
											end

										else
											begin
												parallel_out[NUM_BITS - 1] <= parallel_out[NUM_BITS - 1];
											end

									end
								end

						

					//Generate the rest				

					for(i = (NUM_BITS - 2); i >= 0 ; i = i - 1)
						begin


							always_ff @ (posedge clk, negedge n_rst)
								begin
								if(1'b0 == n_rst)
									begin
										parallel_out[i] <= 1'b1;
									end
								else
									begin
										if(1'b1 == shift_enable)
											begin
												parallel_out[i] <= parallel_out[i+1];
											end

										else
											begin
												parallel_out[i] <= parallel_out[i];
											end

									end
								end

						end




				

				end
			
			endgenerate

endmodule

// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/28/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: flexible shift register
/*
module flex_stp_sr1
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire serial_in,
	output reg parallel_out
);

	always_ff @ (posedge clk, negedge n_rst)
		begin
		if(1'b0 == n_rst)
			begin
				parallel_out <= 1'b1;
			end
		else
			begin
				if(1'b1 == shift_enable)
					begin
						parallel_out <= serial_in;
					end

				else
					begin
						parallel_out <= parallel_out;
					end

			end
		end

endmodule

reg [5:0] parallel_out;
wire serial_in;

assign temp = {serial_in, parallel_out[5:1]}


parallel_out <= temp*/
