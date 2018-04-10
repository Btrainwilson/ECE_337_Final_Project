// $Id: $
// File name:   sync_low.sv
// Created:     1/28/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Reset to Logic Low Synchronizer
module sync_low
(
	input wire clk,
	input wire n_rst,
	input wire async_in,
	output reg sync_out
);
reg Q1;

always_ff @ (posedge clk, negedge n_rst)
begin
 if(1'b0 == n_rst)
 begin
	Q1 <= 0;
 end
 else
 begin
	Q1 <= async_in;
 end
end

always_ff @ (posedge clk, negedge n_rst)
begin
 if(1'b0 == n_rst)
 begin
	sync_out <= 0;
 end
 else
 begin
	sync_out <= Q1;
 end
end

endmodule
