// $Id: $
// File name:   tb_rx_fifo.sv
// Created:     2/17/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: FIFO test bench
`timescale 1ns / 10ps

module tb_rx_fifo ();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 1;
	localparam	FF_SETUP_TIME	= 0.190;
	localparam	FF_HOLD_TIME	= 0.100;
	localparam	CHECK_DELAY 	= (CLK_PERIOD - FF_SETUP_TIME); // Check right before the setup time starts

	reg tb_clk;
	reg tb_n_rst;
	reg tb_r_enable;
	reg tb_w_enable;
	reg [7:0] tb_w_data;
	reg [7:0] tb_r_data;
	reg tb_empty;
	reg tb_full;

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	rx_fifo DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.r_enable(tb_r_enable),
		.w_enable(tb_w_enable),
		.w_data(tb_w_data),
		.r_data(tb_r_data),
		.empty(tb_empty),
		.full(tb_full)

	);

	// Test bench main process
	initial
	begin
		
		// Initialize all of the test inputs
		tb_n_rst	= 1'b0;		// Initialize to be inactive
		tb_r_enable	= 1'b0;
		tb_w_enable 	= 1'b0;
		tb_w_data	= 8'd0;
		

		//Test Sequence of all edges	 
		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_n_rst 	= 1'b1;
		tb_w_enable	= 1'b1;
		tb_w_data	= 8'hFF;

		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_w_enable	= 1'b0;
		tb_w_data	= 8'h00;
		tb_r_enable	= 1'b1;

		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_w_enable	= 1'b1;
		tb_w_data	= 8'h00;

		@(posedge tb_clk); 
		@(negedge tb_clk);
		
		tb_r_enable	= 1'b0;
		tb_w_data	= 8'hFF;

		@(posedge tb_clk); 
		@(negedge tb_clk);
		
		tb_w_data	= 8'hFF;

		@(posedge tb_clk); 
		@(negedge tb_clk);
		
		tb_w_data	= 8'h00;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		
		tb_w_data	= 8'h00;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		
		tb_w_data	= 8'hFF;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		
		tb_w_data	= 8'h00;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		
		tb_w_data	= 8'h00;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		
		tb_w_data	= 8'h00;
		@(posedge tb_clk); 
		@(negedge tb_clk);
		
		tb_w_data	= 8'hFF;

		@(posedge tb_clk); 
		@(negedge tb_clk);
		tb_w_enable 	= 1'b0;
		tb_r_enable 	= 1'b1;
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
		tb_r_enable 	= 1'b0;
		tb_n_rst 	= 1'b0;


		//Organized Testing
		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_n_rst 	= 1'b1;
		tb_w_data 	= 8'hFF;
		tb_w_enable	= 1'b1;

		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_r_enable 	= 1'b1;
		tb_w_enable	= 1'b0;

		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_r_enable 	= 1'b0;
		tb_w_data 	= 8'hFF;
		tb_w_enable	= 1'b1;

		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_r_enable 	= 1'b1;
		tb_w_enable	= 1'b0;

		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_r_enable 	= 1'b0;
		tb_w_data 	= 8'h00;
		tb_w_enable	= 1'b1;

		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_r_enable 	= 1'b1;
		tb_w_enable	= 1'b0;

		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_r_enable 	= 1'b0;
		tb_w_data 	= 8'h00;
		tb_w_enable	= 1'b1;

		@(posedge tb_clk); 
		@(negedge tb_clk);

		tb_r_enable 	= 1'b1;
		tb_w_enable	= 1'b0;

	end

	


endmodule
