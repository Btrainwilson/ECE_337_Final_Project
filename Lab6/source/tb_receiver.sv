// $Id: $
// File name:   tb_receiver.sv
// Created:     4/17/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Testbench for receiver side of USB transceiver.


`timescale 1ns / 10ps

module tb_receiver();

	// Define local parameters used by the test bench
	localparam	NORM_CLK_PERIOD		= 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)
	localparam	SLOW_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 1.035;
	localparam 	FAST_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 0.965;
	localparam 	LINE_CLK_PERIOD		= NORM_CLK_PERIOD;
	localparam DUT_ADDR = 8'b01001100;
    	localparam OTHER_ADDR = 8'b01010010;
    	localparam IN_PID = 8'b01101001;
    	localparam MEH_PID = 8'b00111100;


	// Declare DUT portmap signals
	reg tb_n_rst;
	reg tb_clk;	
	reg tb_d_plus;
	reg tb_d_minus;
	reg tb_is_tx_active;
	reg send_data;
	reg send_nak;
	

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
	receiver DUT(.d_plus(tb_d_plus), .d_minus(tb_d_minus), .clk(tb_clk),
			.n_rst(tb_n_rst), .is_tx_active(tb_is_tx_active),
			.send_data(send_data), .send_nak(send_nak));

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

	initial  // HEY!!! THE TEST'S DOWN HERE
	begin
	// initialize yo crap
	tb_d_plus = 1;  // Idle
	tb_d_minus = 0;
	tb_is_tx_active = 0;

	// power-on reset
	resetDUT();
	
	// Test 1: Send sync byte, PID,
	sendbyte(8'b10000000);
	sendbyte(IN_PID);
	
	end

endmodule
