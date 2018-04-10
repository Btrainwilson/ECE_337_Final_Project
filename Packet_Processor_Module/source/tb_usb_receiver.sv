// $Id: $
// File name:   tb_usb_receiver
// Created:     2/23/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: USB Receiver test bench
`timescale 1ns / 10ps

module tb_usb_receiver ();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 1;
	localparam	FF_SETUP_TIME	= 0.190;
	localparam	FF_HOLD_TIME	= 0.100;
	localparam	CHECK_DELAY 	= (CLK_PERIOD - FF_SETUP_TIME); // Check right before the setup time starts

	reg tb_clk;
	reg tb_n_rst;
	reg tb_d_plus;
	reg tb_d_minus;
	reg tb_r_enable;
	reg [7:0] tb_r_data;
	reg tb_empty;
	reg tb_full;
	reg tb_rcving;
	reg tb_r_error;

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	//USB Receiver Test DUT
	usb_receiver DUT
	(
	.clk(tb_clk),
	.n_rst(tb_n_rst),
	.d_plus(tb_d_plus),
	.d_minus(tb_d_minus),
	.r_enable(tb_r_enable),
	.r_data(tb_r_data),
	.empty(tb_empty),
	.full(tb_full),
	.rcving(tb_rcving),
	.r_error(tb_r_error));

	//Task Declarations
	task reset_USB;
	begin
		tb_d_plus = 1'b1;
		tb_d_minus = 1'b0;
		tb_n_rst = 1'b0;
		@(posedge tb_clk);
		@(negedge tb_clk);
		tb_n_rst = 1'b1;
		tb_r_enable = 1'b0;
		@(posedge tb_clk);
		@(negedge tb_clk);
		@(posedge tb_clk);
		@(negedge tb_clk);
	end
	endtask

	task send_EOP;
	begin

		tb_d_plus = 1'b0;
		tb_d_minus = 1'b0;
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
	@(negedge tb_clk);

	end
	endtask

	task send_Byte;
	input [7:0] rec_Byte;
	integer i,j;
	begin
		for(i = 7; i >= 0; i = i - 1)begin
			tb_d_plus = rec_Byte[i];
			tb_d_minus = ~rec_Byte[i];
			for(j = 0; j < 8; j = j + 1) begin
				@(posedge tb_clk);
				@(negedge tb_clk);
			end
		end
		
	end
	endtask


	// Test bench main process
	initial
	begin

	reset_USB;
	
	send_Byte(8'b01010100);
	send_Byte(8'b01010100);
	send_Byte(8'b01010100);
	send_Byte(8'b01010100);
	send_EOP;
	send_EOP;
	tb_r_enable = 1'b1;
	tb_d_plus = 1'b1;
	tb_d_minus = 1'b0;
	send_Byte(8'b01010100);
	send_EOP;
	send_EOP;
	end

	


endmodule
