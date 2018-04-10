// $Id: $
// File name:   tb_Packet_Processor.sv
// Created:     4/7/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Packet Processor
`timescale 1ns / 10ps
module tb_Packet_Processor();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 1;
	localparam	FF_SETUP_TIME	= 0.190;
	localparam	FF_HOLD_TIME	= 0.100;
	localparam	CHECK_DELAY 	= (CLK_PERIOD - FF_SETUP_TIME); // Check right before the setup time starts
	
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
	reg tb_clk;
	reg tb_n_rst;
	reg tb_ethernet;
	reg [7:0]tb_e_data;
	reg tb_w_en;
	reg tb_full;

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

//------------------------------------------------------------DUT Port Map----------------------------------------------------------------------



	Packet_Processor DUT (.clk(tb_clk),.n_rst(tb_n_rst),.Ethernet_In(tb_ethernet),.FULL(tb_full),.E_Data(tb_e_data),.w_enable(tb_w_en));

//------------------------------------------------------------Task Definitions----------------------------------------------------------------------

	//Task Variables
	integer pre_i;
	integer man_i;
	integer send_i;

	//Ethernet Bytes
	Ethernet_Byte Preamble;
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

		
		Preamble.original = 8'b10101010;
		Preamble = convert_to_Manchester(Preamble);
		
		SFD.original = 8'b10101011;
		SFD = convert_to_Manchester(SFD);
		
		DA.original = 8'b11111011;
		DA = convert_to_Manchester(DA);
		
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
		
		
	end
	endtask

	//Standard Gap Between Manchester Bit Samples
	task Bit_Gap;
	begin
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
		@(negedge tb_clk);
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
			@(negedge tb_clk);
	end

	endtask

	//Reset Task
	task reset_dut;
	begin
		// Activate the design's reset (does not need to be synchronize with clock)
		tb_n_rst = 1'b0;
		
		// Wait for a couple clock cycles
		@(posedge tb_clk);
		@(posedge tb_clk);
		
		// Release the reset
		@(negedge tb_clk);
		tb_n_rst = 1;
		
		// Wait for a while before activating the design
		@(posedge tb_clk);
		@(posedge tb_clk);
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

//-------------------------------------------------------Test Section------------------------------
	Ethernet_Byte temp_byte;

	//Task to Test Packet
	task Good_Packet;
		input Packet in_packet;
	begin
		reset_dut;
		inter_Gap;
		for(pre_i = 0; pre_i < 7; pre_i++)
			Good_Sender(in_packet.p_PRE); 
		Good_Sender(in_packet.p_SFD);
		
		for(pre_i = 0; pre_i < 6; pre_i++)
			Good_Sender(in_packet.p_DA);
		for(pre_i = 0; pre_i < 6; pre_i++)
			Good_Sender(in_packet.p_SA[pre_i]);
		for(pre_i = 0; pre_i < 2; pre_i++)
		 	Good_Sender(in_packet.p_LEN[pre_i]);
		for(pre_i = 0; pre_i < in_packet.d_length; pre_i++)
			Good_Sender(in_packet.p_DATA);
		for(pre_i = 0; pre_i < in_packet.c_length; pre_i++)
			Good_Sender(in_packet.p_CHECK);

		inter_Gap;
	end
	endtask

	//Send Packets
	initial
	begin
	//Initialize Constants
	initialize;
	//Test One
	Good_Packet(Packets[0]);

	end
	

endmodule
