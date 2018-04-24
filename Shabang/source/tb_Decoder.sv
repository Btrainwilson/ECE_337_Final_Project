// $Id: $
// File name:   tb_Decoder.sv
// Created:     4/7/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Manchester Decoder

`timescale 1ns / 10ps

module tb_Decoder();

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
		reg [15:0] Manchester; 
	} Ethernet_Vector;

	Ethernet_Vector Test_Vectors[];
	integer test_i;
	integer man_i;
	

	// Declare DUT portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_Sync_Ether;
	reg tb_Shift_Enable;
	reg tb_Sample;
	reg tb_e_orig;
	reg tb_Idle;

	// DUT Port map
	Decoder DUT(.clk(tb_clk), .n_rst(tb_n_rst), .Sync_Ether(tb_Sync_Ether), .Shift_Enable(tb_Shift_Enable),.Sample(tb_Sample),.Idle(tb_Idle),.e_orig(tb_e_orig));

	//Testing Variables
	integer Test_Num;
	
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

	task Run_Tests;
		input Ethernet_Vector EV;
		integer s;
	begin

		for(test_i = 0; test_i < Test_Vectors.size; test_i++) begin
			for(man_i = 0; man_i < 16; man_i++) begin
				tb_Sync_Ether = Test_Vectors[test_i].Manchester[man_i];
				@(posedge tb_clk);
				@(posedge tb_clk);
				tb_Sample = 1'b1;
				@(posedge tb_clk);
				tb_Sample = 1'b0;
				if(man_i%2 == 0)
					tb_Shift_Enable = 1'b1;
				@(posedge tb_clk);
				if(man_i%2 == 0)
					tb_Shift_Enable = 1'b0;
				@(posedge tb_clk);
				 
			end
		end
		
	
	end
	endtask

	//Manchester Encoding
	
	task Run_Manchester_Encoding;
	begin
		
		for(test_i = 0; test_i < Test_Vectors.size; test_i++) begin
			for(man_i = 0; man_i < 16; man_i+=2) begin
				if(Test_Vectors[test_i].original[man_i/2] == 1'b0) begin
					Test_Vectors[test_i].Manchester[man_i] = 1'b1;
					Test_Vectors[test_i].Manchester[man_i+1] = 1'b0;
				end else begin
					Test_Vectors[test_i].Manchester[man_i] = 1'b0;
					Test_Vectors[test_i].Manchester[man_i+1] = 1'b1;
				end
			end
		end
	
	
	end
	endtask
	
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	

	

	initial 
	begin
	
	Test_Vectors = new[3];
	
	Test_Vectors[0].original = 8'b00000000;
	Test_Vectors[1].original = 8'b11111111;
	Test_Vectors[2].original = 8'b01010101;
	
	Run_Manchester_Encoding;

	end
	
	
	// Test bench main process
	initial
	begin

		// Initial values
		tb_n_rst = 0;
		tb_Sync_Ether = 0;
		tb_Shift_Enable = 0;
		tb_Sample = 0;

		
		// Wait for some time before starting test cases
		#(1ns);
		
		// Power on reset (just inspect on waves)
		reset_dut;
		
		for(Test_Num = 0; Test_Num < Test_Vectors.size(); Test_Num++)
		begin
			Run_Tests(Test_Vectors[Test_Num]);
		end

		

	end


endmodule 
