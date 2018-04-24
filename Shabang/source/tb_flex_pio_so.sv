// $Id: $
// File name:   tb_flex_pio_so.sv
// Created:     4/20/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: test bench for flex register
module tb_flex_pio_so ();

	reg clk; reg n_rst; reg Shift_Enable; reg reset; reg Serial_In; reg load_enable; reg Parallel_in; reg Parallel_out;

	flex_pio_si #(17) CRC_Register (.clk(clk),.n_rst(n_rst),.shift_enable(Shift_Enable),.s_reset(reset),.serial_in(Serial_In),.load_enable(load_enable),.parallel_in(Parallel_in),.parallel_out(Parallel_out));

endmodule
