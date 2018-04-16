// $Id: $
// File name:   tb_usb_receiver.sv
// Created:     2/21/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab6: USB receiver testbench.

`timescale 1ns / 10ps

module tb_byte_transmitter();

	// Define local parameters used by the test bench
	localparam	NORM_CLK_PERIOD		= 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)
	//localparam	SLOW_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 1.035;
	//localparam 	FAST_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 0.965;
	//localparam 	LINE_CLK_PERIOD		= NORM_CLK_PERIOD;


	// Declare DUT portmap signals
	reg tb_n_rst;
	reg tb_clk;	
	reg [7:0] tb_FSM_byte;
	reg [7:0] tb_FIFO_byte;
	reg tb_load_en;
	reg tb_select;
	reg tb_idle;
	reg tb_Tim_rst;
	reg tb_Tim_en;
	reg tb_eop;
	reg tb_d_plus;
	reg tb_d_minus;
	reg tb_Load_Byte;
	reg [7:0] tb_byte_out;
	reg tb_EOD;
	

	// Declare test bench signals
	reg tb_clk_fast;
	reg tb_clk_slow;
	reg tb_line_clk;
	reg [8:0] stuffed_input;
	reg stuffing_detected;
	integer tb_test_num;
	integer number_of_consecutive_ones_sent;
	integer i;
	integer j;
	
	

	// Clock generation blocks
	always
	begin
		tb_clk = 1'b0;
		#(NORM_CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(NORM_CLK_PERIOD/2.0);
	end

	//always
	//begin
	//	tb_line_clk = 1'b0;
	//	#(LINE_CLK_PERIOD/2.0);
	//	tb_line_clk = 1'b1;
	//	#(LINE_CLK_PERIOD/2.0);
	//end

	// DUT Port map
	generate
	byte_transmitter DUT(.clk(tb_clk), .n_rst(tb_n_rst), .FSM_byte(tb_FSM_byte), .FIFO_byte(tb_FIFO_byte),
				.load_en(tb_load_en), .select(tb_select), .idle(tb_idle), .Tim_rst(tb_Tim_rst),
				.Tim_en(tb_Tim_en), .eop(tb_eop), .d_plus(tb_d_plus), .d_minus(tb_d_minus),
				.Load_Byte(tb_Load_Byte), .byte_out(tb_byte_out), .EOD(tb_EOD));
	endgenerate

	// Test vector struct
	//typedef struct
	//{
	//	reg first_bit; // Bit prior to encoded message
	//	reg [7:0] unencoded;
	//} testVector;


	task resetDUT;
	begin
		// Power-on reset of DUT
		tb_n_rst = 1'b0;
		@(negedge tb_clk);
		@(negedge tb_clk);
		tb_n_rst = 1'b1;
		@(negedge tb_clk);
		@(negedge tb_clk);

	end
	endtask

	task send_byte;   // Send a byte via the FIFO lines
		input [7:0] line_byte;
	begin
		@(negedge tb_clk);
		// start the timer, using the extra initialization cycle  for loading the shiftreg
		tb_Tim_en = 1;
		tb_Tim_rst = 0;
		// load byte
		@(negedge tb_clk);
		tb_FIFO_byte = line_byte;
		tb_load_en = 1;
		tb_select = 0;   // Load in the inputted byte via the FIFO lines

		// let bit propogate through stuffer
		@(negedge tb_clk);

		// Turn idle off
		tb_idle = 0;
		@(negedge tb_clk);

		// First bit shows up here.
		
		//for(i = 0; i < 8; i += 1)
		//begin
	//		send_bit(line_byte[i]);
	//	end

	end
	endtask

	

	initial
	begin
	// Initialize lines and relevant testbench vars
	tb_FSM_byte = '0;
	tb_FIFO_byte = '0;
	tb_load_en = 0;
	tb_select = 0;
	tb_idle = 1;  // d_plus/d_minus should stay in idle state until actiavated
	tb_Tim_rst = 1;  // Keep timer disabled until ready
	tb_Tim_en = 0;
	tb_eop = 0;
	tb_n_rst = 0;
	
	
	i = 0;
	j = 0;
	tb_test_num = 0;
	stuffed_input  = '0;
	stuffing_detected = 0;
	number_of_consecutive_ones_sent = 0;
	

	// Power-on reset
	resetDUT();

	// Test 1: Send Sync Bit
	tb_test_num += 1;
	send_byte(8'b10000000);
	
	
	


	end
endmodule

