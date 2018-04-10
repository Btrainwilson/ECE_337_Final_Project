// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/23/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 3: 4.1.1: N-bit Serial to Parallel Shift Register Design.

module  flex_stp_sr
	#(
	parameter NUM_BITS = 4,
	parameter SHIFT_MSB = 1	
	)	
	(
	input wire clk, n_rst, shift_enable, serial_in,
	output reg [NUM_BITS - 1: 0] parallel_out
	);

	genvar i;
	reg [NUM_BITS-1: 0] next_par_out;


	generate   // Initialize register for each bit on parallel line
		for(i = 0; i < NUM_BITS; i = i + 1)
		begin
			always_ff @(posedge clk, negedge n_rst)
			begin :                        Register
				if (1'b0 == n_rst)
				begin
					parallel_out[i] <= 1'b1;
				end
				else
				begin
					parallel_out[i] <= next_par_out[i];
				end
			end
		end
	endgenerate

	// Next State Logic

	always @ (shift_enable, serial_in, parallel_out)
	begin : 			NEXT_STATE_FIRST_MUX
		if (shift_enable == 1'b1)
		begin
			if (SHIFT_MSB == 1'b1)
			begin			
				next_par_out[0] = serial_in;
			end
			else
			begin
				next_par_out[0] = parallel_out[1];
			end			
		end
		else
		begin
			next_par_out[0] = parallel_out[0];
		end
		
	end

	generate
		for(i = 1; i < NUM_BITS - 1; i = i + 1)
		begin
		always @ (shift_enable, serial_in, parallel_out)
			begin :                        NEXT_STATE_MIDDLE_MUXES
				
				if (shift_enable == 1'b1)
				begin
					if (SHIFT_MSB == 1'b1)
					begin
					
						next_par_out[i] = parallel_out[i - 1];
						
						
					end
					else
					begin
	
						next_par_out[i] = parallel_out[i + 1];

					end
				end
				else
				begin
					next_par_out[i] = parallel_out[i];		
				end
	

			end
		end
	endgenerate

	always @ (shift_enable, serial_in, parallel_out)
	begin : 			NEXT_STATE_LAST_MUX
		if (shift_enable == 1'b1)
		begin
			if (SHIFT_MSB == 1'b1)
			begin			
				next_par_out[NUM_BITS-1] = parallel_out[NUM_BITS - 2];
			end
			else
			begin
				next_par_out[NUM_BITS-1] = serial_in;
			end			
		end
		else
		begin
			next_par_out[NUM_BITS-1] = parallel_out[NUM_BITS-1];
		end
		
	end




endmodule
