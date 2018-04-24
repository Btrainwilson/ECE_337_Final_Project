// $Id: $
// File name:   ERCU.sv
// Created:     4/7/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: ERCU controller

module ERCU
(
	input 	wire clk,
		wire n_rst,
		wire d_edge,
		wire Idle,
		wire [7:0]E_Data,
		wire [3:0]count,
	output	reg ERCU_w,
		reg reset,
		reg cnt_rst,
		reg rcving
);

typedef enum bit [4:0] {IDLE,PRE,Pre_Error,EIDLE,CLR_A,DEST,CLR_B,Write_Data,CLR_D,WAIT} stateType;

	stateType state;
	stateType nxtstate;

	always_ff @ (negedge n_rst, posedge clk)
	begin : REG_L
		if(1'b0 == n_rst)
			state <= IDLE;
		else
			state <= nxtstate;

	end


	//State Logic
	always_comb
	begin : NXT_ST_LOGIC

		nxtstate = state;

		case(state)

		IDLE:
			begin
				if(d_edge) nxtstate = PRE;
			end
		PRE:
			begin
				if((count == 4'b1000) & (E_Data == 8'b10101011)) nxtstate = CLR_A;
				else if((count == 4'b1000) & (E_Data != 8'b10101011)) nxtstate = Pre_Error;
			end
		Pre_Error:
			begin
				if(Idle == 1'b1) nxtstate = EIDLE;
			end
		EIDLE:
			begin
				if(d_edge) nxtstate = PRE;
			end
		CLR_A:
			begin
				nxtstate = DEST;
			end
		DEST:
			begin
				if(count == 4'b0101) nxtstate = CLR_B;
				
			end
		CLR_B:
			begin
				nxtstate = Write_Data;
			end
		Write_Data:
			begin
				if(count == 4'b1000) nxtstate = CLR_D;
			end
		CLR_D:
			begin
				nxtstate = WAIT;
			end
		WAIT:
			begin
				if(Idle == 1'b1) nxtstate = IDLE;
			end
		

		endcase

	end


	always_comb
	begin : Output_Logic

		
		rcving = 1'b1;
		ERCU_w = 1'b0;
		cnt_rst = 1'b0;
		reset = 1'b0;

		case(state)

		
		IDLE:
			begin
				rcving = 1'b0;
				cnt_rst = 1'b1;
				reset = 1'b1;
				
			end
		EIDLE:
			begin
				rcving = 1'b0;
				cnt_rst = 1'b1;
				reset = 1'b1;
			end
		CLR_A:
			begin
				cnt_rst = 1'b1;
			end
		CLR_B:
			begin
				cnt_rst = 1'b1;
			end
		Write_Data:
			begin
				ERCU_w = 1'b1;
			end
		CLR_D:
			begin
				cnt_rst = 1'b1;
			end
		

		endcase

	end

endmodule
