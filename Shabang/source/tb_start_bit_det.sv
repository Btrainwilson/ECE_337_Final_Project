// $Id: $
// File name:   tb_start_bit_det.sv
// Created:     2/5/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: test bench for start bit detector
`timescale 1ns / 10ps
module tb_start_bit_det
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
tb_start_bit_det_DUT  stp_default(.tb_clk);
endmodule

module tb_start_bit_det_DUT 
(input wire tb_clk);
	//Variables

	reg tb_n_rst;
	reg tb_serial_in;
	reg tb_det;




	//DUT Map
	generate
	start_bit_det DUT(.clk(tb_clk),.n_rst(tb_n_rst),.serial_in(tb_serial_in),.start_bit_detected(tb_det));
	endgenerate

	//Clocking Stuff
	
	clocking cb @(posedge tb_clk);
 		// 1step means 1 time precision unit, 10ps for this module. We assume the hold time is less than 200ps.
		default input #1step output #100ps; // Setup time (01CLK -> 10D) is 94 ps
		output #800ps n_rst = tb_n_rst; // FIXME: Removal time (01CLK -> 01R) is 281.25ps, but this needs to be 800 to prevent metastable value warnings
		output serial_in = tb_serial_in;
		input start_bit_detected = tb_det;
	endclocking

	// Default Configuration Test bench main process
	initial
	begin
	integer 
	tb_n_rst;
	tb_serial_in = 1'b1;
	tb_det = 1'b0;


			
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
	cb.serial_in <= 1'b1;

	@(negedge tb_clk);
	@(posedge tb_clk);	

	cb.serial_in <= 1'b1;

	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);	

	cb.serial_in <= 1'b0;
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	
	cb.serial_in <= 1'b1;
	@(negedge tb_clk);
	@(posedge tb_clk);	

	cb.serial_in <= 1'b0;
	@(negedge tb_clk);
	@(posedge tb_clk);
	
	cb.serial_in <= 1'b1;
	@(negedge tb_clk);
	@(posedge tb_clk);	

	cb.serial_in <= 1'b0;
	@(negedge tb_clk);
	@(posedge tb_clk);
	
	cb.serial_in <= 1'b1;
	@(negedge tb_clk);
	@(posedge tb_clk);	

	cb.serial_in <= 1'b0;
	@(negedge tb_clk);
	@(posedge tb_clk);
	
	cb.serial_in <= 1'b1;
	@(negedge tb_clk);
	@(posedge tb_clk);	

	cb.serial_in <= 1'b0;
	@(negedge tb_clk);
	@(posedge tb_clk);
	
	cb.serial_in <= 1'b1;
	@(negedge tb_clk);
	@(posedge tb_clk);	

	cb.serial_in <= 1'b0;
	@(negedge tb_clk);
	@(posedge tb_clk);
	
	cb.serial_in <= 1'b1;
	@(negedge tb_clk);
	@(posedge tb_clk);	

	cb.serial_in <= 1'b0;
	
	end

endmodule

