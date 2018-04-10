// $Id: $
// File name:   tb_usb_receiver.sv
// Created:     2/21/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab6: USB receiver testbench.

`timescale 1ns / 10ps

module tb_usb_receiver();

	// Define local parameters used by the test bench
	localparam	NORM_CLK_PERIOD		= 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)
	localparam	SLOW_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 1.035;
	localparam 	FAST_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 0.965;
	localparam 	LINE_CLK_PERIOD		= FAST_CLK_PERIOD;


	// Declare DUT portmap signals
	reg tb_n_rst;
	reg tb_clk;	
	reg tb_d_plus;
	reg tb_d_minus;
	reg tb_r_enable;
	reg [7:0] tb_r_data;
	reg tb_empty;
	reg tb_full;
	reg tb_rcving;
	reg tb_r_error;
	

	// Declare test bench signals
	reg tb_clk_fast;
	reg tb_clk_slow;
	reg tb_line_clk;
	integer tb_test_num;
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

	always
	begin
		tb_line_clk = 1'b0;
		#(LINE_CLK_PERIOD/2.0);
		tb_line_clk = 1'b1;
		#(LINE_CLK_PERIOD/2.0);
	end

	// DUT Port map
	usb_receiver DUT(.clk(tb_clk), .n_rst(tb_n_rst), .d_plus(tb_d_plus), .d_minus(tb_d_minus), .r_enable(tb_r_enable), 
			.r_data(tb_r_data), .empty(tb_empty), .full(tb_full), .rcving(tb_rcving), .r_error(tb_r_error));

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

	task send_byte;
		input [7:0] line_byte;
	begin
		for(i = 0; i < 8; i += 1)
		begin
			send_bit(line_byte[i]);
		end

	end
	endtask

	task send_bit; // Sends encoded bit using specified clocking rate.
		input bit_in;
	begin
		if(bit_in == 1'b0)
		begin
			tb_d_plus = ~tb_d_plus;
			tb_d_minus = ~tb_d_plus;
			for(j = 0; j < 8; j++)
			begin
				@(negedge tb_line_clk);
			end
		end
		else
		begin
			tb_d_plus = tb_d_plus;
			tb_d_minus = ~tb_d_plus;
			for(j = 0; j < 8; j++)
			begin
				@(negedge tb_line_clk);
			end
		end
	end
	endtask

	task send_eop;
	begin
		tb_d_plus = 0;
		tb_d_minus = 0;
		for(j = 0; j < 16; j++)
		begin
			@(negedge tb_line_clk);
		end
		tb_d_plus = 1;
		tb_d_minus = 0;
		for(j = 0; j < 8; j++)
		begin
			@(negedge tb_line_clk);
		end
		
	end
	endtask

	initial
	begin
	// Initialize lines and relevant testbench vars
	tb_d_plus = 1;
	tb_d_minus = 0;
	tb_r_enable = 0;
	
	i = 0;
	j = 0;
	tb_test_num = 0;
	

	// Power-on reset
	resetDUT();

	// Test 1: Send Sync Bit
	tb_test_num += 1;
	send_byte(8'b10000000);
	assert(tb_rcving == 1)
		$info("Test %d: Send Sync Bit: CORRECT", tb_test_num);
	else
		$error("Test %d: Send Sync Bit: INCORRECT", tb_test_num);

	// Test 2: Send Valid Bytes, Send EOP, then Verify using FIFO output
	tb_test_num += 1;
	send_byte(8'b10101010);
	send_byte(8'b00001111);

	send_eop();

	assert(tb_rcving == 0)
		$info("Test %d: Return to IDLE: CORRECT", tb_test_num);
	else
		$error("Test %d: Return to IDLE: INCORRECT", tb_test_num);

	// Test 3: Check Bytes from FIFO
	tb_test_num += 1;
	tb_d_plus = 1;
	tb_d_minus = 0; // IDLE

	assert(tb_r_data == 8'b10101010)
		$info("Test %d: Check FIFO: CORRECT", tb_test_num);
	else
		$error("Test %d: Check FIFO: INCORRECT", tb_test_num);

	tb_r_enable = 1;
	@(negedge tb_clk);
	
	assert(tb_r_data == 8'b00001111)
		$info("Test %d: Check FIFO: CORRECT", tb_test_num);
	else
		$error("Test %d: Check FIFO: INCORRECT", tb_test_num);
	
	// Test 4: Send Something that's not a sync, send garbage, then send EOP

	tb_test_num += 1;
	tb_r_enable = 0;
	send_byte(8'b01010101); // Should trigger error
	assert(tb_r_error == 1)
		$info("Test %d: Incorrect SYNC error: CORRECT", tb_test_num);
	else
		$error("Test %d: Incorrect SYNC error: INCORRECT", tb_test_num);
	send_byte(8'b01010101);
	assert(tb_r_error == 1)
		$info("Test %d: Incorrect SYNC error: CORRECT", tb_test_num);
	else
		$error("Test %d: Incorrect SYNC error: INCORRECT", tb_test_num);
	send_byte(8'b01111010);
	assert(tb_r_error == 1)
		$info("Test %d: Incorrect SYNC error: CORRECT", tb_test_num);
	else
		$error("Test %d: Incorrect SYNC error: INCORRECT", tb_test_num);
	send_eop();
	assert(tb_r_error == 1)
		$info("Test %d: Incorrect SYNC error: CORRECT", tb_test_num);
	else
		$error("Test %d: Incorrect SYNC error: INCORRECT", tb_test_num);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	assert(tb_r_error == 1 && tb_rcving == 0)
		$info("Test %d: EIDLE held: CORRECT", tb_test_num);
	else
		$error("Test %d: EIDLE held: INCORRECT", tb_test_num);

	// Test 5: Correct sync, premature EOP error

	tb_test_num += 1;
	tb_r_enable = 0;
	send_byte(8'b10000000); // Should go into reading
	assert(tb_r_error == 0)
		$info("Test %d: sampling loop : CORRECT", tb_test_num);
	else
		$error("Test %d: sampling loop: INCORRECT", tb_test_num);
	send_byte(8'b01010101);
	assert(tb_r_error == 0)
		$info("Test %d: sampling loop: CORRECT", tb_test_num);
	else
		$error("Test %d: sampling loop: INCORRECT", tb_test_num);
	send_byte(8'b01111010);
	assert(tb_r_error == 0)
		$info("Test %d: sampling loop: CORRECT", tb_test_num);
	else
		$error("Test %d: sampling loop: INCORRECT", tb_test_num);
	send_bit(1'b1);
	send_eop();
	assert(tb_r_error == 1)
		$info("Test %d: Premature EOP error: CORRECT", tb_test_num);
	else
		$error("Test %d: Premature EOP error: INCORRECT", tb_test_num);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	assert(tb_r_error == 1 && tb_rcving == 0)
		$info("Test %d: EIDLE held: CORRECT", tb_test_num);
	else
		$error("Test %d: EIDLE held: INCORRECT", tb_test_num);
	
	
	
	


	end
endmodule

