// $Id: $
// File name:   tb_transmitter.sv
// Created:     4/20/2018 (LIIIIIIIIT)
// Author:      "Stan who drives a Ford"
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB transmitter testbench

`timescale 1ns / 10ps

module tb_shabang();

	// Define local parameters used by the test bench
	localparam	USB_CLK_PERIOD		= 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.  Everything will be stabilized at 96 MHz after initial syncing)
	localparam 	ETHERNET_CLK_PERIOD	= 10.0;
	//localparam	SLOW_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 1.035;
	//localparam 	FAST_CLK_PERIOD		= 10.0 * 100.0 / 96.0 * 0.965;
	localparam 	LINE_CLK_PERIOD		= USB_CLK_PERIOD;

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
	reg tb_USB_clk;
	reg tb_ETH_clk;	
	reg [7:0] tb_FIFO_byte;
	reg tb_fifo_ready;
	//reg tb_r_en;
	reg tb_is_txing;
	reg tb_ethernet;
	//tri1 tb_d_plus; // Tri state
	//tri1 tb_d_minus;	// Tri state

	// Test bench input/output pins
	reg tb_rx_d_plus;
	reg tb_tx_d_plus;
	reg tb_rx_d_minus;
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

// ------------------------------ Ethernet Declarations ----------------------------
	localparam	RESET_OUTPUT_VALUE	= 1'b0;

	// Custom Ethernet Vector
	typedef struct
	{
		reg [7:0] original;
		reg [7:0][1:0] Encoding; 
	} Ethernet_Byte;

	typedef struct
	{
		reg [7:0][1:0] p_PRE;
		reg [7:0][1:0] p_SFD;
		reg [7:0][1:0] p_DA;
		reg [7:0][1:0] p_SA[5:0];
		reg [7:0][1:0] p_LEN[1:0];
		reg [7:0][1:0] p_DATA;
		reg [7:0][1:0] p_CHECK;

		//Test Values for Verification
		reg [7:0] t_p_SA[5:0];	
		reg [7:0] t_p_LEN[1:0];	
		integer d_length;
		integer c_length;
		

	} Packet;

	//Test Variables
	integer current_packet;
	integer total_packets;
	integer pass_count;
	integer fail_count;
	
	
	
// ----------------------------- Clock generation blocks ---------------------------
	always
	begin
		tb_USB_clk = 1'b0;
		#(USB_CLK_PERIOD/2.0);
		tb_USB_clk = 1'b1;
		#(USB_CLK_PERIOD/2.0);
	end

	always
	begin
		tb_ETH_clk = 1'b0;
		#(ETHERNET_CLK_PERIOD/2.0);
		tb_ETH_clk = 1'b1;
		#(ETHERNET_CLK_PERIOD/2.0);
	end

	always
	begin
		tb_line_clk = 1'b0;
		#(LINE_CLK_PERIOD/2.0);
		tb_line_clk = 1'b1;
		#(LINE_CLK_PERIOD/2.0);
	end

	
	// DUT Port map
	shabang DUT(.w_clk(tb_ETH_clk), .r_clk(tb_USB_clk), .n_rst(tb_n_rst),
		    .Ethernet_In(tb_ethernet), .rx_d_plus(tb_rx_d_plus),
		    .rx_d_minus(tb_rx_d_minus), .tx_d_plus(tb_tx_d_plus),
		    .tx_d_minus(tb_tx_d_minus), .is_txing(tb_is_txing));

	
// ------------------------ USB TASKS -----------------------------------------	


	task resetDUT;
	begin
		// Power-on reset of DUT
		tb_n_rst = 1'b0;
		@(negedge tb_USB_clk);
		@(negedge tb_USB_clk);
		tb_n_rst = 1'b1;
		@(negedge tb_USB_clk);
		@(negedge tb_USB_clk);

	end
	endtask

	task check_byte;   // Send a starting byte via the FIFO lines
		input [7:0] line_byte;  // What the output should be
		input [7:0] next_line_byte; // What the output will be next
	begin
		tb_d_plus_prev = tb_tx_d_plus;
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
				@(negedge tb_USB_clk);
			end
			stuffing_detected = 0;

			if (tb_tx_d_plus != tb_d_plus_prev)
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
			tb_d_plus_prev = tb_tx_d_plus;
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
			$info("Test %d - send %d%d%d%d%d%d%d%d : PASSED", tb_test_num, line_byte[7], line_byte[6], line_byte[5], line_byte[4], line_byte[3], line_byte[2], line_byte[1], line_byte[0]);
		end
		else
		begin
			$info("Test %d - send %d%d%d%d%d%d%d%d : FAILED", tb_test_num, line_byte[7], line_byte[6], line_byte[5], line_byte[4], line_byte[3], line_byte[2], line_byte[1], line_byte[0]);
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
			tb_rx_d_plus = ~tb_rx_d_plus;
			tb_rx_d_minus = ~tb_rx_d_plus;
			for(j = 0; j < 8; j++)
			begin
				@(negedge tb_line_clk);
			end
		end
		else
		begin
			tb_rx_d_plus = tb_rx_d_plus;
			tb_rx_d_minus = ~tb_rx_d_plus;
			for(j = 0; j < 8; j++)
			begin
				@(negedge tb_line_clk);
			end
		end
	end
	endtask

	task send_eop;
	begin
		tb_rx_d_plus = 0;
		tb_rx_d_minus = 0;
		for(j = 0; j < 16; j++)
		begin
			@(negedge tb_line_clk);
		end
		tb_rx_d_plus = 1;
		tb_rx_d_minus = 0;
		
	end
	endtask


// ------------------------------------- ETHERNET TASKS -----------------------

	
	//Task Variables
	integer pre_i;
	integer man_i;
	integer send_i;

	//Ethernet Bytes
	Ethernet_Byte Preamble;
	Ethernet_Byte new_DA;
	Ethernet_Byte newData;
	Ethernet_Byte SFD;
	Ethernet_Byte DA;
	Ethernet_Byte Data_Byte;
	Ethernet_Byte Check_Sum;
	Packet Packets[];
	integer g_i;
	//Initialize Packets
	task initialize;
	begin

		//Initialize All Header Constants
		
			//Note: DA, Data_Byte, and Check_Sum values do not matter because we do not need to check for correctness in them, therefore, 
			//so long as the bytes are repeated the correct number of times the correct output is expected. 
		current_packet = 0;
		total_packets = 3;
		pass_count = 0;
		fail_count = 0;
		//tb_r_en = 0;
		//tb_full = 1'b0;
		
		Preamble.original = 8'b10101010;
		Preamble = convert_to_Manchester(Preamble);
		
		SFD.original = 8'b10101011;
		SFD = convert_to_Manchester(SFD);
		
		DA.original = 8'b11111011;
		DA = convert_to_Manchester(DA);

		new_DA.original = 8'b10100011;
		new_DA = convert_to_Manchester(new_DA);
		
		Data_Byte.original = 8'b00001111;
		Data_Byte = convert_to_Manchester(Data_Byte);

		Check_Sum.original = 8'b11110000;
		Check_Sum = convert_to_Manchester(Check_Sum);

		

		Packets = new[3];

		//Generate Basic Packet

		Packets[0].p_PRE = Preamble.Encoding;
		Packets[0].p_SFD = SFD.Encoding;
		Packets[0].p_DA = DA.Encoding;
		
		for(g_i = 0; g_i < 6; g_i++)begin
			Packets[0].p_SA[g_i] = DA.Encoding;
			Packets[0].t_p_SA[g_i] = DA.original;
		end

		Packets[0].p_LEN[0] = DA.Encoding;
		Packets[0].t_p_LEN[0] = DA.original;
		Packets[0].p_LEN[1] = DA.Encoding;
		Packets[0].t_p_LEN[1] = DA.original;

		Packets[0].p_CHECK = DA.Encoding;
		Packets[0].p_DATA = Data_Byte.Encoding;
		Packets[0].d_length = 4;
		Packets[0].c_length = 2;

		//Make Simple Copies
		Packets[1] = Packets[0];
		Packets[2] = Packets[0];

		//Tests for r_enable correctness
		for(g_i = 0; g_i < 6; g_i++)begin
			Packets[1].p_SA[g_i] = new_DA.Encoding;
			Packets[1].t_p_SA[g_i] = new_DA.original;
		end
		
		
		
	end
	endtask

	//Standard Gap Between Manchester Bit Samples
	task Bit_Gap;
	begin
		@(negedge tb_ETH_clk);
		@(negedge tb_ETH_clk);
		@(negedge tb_ETH_clk);
		@(negedge tb_ETH_clk);
		@(negedge tb_ETH_clk);
	end
	endtask

	//Generic Sender
	task Good_Sender;
		input reg [7:0][1:0] send_byte;
		begin
			
			for(send_i = 7; send_i >= 0; send_i--) begin
				tb_ethernet = send_byte[send_i][1];
				Bit_Gap;
				tb_ethernet = send_byte[send_i][0];
				Bit_Gap;
			
			end
		end
	endtask



	//Interpacket Gap
	task inter_Gap;
	begin
		tb_ethernet = 1'b1;
		for(man_i = 0; man_i < 20; man_i++)
			@(negedge tb_ETH_clk);
	end

	endtask

	//Convert Original Byte to Manchester
	integer con_i;

	//Conversion Task
	function Ethernet_Byte convert_to_Manchester;
	input Ethernet_Byte ether_byte;
		begin
			for(con_i = 0; con_i < 8; con_i++) begin
				if(ether_byte.original[con_i] == 1'b1) begin
					ether_byte.Encoding[con_i][1:0] = 2'b01;
				end else begin
					ether_byte.Encoding[con_i][1:0] = 2'b10;
				end
			end
			convert_to_Manchester = ether_byte;
		end
  	endfunction


	// From ethernet test section

	Ethernet_Byte temp_byte;

	//Task to Test Packet
	task Good_Packet;
		input Packet in_packet;
	begin
		//reset_dut;
		inter_Gap;
		for(pre_i = 0; pre_i < 7; pre_i++)
			Good_Sender(in_packet.p_PRE); 
		//Send SFD
		Good_Sender(in_packet.p_SFD);
		//Send DA
		for(pre_i = 0; pre_i < 6; pre_i++)
			Good_Sender(in_packet.p_DA);
		//Send SA
		for(pre_i = 0; pre_i < 6; pre_i++) begin
			//tb_test_e_data = in_packet.t_p_SA[pre_i];
			Good_Sender(in_packet.p_SA[pre_i]);
		end
		//Send LEN
		for(pre_i = 0; pre_i < 2; pre_i++) begin
			//tb_test_e_data = in_packet.t_p_LEN[pre_i];
		 	Good_Sender(in_packet.p_LEN[pre_i]); end
		//Send Data
		for(pre_i = 0; pre_i < in_packet.d_length; pre_i++)
			Good_Sender(in_packet.p_DATA);
		//Send Checksum
		for(pre_i = 0; pre_i < in_packet.c_length; pre_i++)
			Good_Sender(in_packet.p_CHECK);

		inter_Gap;
	end
	endtask

	//Long Packet Sender
	task Long_Packet;
		input Packet in_packet;
	begin
		//reset_dut;
		inter_Gap;
		for(pre_i = 0; pre_i < 7; pre_i++)
			Good_Sender(in_packet.p_PRE); 
		//Send SFD
		Good_Sender(in_packet.p_SFD);
		//Send DA
		for(pre_i = 0; pre_i < 6; pre_i++)
			Good_Sender(in_packet.p_DA);
		//Send SA
		for(pre_i = 0; pre_i < 6; pre_i++) begin
			//tb_test_e_data = in_packet.t_p_SA[pre_i];
			Good_Sender(in_packet.p_SA[pre_i]);
		end
		//Send LEN
		for(pre_i = 0; pre_i < 2; pre_i++) begin
			//tb_test_e_data = in_packet.t_p_LEN[pre_i];
		 	Good_Sender(in_packet.p_LEN[pre_i]); end
		//Send Data
		for(pre_i = 0; pre_i < 1500; pre_i++)
			Good_Sender(in_packet.p_SA[0]);
		//Send Checksum
		for(pre_i = 0; pre_i < in_packet.c_length; pre_i++)
			Good_Sender(in_packet.p_CHECK);

		inter_Gap;
	end
	endtask

//─▄▀▀▀▀▄─█──█────▄▀▀█─▄▀▀▀▀▄─█▀▀▄
//─█────█─█──█────█────█────█─█──█
//─█────█─█▀▀█────█─▄▄─█────█─█──█
//─▀▄▄▄▄▀─█──█────▀▄▄█─▀▄▄▄▄▀─█▄▄▀

//─────────▄██████▀▀▀▀▀▀▄
//─────▄█████████▄───────▀▀▄▄
//──▄█████████████───────────▀▀▄
//▄██████████████─▄▀───▀▄─▀▄▄▄──▀▄
//███████████████──▄▀─▀▄▄▄▄▄▄────█
//█████████████████▀█──▄█▄▄▄──────█
//███████████──█▀█──▀▄─█─█─█───────█
//████████████████───▀█─▀██▄▄──────█
//█████████████████──▄─▀█▄─────▄───█
//█████████████████▀███▀▀─▀▄────█──█
//████████████████──────────█──▄▀──█
//████████████████▄▀▀▀▀▀▀▄──█──────█
//████████████████▀▀▀▀▀▀▀▄──█──────█
//▀████████████████▀▀▀▀▀▀──────────█
//──███████████████▀▀─────█──────▄▀
//──▀█████████████────────█────▄▀
//────▀████████████▄───▄▄█▀─▄█▀
//──────▀████████████▀▀▀──▄███
//──────████████████████████─█
//─────████████████████████──█
//────████████████████████───█
//────██████████████████─────█
//────██████████████████─────█
//────██████████████████─────█
//────██████████████████─────█
//────██████████████████▄▄▄▄▄█

//─────────────█─────█─█──█─█───█
//─────────────█─────█─█──█─▀█─█▀
//─────────────█─▄█▄─█─█▀▀█──▀█▀
//─────────────██▀─▀██─█──█───█

// ------------------------------------- TEST CODE ----------------------------

	initial // SHABANG TESTS BAYBEEE
	begin

	// Initializations
	tb_ethernet = 1;
	tb_rx_d_plus = 1;
	tb_rx_d_minus = 0;
	number_of_consecutive_ones_sent = 0;
	tb_test_num = 0;
	//Initialize Ethernet Constants
	initialize;

	// Reset DUT
	resetDUT();

	// Test 1: Send sync byte, correct PID,DUT_address.  Will send nak (fifo not ready).
	tb_test_num = 1;
	send_byte(8'b10000000);
	send_byte(IN_PID);
	send_byte(DUT_ADDR);
	send_eop(); // Should trigger the transmitter into action
	// wait for the transmitter to activate.
	tb_rx_d_plus = 1;
	tb_rx_d_minus = 0; // send the tb "transmitter" into idle
	// Start checking for a NAK response
	check_byte(SYNC_BYTE, NAK_PID); // Sync first
	check_byte(NAK_PID, 8'b11111111); // Will go into idle after nak

	// Test 2: Send 3 Ethernet packets.  Prompt Transceiver. Receive NAK.
	tb_test_num += 1;

	for(current_packet = 0; current_packet < total_packets; current_packet++) begin
		Good_Packet(Packets[current_packet]);
	end

	//resetDUT();
	@(negedge tb_USB_clk);
	@(negedge tb_USB_clk);
	send_byte(8'b10000000);
	send_byte(IN_PID);
	send_byte(DUT_ADDR);
	send_eop(); // Should trigger the transmitter into action
	// wait for the transmitter to activate.
	 // send the tb "transmitter" into idle
	// Start checking for a NAK response
	check_byte(SYNC_BYTE, NAK_PID); // Sync first
	check_byte(NAK_PID, 8'b11111111); // Will go into idle after nak


	// Test 3: Send 6 more packets.  Prompt Transceiver.  Receive DATA.
	tb_test_num += 1;
	
	for(current_packet = 0; current_packet < total_packets; current_packet++) begin
		Good_Packet(Packets[current_packet]);
	end
	
	for(current_packet = 0; current_packet < total_packets; current_packet++) begin
		Good_Packet(Packets[current_packet]);
	end

	send_byte(8'b10000000);
	send_byte(IN_PID);
	send_byte(DUT_ADDR);
	send_eop(); // Should trigger the transmitter into action
	// wait for the transmitter to activate.
	tb_rx_d_plus = 1;
	tb_rx_d_minus = 0; // send the tb "transmitter" into idle

	Packets[0].d_length = 1500;
	Long_Packet(Packets[0]);
	//tb_r_en = 1'b1;
	inter_Gap;
	inter_Gap;
	inter_Gap;
	inter_Gap;
	inter_Gap;
	inter_Gap;
	//tb_r_en = 1'b0;
	


	end


endmodule
