// $Id: $
// File name:   CRC_Calculator.sv
// Created:     4/17/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Calculates CRC
`timescale 1ns / 10ps
module CRC_Calculator(
	input 	wire clk,
		wire n_rst,
		wire bit_in,			//Shift in new bit
		wire new_bit,			//new bit to be shifted in
		wire reset,			//Synchronous reset 
		wire CRC_Calc,			//Signal for performing CRC_Calc and CRC_Send
	output 	reg CRC_Send,			//Signal to tell TXPU it is ready to transmit CRC bytes (1:1) (CRC = 1 While CRC is sending)
		reg serial_out,			//Serial out for transmitting to bit stuffer
		reg [15:0]CRC_Bytes
		
 
);

	

	//Polynomial for CRC Calculate
	reg [16:0]CRC_poly = 17'b11000000000000101;

	//Load Enable for register
	reg load_enable;

	//Serial in for Shift Register
	reg Serial_In;

	//Parallel in and out registers
	reg [16:0]Parallel_out;
	reg [16:0]Parallel_in;

	//P_Calc shift enable
	reg P_Shift;
	reg Shift_Enable;

	//Assignments to output
	always_comb 
	begin : REG_Assignments
		//serial_out = Parallel_out[16];
		CRC_Bytes = Parallel_out[15:0];
		Serial_In = ~CRC_Calc & bit_in;
		Shift_Enable = P_Shift || (~CRC_Calc & new_bit) || (P_Shift & new_bit);
	end

	//Register for CRC Calculation

	flex_pio_si #(17) CRC_Register (.clk(clk),.n_rst(n_rst),.shift_enable(Shift_Enable),.s_reset(reset),.serial_in(Serial_In),.load_enable(load_enable),.parallel_in(Parallel_in),.parallel_out(Parallel_out),.serial_out(serial_out));

	
		
	//Simple FSM for CRC Module
	reg [4:0]count;

	typedef enum bit [2:0] {IDLE,D,P,XOR,P_Calc,D_Calc,Send} stateType;

	stateType state;
	stateType nxtstate;

	always_ff @ (negedge n_rst, posedge clk)
	begin : REG_L
		if(1'b0 == n_rst) begin
			state <= IDLE;
			count <= 5'b00000;
			 end
		else begin
			if(reset == 1'b1) state <= IDLE;
			else state <= nxtstate;

			if(state == D_Calc) count <= count + 1;
			if(state == P) count <= 5'b00000;
		end

	end


	//State Logic
	always_comb
	begin : NXT_ST_LOGIC

		nxtstate = state;

		case(state)

		IDLE:
			begin
				if(bit_in == 1'b1) nxtstate = D;
			end
		D:
			begin
				if(serial_out == 1'b1) nxtstate = XOR;
				else if (CRC_Calc == 1'b1) nxtstate = P_Calc;
				else nxtstate = P;
			end
		P:
			begin
				if(bit_in == 1'b1) nxtstate = D;
				if(CRC_Calc == 1'b1) nxtstate = P_Calc;
			end
		XOR:
			begin
				if(CRC_Calc == 1'b1) nxtstate = P_Calc;
				else 	nxtstate = P;
			end
		D_Calc:
			begin
				if(serial_out == 1'b1) nxtstate = XOR;
				else nxtstate = P_Calc;
			end
		P_Calc:
			begin
				if(count == 5'b10000) nxtstate = Send;
				else nxtstate = D_Calc;
			end
		Send:
			begin
				
				if(CRC_Calc == 1'b0) nxtstate = IDLE;
			end
		endcase

	end


	always_comb
	begin : Output_Logic
		

		Parallel_in = Parallel_in;
		P_Shift = 1'b0;
		CRC_Send = 1'b0;
		load_enable = 1'b0;
		case(state)

		P:
			begin
				
				Parallel_in = Parallel_out ^ CRC_poly;
			end
		P_Calc:
			begin
				Parallel_in = Parallel_out ^ CRC_poly;
				P_Shift = 1'b1;
			end
		XOR:
			begin
				load_enable = 1'b1;
				
			end

		Send: begin
				CRC_Send = 1'b1;
				//P_Shift <= 1'b1;
			end

		endcase

	end



endmodule
