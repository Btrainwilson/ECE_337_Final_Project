// $Id: $
// File name:   tb_byte_transmitter.sv
// Created:     2/21/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab6: USB receiver testbench.

`timescale 1ns / 10ps

module tb_byte_transmitter();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)
	//localparam	SLOW_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 1.035;
	//localparam 	FAST_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 0.965;
	//localparam 	LINE_CLK_PERIOD		= NORM_CLK_PERIOD;
	localparam SEL_FSM_BYTE = 2'b01; // Select FSM
    	localparam SEL_FIFO_BYTE = 2'b00; // Select FIFO 
    	localparam SEL_CRC_HIGH = 2'b10; // Select CRC 15:8
    	localparam SEL_CRC_LOW = 2'b11; // Select CRC 7:0 


	// Declare DUT portmap signals
	reg tb_n_rst;
	reg tb_clk;	
	reg [7:0] tb_FSM_byte;
	reg [7:0] tb_FIFO_byte;
	reg tb_load_en;
	reg [1:0] tb_select;
	reg tb_idle;
	reg tb_Tim_rst;
	reg tb_Tim_en;
	reg tb_eop;
	reg tb_d_plus;
	reg tb_d_minus;
	reg tb_to_encoder;
	reg tb_Load_Byte;
	reg [7:0] tb_byte_out;
	reg tb_EOD;
	reg tb_shift_enable;
	reg tb_to_stuffer;
	reg [15:0] tb_CRC_Bytes;
	reg tb_eop_new_bit;
	

	// Declare test bench signals
	reg tb_clk_fast;
	reg tb_clk_slow;
	reg tb_line_clk;
	reg [8:0] stuffed_input;
	reg stuffing_detected;
	reg tb_d_plus_prev;
	reg tb_d_plus_decoded;
	integer tb_test_num;
	integer number_wrong;
	integer number_of_consecutive_ones_sent;
	integer i;
	integer j;
	
	

	// Clock generation blocks
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	
	// DUT Port map
	byte_transmitter DUT(.clk(tb_clk), .n_rst(tb_n_rst), .FSM_byte(tb_FSM_byte), .FIFO_byte(tb_FIFO_byte),
				.load_en(tb_load_en), .select(tb_select),
				.idle(tb_idle), .Tim_rst(tb_Tim_rst), .Tim_en(tb_Tim_en), .eop(tb_eop),
				.d_plus(tb_d_plus), .d_minus(tb_d_minus), .Load_Byte(tb_Load_Byte),
				.byte_out(tb_byte_out), .EOD(tb_EOD), .to_encoder(tb_to_encoder),
				.shift_enable(tb_shift_enable), .to_stuffer(tb_to_stuffer), 	.CRC_Bytes(tb_CRC_Bytes), .eop_new_bit(tb_eop_new_bit));



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

	task send_byte;   // Send a starting byte via the FIFO lines
		input [7:0] line_byte;
		input [7:0] next_byte;
	begin
		tb_d_plus_prev = tb_d_plus;
		j = 0;  // byte index
		number_wrong = 0;
		@(negedge tb_clk);
		// start the timer, using the extra initialization cycle  for loading the shiftreg
		tb_Tim_en = 1;
		tb_Tim_rst = 0;
		// load byte
		@(negedge tb_clk);
		tb_FIFO_byte = line_byte;
		tb_load_en = 1;
		tb_select = SEL_FIFO_BYTE;   // Load in the inputted byte via the FIFO lines

		// let bit propogate through stuffer
		@(negedge tb_clk);
		tb_load_en = 0;
		tb_FIFO_byte = next_byte;

		// Lift idle, and let'er rip
		tb_idle = 0;

		for(j = 0; j <= 7; j++)
		begin
			
			// Sample output at rate of 8 clock cycles per sample
			for (i = 0; i <=7; i++)
			begin
				@(negedge tb_clk);
			end
			stuffing_detected = 0;

			if (tb_d_plus != tb_d_plus_prev)
				begin
					tb_d_plus_decoded = 0;
				end
				else
				begin
					tb_d_plus_decoded = 1;
				end

			if (number_of_consecutive_ones_sent != 6)
			begin
				if (tb_d_plus_decoded != line_byte[j])
				begin
					number_wrong += 1;
				end
			end
			else
			begin
				stuffing_detected = 1;
				j = j - 1;
				number_of_consecutive_ones_sent = 0;
				if (tb_d_plus_decoded != 0)
				begin
					number_wrong += 1;
				end
				
			end
			tb_d_plus_prev = tb_d_plus;
			if (tb_d_plus_decoded)
			begin
				number_of_consecutive_ones_sent += 1;
			end
			else
			begin
				number_of_consecutive_ones_sent = 0;	
			end

		end

		// Here is where you would reset the timer and reset idle.  However, this is left out in order to allow
		// broadcasting of multiple bytes in a row.	

		assert(number_wrong == 0)
		begin
			$info("Test %d: PASSED", tb_test_num);
		end
		else
		begin
			$info("Test %d: FAILED", tb_test_num);
		end	

		// First bit shows up here.
		
		//for(i = 0; i < 8; i += 1)
		//begin
	//		send_bit(line_byte[i]);
	//	end

	end
	endtask

	task send_more_bytes;  // For secondary bytes and more.
		input [7:0] current_byte;
		input [7:0] next_byte;
	begin
		tb_d_plus_prev = tb_d_plus;
		j = 0;  // byte index
		number_wrong = 0;
		tb_FIFO_byte = next_byte;
		tb_select = SEL_FIFO_BYTE;   // Load in the inputted byte via the FIFO lines

		for(j = 0; j <= 7; j++)
		begin
			
			// Sample output at rate of 8 clock cycles per sample
			for (i = 0; i <=7; i++)
			begin
				@(negedge tb_clk);
			end
			stuffing_detected = 0;

			if (tb_d_plus != tb_d_plus_prev)
				begin
					tb_d_plus_decoded = 0;
				end
				else
				begin
					tb_d_plus_decoded = 1;
				end

			if (number_of_consecutive_ones_sent != 6)
			begin
				if (tb_d_plus_decoded != current_byte[j])
				begin
					number_wrong += 1;
				end
			end
			else
			begin
				stuffing_detected = 1;
				j = j - 1;
				number_of_consecutive_ones_sent = 0;
				if (tb_d_plus_decoded != 0)
				begin
					number_wrong += 1;
				end
				
			end
			tb_d_plus_prev = tb_d_plus;
			if (tb_d_plus_decoded)
			begin
				number_of_consecutive_ones_sent += 1;
			end
			else
			begin
				number_of_consecutive_ones_sent = 0;	
			end

		end
		assert(number_wrong == 0)
		begin
			$info("Test %d: PASSED", tb_test_num);
		end
		else
		begin
			$info("Test %d: FAILED", tb_test_num);
		end	
	end
	endtask
	

	initial
	begin
	// Initialize lines and relevant testbench vars
	tb_FSM_byte = '0;
	tb_FIFO_byte = '0;
	tb_CRC_Bytes = '0;
	tb_load_en = 0;
	tb_select = SEL_FIFO_BYTE;
	tb_idle = 1;
	tb_Tim_rst = 1;  // Keep timer disabled until ready
	tb_Tim_en = 0;
	tb_n_rst = 0;
	tb_eop = 0;
	tb_eop_new_bit = 0;
	
	
	i = 0;
	j = 0;
	tb_test_num = 0;
	stuffed_input  = '0;
	stuffing_detected = 0;
	number_of_consecutive_ones_sent = 0;
	

	// Power-on reset
	resetDUT();

	// Test 1: Send Bit that is back-heavy with 1's
	tb_test_num += 1;
	send_byte(8'b11111110, 8'b11111111);
	
	// Test 2: Send Sync Bit
	tb_test_num += 1;
	send_more_bytes(8'b11111111, 8'b00000000);
	
	
	


	end
endmodule

