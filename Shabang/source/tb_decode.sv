// $Id: $
// File name:   tb_decode.sv
// Created:     2/18/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 6: Decoder tb

`timescale 1ns / 10ps

module tb_decode();

	// Define local parameters used by the test bench
	localparam	NORM_CLK_PERIOD		= 10 * 100 / 96; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)

	// Declare DUT portmap signals
	reg tb_d_plus;
	reg tb_shift_enable;
	reg tb_eop;
	reg tb_d_orig;
	reg tb_n_rst;
	reg tb_clk;

	// Declare test bench signals
	integer tb_test_num;
	reg tb_expected_output;
	reg [7:0] unencoded;
	integer i;
	integer j;
	reg first_bit;
	
	

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(NORM_CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(NORM_CLK_PERIOD/2.0);
	end

	// DUT Port map
	decode DUT(.clk(tb_clk), .n_rst(tb_n_rst), .d_plus(tb_d_plus), .shift_enable(tb_shift_enable), .eop(tb_eop), .d_orig(tb_d_orig));

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
		tb_d_plus = 0;
		@(negedge tb_clk);
		@(negedge tb_clk);
		tb_n_rst = 1'b1;
		@(negedge tb_clk);
		@(negedge tb_clk);

	end
	endtask

	task sendmessage;
		input first_bit;
		input [7:0] unencoded;
	begin
		@(negedge tb_clk)
		tb_d_plus = first_bit;

		for(i = 0; i < 8; i += 1)
		begin
			@(negedge tb_clk)
			if (i == 3)
			begin
				tb_shift_enable = 1;
			end
			else
			begin
				tb_shift_enable = 0;
			end
		end

		for(i = 0; i < 8; i += 1)
		begin
			if (unencoded[i] == 0)
			begin
				tb_d_plus = ~tb_d_plus;
			end
			else
			begin
				tb_d_plus = tb_d_plus;
			end

			for(j = 0; j < 8; j += 1)
			begin
				@(negedge tb_clk)
				if (j == 3)
				begin
					tb_shift_enable = 1;
					assert (tb_d_orig == unencoded[i])
						$info("CORRECT DECRYPTION");
					else
						$error("INCORRECT DECRYPTION");
				end
				else
				begin
					tb_shift_enable = 0;
				end
			end
		end

	end
	endtask

	task sendbit;
		input bit_in;
		input prediction;
	begin
		tb_d_plus = bit_in;
		for(j = 0; j < 8; j += 1)
			begin
				@(negedge tb_clk)
				if (j == 3)
				begin
					tb_shift_enable = 1;
					assert (tb_d_orig == prediction)
						$info("CORRECT DECRYPTION");
					else
						$error("INCORRECT DECRYPTION");
				end
				else
				begin
					tb_shift_enable = 0;
				end
			end
	end
	endtask

	// Test bench main process
	initial
	begin
		// Initialize everything:
		tb_n_rst = 1'b1;
		tb_d_plus = 1'b0;
		tb_shift_enable = 1'b0;
		tb_eop = 1'b0;
		tb_test_num = 0;

		// Device reset
		resetDUT;
	
		// Test 1: SYNC signal
		tb_test_num += 1;
		sendmessage(1'b0, 8'b10000000);

		// Test 2: REVERSE SYNC
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b0, 8'b00000001);

		// Test 3: ALTERNATING 10
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b0, 8'b10101010);

		// Test 4: ALTERNATING 01
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b0, 8'b01010101);

		// Test 5: ALL 1's
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b0, 8'b11111111);

		// Test 6: ALL 0's
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b0, 8'b00000000);

		// Test 7: SYNC signal
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b1, 8'b10000000);

		// Test 8: REVERSE SYNC
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b1, 8'b00000001);

		// Test 9: ALTERNATING 10
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b1, 8'b10101010);

		// Test 10: ALTERNATING 01
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b1, 8'b01010101);

		// Test 11: ALL 1's
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b1, 8'b11111111);

		// Test 12: ALL 0's
		tb_test_num += 1;
		resetDUT;
		sendmessage(1'b1, 8'b00000000);

		// NON-GENERIC TEST CASES
		
		// Test 13: eop enabled
		tb_test_num += 1;
		resetDUT;
		tb_eop = 1'b1;
		sendbit(1'b0, 1'b0); // since internal = 1, expect tb_d_orig to be 0 when shift_enable comes
		tb_eop = 1'b0;
		sendbit(1'b1, 1'b1); // internal should've gone to 1 with eop high
		

	end
endmodule

