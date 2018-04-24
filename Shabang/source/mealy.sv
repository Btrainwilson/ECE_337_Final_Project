// $Id: $
// File name:   mealy.sv
// Created:     2/1/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Mealy Model State Diagram


module mealy
(
	input wire clk,
	input wire n_rst,
	input wire i,
	output reg o
);

	typedef enum bit [1:0] {B,C,D,A} stateType;

	stateType state;
	stateType nxtstate;
	reg flag = 1'b0;

	always_ff @ (negedge n_rst, posedge clk)
	begin : REG_L
		if(1'b0 == n_rst)begin
			state <= A;
			o <= 1'b0;
			 end
		else begin
			state <= nxtstate;
			o <= flag;
			 end
	end

	always_comb
	begin : NXT_ST_LOGIC
		flag = 1'b0;
		nxtstate = state;
		case(state)

		A:
			begin
				if(1'b1 == i)begin nxtstate = B;  end
			end
		B:
			begin
				if(1'b1 == i) begin nxtstate = C;  end
				else if(1'b0 == i) begin nxtstate = A;  end
			end
		C:
			begin
				if(1'b0 == i) begin nxtstate = D;  end
			end
		D:
			begin
				if(1'b0 == i) begin nxtstate = A;  end
				else if((1'b1 == i))begin nxtstate = B; flag = 1'b1; end
			end
		

		endcase

	end


	always_comb
	begin : Output_Logic

		/*o = 1'b0;

		case(state)

		B:
			begin
				if(prvstate == D) o = 1'b1;
			end

		endcase*/

	end

endmodule
