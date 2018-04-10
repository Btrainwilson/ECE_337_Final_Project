/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar 31 19:53:07 2018
/////////////////////////////////////////////////////////////


module decode ( clk, n_rst, d_plus, shift_enable, eop, d_orig );
  input clk, n_rst, d_plus, shift_enable, eop;
  output d_orig;
  wire   d_plus_sync, internal, next_d_orig, n7, n8, n9, n10, n11;

  DFFSR d_plus_sync_reg ( .D(d_plus), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        d_plus_sync) );
  DFFSR internal_reg ( .D(n7), .CLK(clk), .R(1'b1), .S(n_rst), .Q(internal) );
  DFFSR d_orig_reg ( .D(next_d_orig), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        d_orig) );
  NOR2X1 U11 ( .A(n8), .B(n9), .Y(next_d_orig) );
  XOR2X1 U12 ( .A(internal), .B(d_plus_sync), .Y(n9) );
  INVX1 U13 ( .A(n10), .Y(n8) );
  NAND2X1 U14 ( .A(n11), .B(n10), .Y(n7) );
  NAND2X1 U15 ( .A(shift_enable), .B(eop), .Y(n10) );
  MUX2X1 U16 ( .B(internal), .A(d_plus_sync), .S(shift_enable), .Y(n11) );
endmodule

