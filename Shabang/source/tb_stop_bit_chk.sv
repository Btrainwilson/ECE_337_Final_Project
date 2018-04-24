// $Id: $
// File name:   tb_stop_bit_chk.sv
// Created:     2/5/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: stop bit checker test bench
`timescale 1ns / 10ps
module tb_stop_bit_chk
();


	// Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay

	// Shared Test Variables
	reg tb_clk;

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
tb_stop_bit_chk_DUT  stp_default(.tb_clk);
endmodule

module tb_stop_bit_chk_DUT 
(input wire tb_clk);
	//Variables

	reg tb_n_rst;
	reg tb_sbc_clear;
	reg tb_sbc_enable;
	reg tb_stop_bit;
	reg tb_framing_error;




	//DUT Map
	generate
	stop_bit_chk DUT(.clk(tb_clk),.n_rst(tb_n_rst),.sbc_enable(tb_sbc_enable),.sbc_clear(tb_sbc_clear),.stop_bit(tb_stop_bit),.framing_error(tb_framing_error));
	endgenerate

	//Clocking Stuff
	
	clocking cb @(posedge tb_clk);
 		// 1step means 1 time precision unit, 10ps for this module. We assume the hold time is less than 200ps.
		default input #1step output #100ps; // Setup time (01CLK -> 10D) is 94 ps
		output #800ps n_rst = tb_n_rst;
		output 	sbc_clear = tb_sbc_clear,
			sbc_enable = tb_sbc_enable,
			stop_bit = tb_stop_bit;
		input 	framing_error = tb_framing_error;
	endclocking

	// Default Configuration Test bench main process
	initial
	begin
	integer 
	tb_n_rst;
	tb_sbc_clear = 1'b0;
	tb_sbc_enable = 1'b0;
	tb_stop_bit = 1'b0;
	tb_framing_error = 1'b0;


			
	// Power-on Reset of the DUT
	// Assume we start at negative edge. Immediately assert reset at first negative edge
	// without using clocking block in order to avoid metastable value warnings
	@(negedge tb_clk);
	tb_n_rst	<= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
	@cb;
	cb.n_rst	<= 1'b1; 	// Deactivate the chip reset
	
	// Wait for a while to see normal operation
	@cb;
	@cb;
		// Test 1: Check for Proper Reset w/ Idle (serial_in=1) input during reset signal

	cb.n_rst <= 1'b1;


	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.stop_bit <= 1'b1;	

	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.sbc_enable <= 1'b1;

	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.sbc_enable <= 1'b0;

	@(negedge tb_clk);
	@(posedge tb_clk);

	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.sbc_clear <= 1'b1;

	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.sbc_clear <= 1'b0;

	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.stop_bit <= 1'b0;	

	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.sbc_enable <= 1'b1;

	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.sbc_enable <= 1'b0;

	@(negedge tb_clk);
	@(posedge tb_clk);

	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.sbc_clear <= 1'b1;

	@(negedge tb_clk);
	@(posedge tb_clk);

	cb.sbc_clear <= 1'b0;

	
	end

endmodule

