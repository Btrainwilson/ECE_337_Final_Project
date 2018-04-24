// $Id: $
// File name:   rcu.sv
// Created:     2/22/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: RCU Controller

module rcu (
	input wire clk,
	input wire n_rst,
	input wire d_edge,
	input wire eop,
	input wire shift_enable,
	input wire [7:0]rcv_data,
	input wire byte_received,
	output reg rcving,
	output reg w_enable,
	output reg r_error

);

typedef enum bit [3:0] {IDLE,Receive,eidle,Byte_In_Check,Receive_Bit,Byte_Sync_Junk,Done,FIFO,Byte_error,Error,pre_eidle,EOP_Check} stateType;

	stateType state;
	stateType nxtstate;

	always_ff @ (negedge n_rst, posedge clk) begin
		if(1'b0 == n_rst) begin
			state <= IDLE;
		end else begin
			state <= nxtstate;
		end
	end


	
	always_comb
	begin : NXT_ST_LOGIC

		nxtstate = state;

		case(state)

		IDLE:
			begin
				if(d_edge)
					nxtstate = Receive;
			end
		Receive:
			begin
				if(byte_received)
					nxtstate = Byte_In_Check;
			end
		Byte_In_Check:
			begin
				//Check Byte == SYNC ??
				if(rcv_data == 8'b10000000)
					nxtstate = Byte_Sync_Junk;
				else 
					nxtstate = Byte_error;
			end
		Byte_Sync_Junk:
			begin
				if(shift_enable)
					nxtstate = Receive_Bit;
			end
		Receive_Bit:
			begin
				if(byte_received)
					nxtstate = FIFO;
				else if(eop & shift_enable)
					nxtstate = Error;
			end

		Done:
			begin
				if(shift_enable)
					nxtstate = IDLE;
			end
		FIFO:
			begin
				if(~eop & shift_enable)					
					nxtstate = Receive_Bit;
				else if(eop & shift_enable)
					nxtstate = EOP_Check;
			end
		EOP_Check:
			begin
				if(eop & shift_enable)
					nxtstate = Done;
			end
		Byte_error:
			begin
				if(eop & shift_enable)
					nxtstate = Error;
			end
		Error:
			begin
				if(eop & shift_enable)
					nxtstate = pre_eidle;
			end
		pre_eidle:
			begin
				if(shift_enable)
					nxtstate = eidle;
			end
		eidle:
			begin
				if(d_edge)
					nxtstate = Receive;
			end
		endcase

	end


	
	always_comb
	begin : Output_Logic
		//Default to avoid latches
		
		rcving = 1'b1;
		r_error = 1'b0;
		w_enable = 1'b0;

		case(state)
		

		IDLE:
			begin
				rcving = 1'b0;
			end
		Receive:
			begin
				
			end
		Byte_In_Check:
			begin
				
			end
		Receive_Bit:
			begin
				
			end
		FIFO:
			begin
				if(shift_enable)
					w_enable = 1'b1;
				else
					w_enable = 1'b0;
			end
		Done:
			begin
				
			end
		Byte_error:
			begin
				r_error = 1'b1;
			end
		Error:
			begin
				r_error = 1'b1;
			end
		pre_eidle:
			begin
				r_error = 1'b1;
			end
		eidle:
			begin
				r_error = 1'b1;
				rcving = 1'b0;
			end

		endcase
		

		

	end


endmodule
