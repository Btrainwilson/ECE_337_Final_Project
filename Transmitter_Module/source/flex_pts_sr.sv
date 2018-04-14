// $Id: $
// File name:   flex_pts_sr.sv
// Created:     1/30/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: parallel to serial

module flex_pts_sr
#(
	parameter NUM_BITS = 4,
	parameter SHIFT_MSB = 1

)
(
	input reg clk,			// !
	input reg n_rst,		// !
	input reg shift_enable,
	output reg serial_out,
	input reg load_enable,
	input reg [NUM_BITS - 1:0]parallel_in
);
	reg [NUM_BITS - 1: 0] tmp_reg;
	genvar i;
		generate
	if(1 == SHIFT_MSB) begin
		//Create Last One
		always_ff @ (posedge clk, negedge n_rst)						
			begin
			if(1'b0 == n_rst)
				begin
					serial_out <= 1'b1;
					tmp_reg[0] <= 1'b1;
				end
			else
				begin
					if(load_enable == 1'b1)begin
						serial_out <= parallel_in[NUM_BITS - 1];
						tmp_reg[0] <= parallel_in[0];

					end else if(shift_enable == 1'b1) begin
						serial_out <= tmp_reg[NUM_BITS - 2];
						tmp_reg[0] <= 1'b1;
						
					end

				end
			end
			

		
		
			for(i = (NUM_BITS - 2); i >= 1 ; i = i - 1)
						begin


							always_ff @ (posedge clk, negedge n_rst)
								begin
								if(1'b0 == n_rst)
									begin
										tmp_reg[i] <= 1'b1;
									end
								else
									begin
										if(load_enable == 1'b1)begin
											tmp_reg[i] <= parallel_in[i];

										end else if(shift_enable == 1'b1) begin
											tmp_reg[i] <= tmp_reg[i - 1];
						
										end

									end
								end

						end

		
	end else begin

		//Create Last One
		always_ff @ (posedge clk, negedge n_rst)						
			begin
			if(1'b0 == n_rst)
				begin
					serial_out <= 1'b1;
					tmp_reg[NUM_BITS - 1] <= 1'b1;
				end
			else
				begin
					if(load_enable == 1'b1)begin
						serial_out <= parallel_in[0];
						tmp_reg[NUM_BITS - 1] <= parallel_in[NUM_BITS - 1];

					end else if(shift_enable == 1'b1) begin
						serial_out <= tmp_reg[1];
						tmp_reg[NUM_BITS - 1] <= 1'b1;
						
					end

				end
			end


		
			for(i = 1; i <= NUM_BITS - 2 ; i = i + 1)
						begin


							always_ff @ (posedge clk, negedge n_rst)
								begin
								if(1'b0 == n_rst)
									begin
										tmp_reg[i] <= 1'b1;
									end
								else
									begin
										if(load_enable == 1'b1)begin
											tmp_reg[i] <= parallel_in[i];

										end else if(shift_enable == 1'b1) begin
											tmp_reg[i] <= tmp_reg[i + 1];
						
										end

									end
								end

						end

	

	end
endgenerate

	


endmodule
