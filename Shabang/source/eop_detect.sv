// $Id: $
// File name:   eop_detect.sv
// Created:     2/18/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 6: eop detector


module eop_detect
	(
	input wire d_plus,
	input wire d_minus,
	output wire eop
	);

	assign eop = (~d_plus) & (~d_minus);

endmodule
