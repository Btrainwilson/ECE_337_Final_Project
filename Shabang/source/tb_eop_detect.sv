// $Id: $
// File name:   tb_eop_detect.sv
// Created:     2/16/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: eop detector test bench

module tb_eop_detect
();

		// Define our custom test vector type
	typedef struct
	{
		reg t_d_minus;
		reg t_d_plus;
	} testVector;

	//Test Bench Variables
	reg tb_d_minus;
	reg tb_d_plus;
	reg tb_eop;

	// DUT portmap
	eop_detect DUT(
									.d_minus(tb_d_minus),
									.d_plus(tb_d_plus),
									.eop(tb_eop)
								);
	
	initial
	begin

	tb_d_minus = 1'b0;
	tb_d_plus = 1'b0;
	#(10ns);
	tb_d_minus = 1'b1;
	tb_d_plus = 1'b0;
	#(10ns);
	tb_d_minus = 1'b0;
	tb_d_plus = 1'b1;
	#(10ns);
	tb_d_minus = 1'b1;
	tb_d_plus = 1'b1;
	#(10ns);
	tb_d_minus = 1'b0;
	tb_d_plus = 1'b0;
	#(10ns);
	tb_d_minus = 1'b1;
	tb_d_plus = 1'b1;
	#(10ns);
	end


	


endmodule
