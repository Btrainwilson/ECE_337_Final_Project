// $Id: $
// File name:   moore.sv
// Created:     2/1/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Moore Model State Diagram


module moore
(
	input wire clk,
	input wire n_rst,
	input wire i,
	output reg o

);

	typedef enum bit [2:0] {B,C,D,E,A} stateType;

	stateType state;
	stateType nxtstate;


	always_ff @ (negedge n_rst, posedge clk)
	begin : REG_L
		if(1'b0 == n_rst)
			state <= A;
		else
			state <= nxtstate;

	end

	always_comb
	begin : NXT_ST_LOGIC

		nxtstate = state;

		case(state)

		A:
			begin
				if(1'b1 == i) nxtstate = B;
			end
		B:
			begin
				if(1'b1 == i) nxtstate = C;
				else if(1'b0 == i) nxtstate = A;
			end
		C:
			begin
				if(1'b0 == i) nxtstate = D;
			end
		D:
			begin
				if(1'b0 == i) nxtstate = A;
				else if(1'b1 == i) nxtstate = E;
			end
		E:
			begin
				if(1'b1 == i) nxtstate = C;
				else if(1'b0 == i) nxtstate = A;
			end
		

		endcase

	end


	always_comb
	begin : Output_Logic

		o = 1'b0;

		case(state)

		E:
			begin
				o = 1'b1;
			end
		

		endcase

	end

	

	



endmodule
