// $Id: $
// File name:   tb_transmitter.sv
// Created:     4/20/2018 (LIIIIIIIIT)
// Author:      "Stan who drives a Ford"
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB transmitter testbench

`timescale 1ns / 10ps

module tb_transceiver();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)
	//localparam	SLOW_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 1.035;
	//localparam 	FAST_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 0.965;
	localparam 	LINE_CLK_PERIOD		= CLK_PERIOD;

	localparam SYNC_BYTE = 8'b10000000; // SYNC Byte
    	localparam NAK_PID = 8'b01011010; // NAK PID is 1010
    	localparam DATA1_PID = 8'b01001011; // DATA1 PID is 1011
    	localparam SEL_FSM_BYTE = 1'b1; // Select FSM
    	localparam SEL_FIFO_BYTE = 1'b0; // Select FIFO 

	// From receiver tb
	localparam DUT_ADDR = 8'b01001100;
    	localparam OTHER_ADDR = 8'b01010010;
    	localparam IN_PID = 8'b01101001;
    	localparam MEH_PID = 8'b00111100;


	// Declare DUT portmap signals
	reg tb_n_rst;
	reg tb_clk;	
	reg [7:0] tb_FIFO_byte;
	reg tb_fifo_ready;
	reg tb_fifo_r_enable;
	reg tb_is_txing;
	tri1 tb_d_plus; // Tri state
	tri1 tb_d_minus;	// Tri state

	// Test bench input/output pins
	wire tb_rx_d_plus;
	reg tb_tx_d_plus;
	wire tb_rx_d_minus;
	reg tb_tx_d_minus; 

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
	integer k;
	
	

	// Clock generation blocks
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	always
	begin
		tb_line_clk = 1'b0;
		#(LINE_CLK_PERIOD/2.0);
		tb_line_clk = 1'b1;
		#(LINE_CLK_PERIOD/2.0);
	end

	
	// DUT Port map
	transceiver DUT(.clk(tb_clk), .n_rst(tb_n_rst), .FIFO_byte(tb_FIFO_byte),
			.fifo_ready(tb_fifo_ready), .d_plus(tb_d_plus),
			.d_minus(tb_d_minus), .fifo_r_enable(tb_fifo_r_enable),
			.is_txing(tb_is_txing));

	// Introduce tri-states so that the testbench bidirectionally interact with the
	// transceiver

	// d_plus side (BECAUSE JOHNSON TOLD US TOOOOOO)
	assign tb_d_plus = (~tb_is_txing) ? tb_tx_d_plus : 1'bz;
	assign tb_rx_d_plus = tb_d_plus;

	// d_minus side (BECAUSE JOHNSON TOLD US TOOOOO)
	assign tb_d_minus = (~tb_is_txing) ? tb_tx_d_minus : 1'bz;
	assign tb_rx_d_minus = tb_d_minus;
	
	


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

	task check_byte;   // Send a starting byte via the FIFO lines
		input [7:0] line_byte;  // What the output should be
		input [7:0] next_line_byte; // What the output will be next
	begin
		tb_d_plus_prev = tb_rx_d_plus;
		j = 0;  // byte index
		number_wrong = 0;
		tb_FIFO_byte = next_line_byte;
		
		// Crosses fingers, hopes the 8 pulse window is enough for the USB line
		// to start doing its thing.

		for(j = 0; j <= 7; j++)
		begin
			
			// Sample output at rate of 8 clock cycles per sample
			for (i = 0; i <=7; i++)
			begin
				@(negedge tb_clk);
			end
			stuffing_detected = 0;

			if (tb_rx_d_plus != tb_d_plus_prev)
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
			tb_d_plus_prev = tb_rx_d_plus;
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
			tb_tx_d_plus = ~tb_tx_d_plus;
			tb_tx_d_minus = ~tb_tx_d_plus;
			for(j = 0; j < 8; j++)
			begin
				@(negedge tb_line_clk);
			end
		end
		else
		begin
			tb_tx_d_plus = tb_tx_d_plus;
			tb_tx_d_minus = ~tb_tx_d_plus;
			for(j = 0; j < 8; j++)
			begin
				@(negedge tb_line_clk);
			end
		end
	end
	endtask

	task send_eop;
	begin
		tb_tx_d_plus = 0;
		tb_tx_d_minus = 0;
		for(j = 0; j < 16; j++)
		begin
			if (~tb_is_txing)
			begin
			@(negedge tb_line_clk);
			end
		end
		tb_tx_d_plus = 1;
		tb_tx_d_minus = 0;
		for(j = 0; j < 8; j++)
		begin
			if (~tb_is_txing)
			begin
			@(negedge tb_line_clk);
			end
		end
		
	end
	endtask

	initial // TRANSCEIVER TESTS BAYBEEE
	begin

	// Initializations
	tb_fifo_ready = 0;
	tb_FIFO_byte = '0;
	tb_tx_d_plus = 1;
	tb_tx_d_minus = 0;
	number_of_consecutive_ones_sent = 0;
	tb_test_num = 0;

	// Reset DUT
	resetDUT();

	// Test 1: Send sync byte, correct PID,DUT_address.  Will send nak (fifo not ready).
	tb_test_num = 1;
	send_byte(8'b10000000);
	send_byte(IN_PID);
	send_byte(DUT_ADDR);
	send_eop(); // Should trigger the transmitter into action
	// wait for the transmitter to activate.
	tb_tx_d_plus = 1;
	tb_tx_d_minus = 0; // send the tb "transmitter" into idle
	// Start checking for a NAK response
	check_byte(SYNC_BYTE, NAK_PID); // Sync first
	check_byte(NAK_PID, 8'b11111111); // Will go into idle after nak

	// Test 2: Send sync byte, correct PID,DUT_address.  Will send data (FIFO's BODY IS READY).
	resetDUT();
	tb_fifo_ready = 1;
	tb_test_num += 1;
	send_byte(8'b10000000);
	send_byte(IN_PID);
	send_byte(DUT_ADDR);
	send_eop(); // Should trigger the transmitter into action
	// Read data from "FIFO"
	check_byte(SYNC_BYTE, DATA1_PID);
	check_byte(DATA1_PID, 8'b11111111);
	@(negedge tb_clk);
	// Send 64 bytes
	for(k = 0; k <16; k++)
	begin
	tb_FIFO_byte = '1;
	check_byte('1, '0);
	tb_FIFO_byte = '0;
	check_byte('0, 10101010);
	tb_FIFO_byte = 10101010;
	check_byte(10101010, 01010101);
	tb_FIFO_byte = 01010101;
	check_byte(01010101, '1);
	end

	// Test 3: Send sync byte, incorrect PID,DUT_address.  Will send nak (fifo ready, but PID incorrect).
	resetDUT();
	tb_fifo_ready = 1;
	tb_test_num += 1;
	send_byte(8'b10000000);
	send_byte(MEH_PID);
	send_byte(DUT_ADDR);
	send_eop(); // Should trigger the transmitter into action
	// wait for the transmitter to activate.
	tb_tx_d_plus = 1;
	tb_tx_d_minus = 0; // send the tb "transmitter" into idle
	// Start checking for a NAK response
	check_byte(SYNC_BYTE, NAK_PID); // Sync first
	check_byte(NAK_PID, 8'b11111111); // Will go into idle after nak

	// Test 4: Send sync byte, correct PID,incorrect address.  Will send nothing (fifo ready, but command not addressed to device).
	resetDUT();
	tb_fifo_ready = 1;
	tb_test_num += 1;
	send_byte(8'b10000000);
	send_byte(IN_PID);
	send_byte(OTHER_ADDR);
	send_eop(); // Should trigger the transmitter into action
	// At this point, the device would have is_txing raised if transmitting
	assert(tb_is_txing == 0)
	begin
		$info("Test %d: PASS - transmitter did not activate", tb_test_num);
	end
	else
	begin
		$error("Test %d: FAIL - transmitter did activate", tb_test_num);
	end

	// Test 5: Send sync byte, correct PID,correct address (without resetting DUT).  Will send data (fifo ready, and command addressed to device).
	tb_fifo_ready = 1;
	tb_test_num += 1;
	send_byte(8'b10000000);
	send_byte(IN_PID);
	send_byte(DUT_ADDR);
	send_eop(); // Should trigger the transmitter into action
	// Read data from "FIFO"
	check_byte(SYNC_BYTE, DATA1_PID);
	check_byte(DATA1_PID, 8'b11111111);
	@(negedge tb_clk);
	// Send 64 bytes
	for(k = 0; k <16; k++)
	begin
	tb_FIFO_byte = '1;
	check_byte('1, '0);
	tb_FIFO_byte = '0;
	check_byte('0, 10101010);
	tb_FIFO_byte = 10101010;
	check_byte(10101010, 01010101);
	tb_FIFO_byte = 01010101;
	check_byte(01010101, '1);
	end


	// Test 2: SEND DATA
	//tb_test_num += 1;
	//k = 0;
	//tb_FIFO_byte = '1;
	//@(posedge tb_d_plus); // Enters idle
	//@(negedge tb_clk);
	//tb_send_data = 1;
	//@(negedge tb_clk);
	//tb_send_data = 0;
	//@(negedge tb_clk);
	//check_byte(SYNC_BYTE, DATA1_PID);
	//check_byte(DATA1_PID, 8'b11111111);
	//tb_FIFO_byte = '1;
	// Send 64 bytes
	//for(k = 0; k <16; k++)
	//begin
	//@(posedge tb_fifo_r_enable);
	//tb_FIFO_byte = '1;
	//check_byte('1, '0);
	//@(posedge tb_fifo_r_enable);
	//tb_FIFO_byte = '0;
	//check_byte('0, 10101010);
	//@(posedge tb_fifo_r_enable);
	//tb_FIFO_byte = 10101010;
	//check_byte(10101010, 01010101);
	//@(posedge tb_fifo_r_enable);
	//tb_FIFO_byte = 01010101;
	//check_byte(01010101, '1);
	//end


	end

endmodule
