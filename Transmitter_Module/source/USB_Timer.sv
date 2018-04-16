// $Id: $
// File name:   USB_Timer.sv
// Created:     4/13/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB Timer

module USB_Timer
(
	input 	wire clk,
		wire n_rst,
		wire bit_sent,
		wire Tim_rst,
		wire Tim_en,
	output	wire new_bit,
		wire [7:0]byte_out,
		wire EOD,
		wire Load_Byte
		

);
	//Reset Variables
	reg bit_reset;
	reg byte_reset;
	reg width_reset;

	//Reset Assignments
	assign bit_reset = Load_Byte | Tim_rst;
	assign byte_reset = Tim_rst;
	assign width_reset = Tim_rst;

	//Width Counter
	flex_counter #(.NUM_CNT_BITS(4)) Width_Generator(.clk(clk),.n_rst(n_rst),.clear(width_reset),.count_enable(Tim_en),.rollover_val(4'b1000),.rollover_flag(new_bit));
	//Bit Counter
	flex_counter #(.NUM_CNT_BITS(4)) Bit_Counter(.clk(clk),.n_rst(n_rst),.clear(bit_reset),.count_enable(bit_sent),.rollover_val(4'b1000),.rollover_flag(Load_Byte));
	//Byte Counter
	flex_counter #(.NUM_CNT_BITS(8)) Byte_Counter(.clk(clk),.n_rst(n_rst),.clear(byte_reset),.count_out(byte_out),.count_enable(Load_Byte),.rollover_val(8'b01000000),.rollover_flag(EOD));

endmodule
