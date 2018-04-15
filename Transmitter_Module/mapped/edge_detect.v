/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar 31 19:49:18 2018
/////////////////////////////////////////////////////////////


module edge_detect ( clk, n_rst, d_plus, d_edge );
  input clk, n_rst, d_plus;
  output d_edge;
  wire   d_plus_sync, d_plus_sync_prev;

  DFFSR d_plus_sync_reg ( .D(d_plus), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        d_plus_sync) );
  DFFSR d_plus_sync_prev_reg ( .D(d_plus_sync), .CLK(clk), .R(1'b1), .S(n_rst), 
        .Q(d_plus_sync_prev) );
  XOR2X1 U6 ( .A(d_plus_sync_prev), .B(d_plus_sync), .Y(d_edge) );
endmodule

