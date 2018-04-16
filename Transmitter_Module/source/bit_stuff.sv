// $Id: $
// File name:   bit_stuff.sv
// Created:     4/13/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: ZE BIT STUFFER FOR ZE FINAL PROJECT

module bit_stuff
(
	input wire send_next_bit,
	input wire clk,
	input wire n_rst,
	input wire data_bit,
	input wire Tim_en,
	output reg raw_to_encoder,
	output wire shift_enable // shift_enable for shift register and timer logging
);
	reg is_stuffing;

	flex_counter #(.NUM_CNT_BITS(3)) ones_counter (.clk(clk), .n_rst(n_rst), 
			.clear(!data_bit | (is_stuffing & send_next_bit) | !Tim_en), 
			.count_enable(data_bit & send_next_bit), .rollover_val(3'd6), 
			.rollover_flag(is_stuffing));

	always_ff @(posedge clk, negedge n_rst)
	begin : REG
		if (n_rst == 1'b0)
		begin
			raw_to_encoder <= 0;
		end
		else
		begin
			raw_to_encoder <= data_bit & !(is_stuffing);
		end
	end

	assign shift_enable = send_next_bit & !(is_stuffing);

endmodule
