// $Id: $
// File name:   sync_high.sv
// Created:     1/23/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: sync_high


module sync_high
(
	input reg clk,
	input reg n_rst,
	input reg async_in,
	output reg sync_out
);
	reg meta;

	always_ff @ (posedge clk, negedge n_rst)
		begin
		if(1'b0 == n_rst)
			begin
				sync_out <= 1'b1;
				meta <= 1'b1;	
			end
		else 
			begin
	 			meta <= async_in;
				sync_out <= meta;
				//meta <= 1'b1;	
			end
		end
		

endmodule
