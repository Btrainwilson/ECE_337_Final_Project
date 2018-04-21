// $Id: $
// File name:   tb_eop_detect.sv
// Created:     2/19/2018
// Author:      Jackson Barrett
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: test bench for eop_detect module
`timescale 1ns / 10ps

module tb_flex_stp_sr ();

wire tb_d_plus;
wire dt_d_minus;
wire tb_eop;


eop_detect DUT(.d_plus(tb_d_plus), .d_minus(tb_d_minus), .eop(tb_eop));

integer tb_test_case;
reg tb_expected_eop;
reg [1:0] tb_test_inputs;

assign tb_d_plus = tb_test_inputs[0];
assign tb_d_minus = tb_test_inputs[1];


initial
begin

	for(tb_test_case = 0; tb_test_case <= 3; tb_test_case = tb_test_case + 1)
	begin
		tb_test_inputs = tb_test_case[1:0];

		#1;
		
		tb_expected_eop = ~(tb_d_plus | tb_d_minus);
		
		#9;
		
		if(tb_expected_eop == tb_eop) begin
			$info("Correct eop value for test case %d", tb_test_case);
		end
		else begin
			$error("Incorrect eop value for test case %d", tb_test_case);
		end
	end
end

final
begin
	if(tb_test_case != 4) begin
		$display("test bench not run to completion");
	end
	else begin
		$display("test bench fully run to completion");
	end
end
endmodule

