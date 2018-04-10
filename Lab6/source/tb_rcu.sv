// $Id: $
// File name:   tb_rcu.sv
// Created:     2/21/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab6: rcu testbench

`timescale 1ns / 10ps

module tb_rcu();

	// Define local parameters used by the test bench
	localparam	NORM_CLK_PERIOD		= 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)

	// Declare DUT portmap signals
	reg tb_d_edge;
	reg tb_shift_enable;
	reg tb_eop;
	reg [7:0] tb_rcv_data;
	reg tb_byte_received;
	reg tb_n_rst;
	reg tb_clk;
	reg tb_rcving;
	reg tb_w_enable;
	reg tb_r_error;

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
	rcu DUT(.clk(tb_clk), .n_rst(tb_n_rst), .d_edge(tb_d_edge),.eop(tb_eop), .shift_enable(tb_shift_enable),
		.rcv_data(tb_rcv_data), .byte_received(tb_byte_received), .rcving(tb_rcving), .w_enable(tb_w_enable), .r_error(tb_r_error));

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

	initial // Now on to the testbench		
	begin
		// initialize DUT portmap signals
		tb_d_edge = 1'b0;
		tb_shift_enable = 1'b0;
		tb_eop = 1'b0;
		tb_rcv_data = '0;
		tb_byte_received = 1'b0;
		

		// initialize test bench signals
		tb_test_num = 0;
		tb_expected_output = 0;
		unencoded = 0;
		i = 0;
		j = 0;

		// Power-on reset
		resetDUT();
	
		// Test 1: Send incorrect sync byte
		tb_test_num += 1;
		
		@(negedge tb_clk);
		
		tb_d_edge = 1'b1;

		@(negedge tb_clk);
		tb_d_edge = 1'b0;
		tb_byte_received = 1'b1;
		tb_rcv_data = 8'b10101010;
	
		assert(tb_rcving == 1'b1)
			$info("Test %d rcving flag high in SYNC_ARMED: CORRECT", tb_test_num);
		else
			$error("Test %d rcving flag high in SYNC_ARMED: INCORRECT", tb_test_num);

		@(negedge tb_clk);
			// Should go into error state
			tb_byte_received = 1'b0;

		@(negedge tb_clk);
		tb_rcv_data = '0;
		assert(tb_r_error == 1'b1 && tb_rcving == 1'b1)
			$info("Test %d: CORRECT", tb_test_num);
		else
			$error("Test %d: INCORRECT", tb_test_num);

		// Test 2: Keep going into EIDLE state and see if EIDLE state holds

		tb_test_num +=1;

		@(negedge tb_clk);
	
		tb_eop = 1'b1;
		tb_shift_enable = 1'b1;
		
		@(negedge tb_clk);
		assert(tb_rcving == 1'b1 && tb_r_error == 1'b1)
			$info("Test %d rcving and error flags high in EEOP_VERIFY: CORRECT", tb_test_num);
		else
			$error("Test %d rcving and error flags high in EEOP_VERIFY: INCORRECT", tb_test_num);
		
		@(negedge tb_clk);
		assert(tb_rcving == 1'b1 && tb_r_error == 1'b1)
			$info("Test %d rcving and error flags high in EEOP_TOEIDLE: CORRECT", tb_test_num);
		else
			$error("Test %d rcving and error flags high in EEOP_TOEIDLE: INCORRECT", tb_test_num);

		tb_eop = 1'b0;
		@(negedge tb_clk);

		assert(tb_r_error == 1'b1 && tb_rcving == 1'b0)
			$info("Test %d EIDLE state reached: CORRECT", tb_test_num);
		else
			$error("Test %d EIDLE state reached: INCORRECT", tb_test_num);

		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		tb_shift_enable = 1'b0;

		assert(tb_r_error == 1'b1 && tb_rcving == 1'b0)
			$info("Test %d EIDLE state held: CORRECT", tb_test_num);
		else
			$error("Test %d EIDLE state held: INCORRECT", tb_test_num);

		// Test 3: Reset into IDLE state from EIDLE (error flag should disappear)
		tb_test_num += 1;
		@(negedge tb_clk);
		resetDUT();

		assert(tb_r_error == 1'b0 && tb_rcving == 1'b0)
			$info("Test %d IDLE out of reset: CORRECT", tb_test_num);
		else
			$error("Test %d IDLE out of reset: INCORRECT", tb_test_num);

		// Test 4: Send incorrect sync byte again, keep byte_received high
		tb_test_num += 1;
		
		@(negedge tb_clk);
		
		tb_d_edge = 1'b1;

		@(negedge tb_clk);
		tb_d_edge = 1'b0;
		tb_byte_received = 1'b1;
		tb_rcv_data = 8'b10101010;
	
		assert(tb_rcving == 1'b1)
			$info("Test %d rcving flag high in SYNC_ARMED: CORRECT", tb_test_num);
		else
			$error("Test %d rcving flag high in SYNC_ARMED: INCORRECT", tb_test_num);
		@(negedge tb_clk);
		@(negedge tb_clk);
			// Should go into error state
		assert(tb_r_error == 1'b1 && tb_rcving == 1'b1)
			$info("Test %d: CORRECT", tb_test_num);
		else
			$error("Test %d: INCORRECT", tb_test_num);

		// Test 5: Keep going into EIDLE state and see if EIDLE state holds

		tb_test_num +=1;

		@(negedge tb_clk);
	
		tb_eop = 1'b1;
		tb_shift_enable = 1'b1;
		
		@(negedge tb_clk);
		assert(tb_rcving == 1'b1 && tb_r_error == 1'b1)
			$info("Test %d rcving and error flags high in EEOP_VERIFY: CORRECT", tb_test_num);
		else
			$error("Test %d rcving and error flags high in EEOP_VERIFY: INCORRECT", tb_test_num);
		
		@(negedge tb_clk);
		assert(tb_rcving == 1'b1 && tb_r_error == 1'b1)
			$info("Test %d rcving and error flags high in EEOP_TOEIDLE: CORRECT", tb_test_num);
		else
			$error("Test %d rcving and error flags high in EEOP_TOEIDLE: INCORRECT", tb_test_num);

		tb_eop = 1'b0;
		@(negedge tb_clk);

		assert(tb_r_error == 1'b1 && tb_rcving == 1'b0)
			$info("Test %d EIDLE state reached: CORRECT", tb_test_num);
		else
			$error("Test %d EIDLE state reached: INCORRECT", tb_test_num);

		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		tb_shift_enable = 1'b0;

		assert(tb_r_error == 1'b1 && tb_rcving == 1'b0)
			$info("Test %d EIDLE state held: CORRECT", tb_test_num);
		else
			$error("Test %d EIDLE state held: INCORRECT", tb_test_num);

		tb_byte_received = 1'b0;

		// Test 6: Transition from EIDLE to armed

		tb_test_num += 1;
		
		@(negedge tb_clk);
		tb_d_edge = 1'b1;
		@(negedge tb_clk);
		tb_d_edge = 1'b0;
		
		assert(tb_r_error == 1'b0 && tb_rcving == 1'b1)
			$info("Test %d EIDLE transistion to SYNC_ARMED: CORRECT", tb_test_num);
		else
			$error("Test %d EIDLE transition to SYNC_ARMED: INCORRECT", tb_test_num);

		// Test 7: Transition to RECEIVE_BYTE, then cause premature EOP error

		tb_test_num += 1;

		@(negedge tb_clk)

		tb_byte_received = 1;

		@(negedge tb_clk)
		tb_rcv_data = 8'b10000000;
		
		@(negedge tb_clk) // now we are in receive_byte state
		tb_byte_received = 0;
		assert(tb_r_error == 1'b0 && tb_rcving == 1'b1)
			$info("Test %d SYNC_CHECK transistion to RECEIVE_BYTE: CORRECT", tb_test_num);
		else
			$error("Test %d SYNC_CHECK transition to RECEIVE_BYTE: INCORRECT", tb_test_num);

		tb_eop = 1'b1;
		tb_shift_enable = 1'b1;
		@(negedge tb_clk) // Should now be at eeop verify

		tb_eop = 1'b0;
		@(negedge tb_clk);
		@(negedge tb_clk); // shouldn't advance (eop = 0 and shift enable should never happen at this point, but a good way to test)
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);

		assert(tb_r_error == 1'b1 && tb_rcving == 1'b1)
			$info("Test %d RECEIVE_BYTE transistion to EEOP_VERIFY: CORRECT", tb_test_num);
		else
			$error("Test %d RECEIVE_BYTE transistion to EEOP_VERIFY: INCORRECT", tb_test_num);

		// Test 8: Back to RECEIVE_BYTE, but go on to STORE_BYTE and loop until eop = 1.

		tb_test_num += 1;

		resetDUT();

		@(negedge tb_clk);
		tb_d_edge = 1'b1;
		@(negedge tb_clk);
		tb_d_edge = 1'b0;
		
		assert(tb_r_error == 1'b0 && tb_rcving == 1'b1)
			$info("Test %d IDLE transistion to SYNC_ARMED: CORRECT", tb_test_num);
		else
			$error("Test %d IDLE transition to SYNC_ARMED: INCORRECT", tb_test_num);


		@(negedge tb_clk)

		tb_byte_received = 1;

		@(negedge tb_clk)
		tb_rcv_data = 8'b10000000;
		
		@(negedge tb_clk) // now we are in receive_byte state
		tb_byte_received = 1;
		assert(tb_r_error == 1'b0 && tb_rcving == 1'b1)
			$info("Test %d SYNC_CHECK transistion to RECEIVE_BYTE: CORRECT", tb_test_num);
		else
			$error("Test %d SYNC_CHECK transition to RECEIVE_BYTE: INCORRECT", tb_test_num);

		@(negedge tb_clk) // now in STORE_BYTE

		assert(tb_w_enable == 1'b1)
			$info("Test %d RECEIVE_BYTE transistion to STORE_BYTE: CORRECT", tb_test_num);
		else
			$error("Test %d RECEIVE_BYTE transition to STORE_BYTE: INCORRECT", tb_test_num);

		@(negedge tb_clk) // Now to EOP_CHECK

		assert(tb_r_error == 1'b0 && tb_rcving == 1'b1  && tb_w_enable == 1'b0)
			$info("Test %d STORE_BYTE transistion to EOP_CHECK: CORRECT", tb_test_num);
		else
			$error("Test %d STORE_BYTE transition to EOP_CHECK: INCORRECT", tb_test_num);

		tb_eop = 0;
		tb_shift_enable = 1;
		tb_byte_received = 0;

		@(negedge tb_clk) // Back to RECEIVE_BYTE
		@(negedge tb_clk) // Keep holding in RECEIVE_BYTE
		@(negedge tb_clk)
		@(negedge tb_clk)
		tb_byte_received = 1;
		@(negedge tb_clk)

		assert(tb_w_enable == 1'b1)
			$info("Test %d RECEIVE_BYTE loop transistion to STORE_BYTE: CORRECT", tb_test_num);
		else
			$error("Test %d RECEIVE_BYTE loop transition to STORE_BYTE: INCORRECT", tb_test_num);

		// Test 9: Move to IDLE

		tb_test_num += 1;

		@(negedge tb_clk)
		tb_eop = 1;
		tb_d_edge = 0;
		@(negedge tb_clk)
		@(negedge tb_clk)
		@(negedge tb_clk)
		@(negedge tb_clk)
		@(negedge tb_clk)
		@(negedge tb_clk)
		@(negedge tb_clk)

		// Should be in IDLE now
		

		assert(tb_r_error == 1'b0 && tb_rcving == 1'b0)
			$info("Test %d Non-error transition to IDLE: CORRECT", tb_test_num);
		else
			$error("Test %d Non-error transition to IDLE: INCORRECT", tb_test_num);

		




		
		
				
	end
endmodule
