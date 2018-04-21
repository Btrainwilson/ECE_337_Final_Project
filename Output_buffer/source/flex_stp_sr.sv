// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/30/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: N-bit serial-to-parallel shift register
module flex_stp_sr
#(
parameter NUM_BITS = 4,
parameter SHIFT_MSB = 1
)

(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire serial_in,
	output reg [(NUM_BITS-1):0]parallel_out
);

reg [(NUM_BITS-1):0] temp;
integer i;

always_ff @ (posedge clk, negedge n_rst)
begin
   if(n_rst == 0)
   begin	
	for(i = 0; i <= (NUM_BITS -1); i = i + 1) begin
		parallel_out[i] <= 1;
	end
   end
   else
   begin
	parallel_out <= temp;
    end
end

always_comb
begin
  if(shift_enable == 1)
  begin
	if(SHIFT_MSB == 1)
	begin
		temp = {parallel_out[(NUM_BITS - 2):0], serial_in};
	end
	else
	begin
		temp = {serial_in, parallel_out[(NUM_BITS-1):1]};
	end
  end
  else
  begin
	temp = parallel_out;
  end
end
endmodule
