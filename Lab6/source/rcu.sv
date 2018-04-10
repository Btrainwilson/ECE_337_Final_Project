// $Id: $
// File name:   rcu.sv
// Created:     2/21/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab6: RCU Block

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

	typedef enum  reg [3:0] {IDLE, SYNC_ARMED, SYNC_CHECK, EWAIT_EOP, EEOP_VERIFY, EEOP_TOEIDLE, EIDLE,
				RECEIVE_BYTE, STORE_BYTE, EOP_CHECK, EOP_VERIFY, EOP_TOIDLE} stateType; 

	stateType state, nextstate;
	
	always_ff @(posedge clk, negedge n_rst)
	begin: REGISTER_LOGIC
		if (n_rst == 0)
		begin
			state <= IDLE;
		end
		else
		begin
			state <= nextstate;
		end
	end

	// Next-state logic
	always_comb
	begin: NEXTSTATE_LOGIC
		case(state)

		IDLE: begin
			if(d_edge)
			begin
				nextstate = SYNC_ARMED;
			end		
			else
			begin
				nextstate = IDLE;
			end
		end

		EIDLE: begin
			if(d_edge)
			begin
				nextstate = SYNC_ARMED;
			end		
			else
			begin
				nextstate = EIDLE;
			end
		end

		SYNC_ARMED: begin
			if(byte_received)
			begin
				nextstate = SYNC_CHECK;
			end		
			else
			begin
				nextstate = SYNC_ARMED;
			end
		end

		SYNC_CHECK: begin
			if(rcv_data == 8'b10000000)
			begin
				nextstate = RECEIVE_BYTE;
			end		
			else
			begin
				nextstate = EWAIT_EOP;
			end
		end

		EWAIT_EOP: begin
			if(eop && shift_enable)
			begin
				nextstate = EEOP_VERIFY;
			end		
			else
			begin
				nextstate = EWAIT_EOP;
			end
		end

		EEOP_VERIFY: begin
			if(eop && shift_enable)
			begin
				nextstate = EEOP_TOEIDLE;
			end		
			else
			begin
				nextstate = EEOP_VERIFY;
			end
		end

		EEOP_TOEIDLE: begin
			if(shift_enable)
			begin
				nextstate = EIDLE;
			end		
			else
			begin
				nextstate = EEOP_TOEIDLE;
			end
		end

		RECEIVE_BYTE: begin
			if(byte_received)
			begin
				nextstate = STORE_BYTE;
			end		
			else if (eop && shift_enable)
			begin
				nextstate = EEOP_VERIFY;
			end
			else
			begin
				nextstate = RECEIVE_BYTE;
			end
		end

		STORE_BYTE: begin
			nextstate = EOP_CHECK;
		end

		EOP_CHECK: begin
			nextstate = EOP_CHECK; // Prevent latching
				
			if(shift_enable && ~eop)
			begin
				nextstate = RECEIVE_BYTE;
			end		
			else if (shift_enable && eop)
			begin
				nextstate = EOP_VERIFY;
			end
		end

		EOP_VERIFY: begin
			if(eop && shift_enable)
			begin
				nextstate = EOP_TOIDLE;
			end		
			else
			begin
				nextstate = EOP_VERIFY;
			end
		end

		EOP_TOIDLE: begin
			if(shift_enable)
			begin
				nextstate = IDLE;
			end		
			else
			begin
				nextstate = EOP_TOIDLE;
			end
		end

		default: begin
			nextstate = IDLE;		
		end
		endcase
	end

	// OUTPUT LOGIC

	always_comb
	begin: OUTPUT_LOGIC
		case(state)
		
		IDLE: begin
			rcving = 1'b0;
			w_enable = 1'b0;
			r_error = 1'b0;		
		end

		EIDLE: begin
			rcving = 1'b0;
			w_enable = 1'b0;
			r_error = 1'b1;		
		end

		SYNC_ARMED: begin
			rcving = 1'b1;
			w_enable = 1'b0;
			r_error = 1'b0;		
		end

		SYNC_CHECK: begin
			rcving = 1'b1;
			w_enable = 1'b0;
			r_error = 1'b0;		
		end

		EWAIT_EOP: begin
			rcving = 1'b1;
			w_enable = 1'b0;
			r_error = 1'b1;		
		end

		EEOP_VERIFY: begin
			rcving = 1'b1;
			w_enable = 1'b0;
			r_error = 1'b1;		
		end

		EEOP_TOEIDLE: begin
			rcving = 1'b1;
			w_enable = 1'b0;
			r_error = 1'b1;		
		end

		RECEIVE_BYTE: begin
			rcving = 1'b1;
			w_enable = 1'b0;
			r_error = 1'b0;		
		end

		STORE_BYTE: begin
			rcving = 1'b1;
			w_enable = 1'b1;
			r_error = 1'b0;		
		end

		EOP_CHECK: begin
			rcving = 1'b1;
			w_enable = 1'b0;
			r_error = 1'b0;		
		end

		EOP_VERIFY: begin
			rcving = 1'b1;
			w_enable = 1'b0;
			r_error = 1'b0;		
		end

		EOP_TOIDLE: begin
			rcving = 1'b1;
			w_enable = 1'b0;
			r_error = 1'b0;		
		end

		default: begin
			rcving = 1'b0;
			w_enable = 1'b0;
			r_error = 1'b0;		
		end
		endcase
	end
	

endmodule
