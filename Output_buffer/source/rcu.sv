// $Id: $
// File name:   rcu.sv
// Created:     2/26/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: receiver control unit that controls operation of usb receiver
`timescale 1ns/10ps
module rcu
(
	input wire clk,
	input wire n_rst,
	input wire d_edge,
	input wire eop,
	input wire shift_enable,
	input wire [7:0] rcv_data,
	input wire byte_received,
	output reg rcving,
	output reg w_enable,
	output reg r_error
);

typedef enum logic [3:0] {IDLE, D_SYNC, SYNC_CH, SYNC_E, S_W, BYTE_D, FIRST_BIT, BYTE_FIN, IDLE_W, D_EDGE_W} state_type;

state_type state, nextstate;

always_ff @ (posedge clk, negedge n_rst) begin
	if(n_rst == 0) begin
		state <= IDLE;
	end
	else begin
		state <= nextstate;
	end
end


always_comb begin
	nextstate = state;
	case(state)
	IDLE: begin
		if(d_edge == 1) begin
			nextstate = D_SYNC;
		end
	end
	D_SYNC: begin
		if(byte_received == 1) begin
			nextstate = SYNC_CH;
		end
	end
	SYNC_CH: begin
		if(rcv_data == 8'b10000000) begin
			nextstate = FIRST_BIT;
		end
		else begin
			nextstate = SYNC_E;
		end
	end
	FIRST_BIT: begin
		if(eop == 1 && shift_enable == 1) begin
			nextstate = IDLE_W;
		end
		else if (eop == 0 && shift_enable == 1) begin
			nextstate = BYTE_D;
		end
	end
	SYNC_E: begin
		if(eop == 1 && shift_enable == 1) begin
			nextstate = S_W;
		end
	end
	S_W: begin
		if(d_edge == 1) begin
			nextstate = IDLE;
		end
	end
	BYTE_D: begin
		if(byte_received == 1) begin
			nextstate = BYTE_FIN;
		end
		else if(byte_received == 0 && eop == 1 && shift_enable == 1) begin
			nextstate = SYNC_E;
		end
	end
	IDLE_W: begin
		if(d_edge == 1) begin
			nextstate = IDLE;
		end
	end
	BYTE_FIN: begin
		nextstate = FIRST_BIT;
	end
	D_EDGE_W: begin
		if(d_edge == 1) begin
			nextstate = D_SYNC;
		end
	end
	endcase
end

assign rcving = ((state == D_SYNC) || (state == SYNC_CH) || (state == FIRST_BIT) || (state == SYNC_E) || (state == S_W) || (state == BYTE_D) || (state == IDLE_W) || (state == BYTE_FIN));
assign w_enable = (state == BYTE_FIN);
assign r_error = ((state == SYNC_E) || (state == S_W) || (state == D_EDGE_W));

endmodule
