/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar 31 19:43:49 2018
/////////////////////////////////////////////////////////////


module eop_detect ( d_plus, d_minus, eop );
  input d_plus, d_minus;
  output eop;


  NOR2X1 U2 ( .A(d_plus), .B(d_minus), .Y(eop) );
endmodule

