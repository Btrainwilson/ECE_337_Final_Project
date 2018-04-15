/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar 31 19:45:10 2018
/////////////////////////////////////////////////////////////


module rcu ( clk, n_rst, d_edge, eop, shift_enable, rcv_data, byte_received, 
        rcving, w_enable, r_error );
  input [7:0] rcv_data;
  input clk, n_rst, d_edge, eop, shift_enable, byte_received;
  output rcving, w_enable, r_error;
  wire   n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130;
  wire   [3:0] state;
  wire   [3:0] nextstate;

  DFFSR \state_reg[0]  ( .D(nextstate[0]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[0]) );
  DFFSR \state_reg[3]  ( .D(nextstate[3]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[3]) );
  DFFSR \state_reg[1]  ( .D(nextstate[1]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[1]) );
  DFFSR \state_reg[2]  ( .D(nextstate[2]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[2]) );
  INVX1 U77 ( .A(n69), .Y(w_enable) );
  OAI21X1 U78 ( .A(state[3]), .B(n70), .C(n71), .Y(rcving) );
  AOI21X1 U79 ( .A(n72), .B(n73), .C(n74), .Y(n71) );
  NAND3X1 U80 ( .A(n75), .B(n76), .C(n77), .Y(r_error) );
  OR2X1 U81 ( .A(n78), .B(n79), .Y(nextstate[3]) );
  OAI21X1 U82 ( .A(n80), .B(n81), .C(n82), .Y(n79) );
  OAI21X1 U83 ( .A(eop), .B(n83), .C(n84), .Y(n82) );
  NAND3X1 U84 ( .A(n69), .B(n85), .C(n86), .Y(n78) );
  OR2X1 U85 ( .A(n87), .B(n88), .Y(nextstate[2]) );
  OAI21X1 U86 ( .A(d_edge), .B(n89), .C(n90), .Y(n88) );
  INVX1 U87 ( .A(n91), .Y(n90) );
  OAI22X1 U88 ( .A(n77), .B(n92), .C(n80), .D(byte_received), .Y(n91) );
  OAI21X1 U89 ( .A(n93), .B(n94), .C(n95), .Y(n87) );
  NOR2X1 U90 ( .A(n74), .B(n96), .Y(n95) );
  INVX1 U91 ( .A(n76), .Y(n74) );
  NAND3X1 U92 ( .A(rcv_data[7]), .B(n97), .C(n98), .Y(n94) );
  NOR2X1 U93 ( .A(rcv_data[1]), .B(rcv_data[0]), .Y(n98) );
  INVX1 U94 ( .A(n99), .Y(n97) );
  NAND3X1 U95 ( .A(n100), .B(n101), .C(n102), .Y(n93) );
  NOR2X1 U96 ( .A(rcv_data[3]), .B(rcv_data[2]), .Y(n102) );
  INVX1 U97 ( .A(rcv_data[4]), .Y(n101) );
  NOR2X1 U98 ( .A(rcv_data[6]), .B(rcv_data[5]), .Y(n100) );
  OR2X1 U99 ( .A(n103), .B(n104), .Y(nextstate[1]) );
  OAI21X1 U100 ( .A(d_edge), .B(n89), .C(n105), .Y(n104) );
  INVX1 U101 ( .A(n106), .Y(n105) );
  INVX1 U102 ( .A(n107), .Y(n89) );
  OAI21X1 U103 ( .A(n108), .B(n92), .C(n109), .Y(n103) );
  AOI21X1 U104 ( .A(n110), .B(n111), .C(n112), .Y(n109) );
  INVX1 U105 ( .A(n86), .Y(n112) );
  MUX2X1 U106 ( .B(n81), .A(n83), .S(state[2]), .Y(n111) );
  NOR2X1 U107 ( .A(n72), .B(n70), .Y(n110) );
  NAND3X1 U108 ( .A(n113), .B(n114), .C(n115), .Y(nextstate[0]) );
  AOI21X1 U109 ( .A(n116), .B(n73), .C(n117), .Y(n115) );
  OAI21X1 U110 ( .A(n76), .B(n118), .C(n69), .Y(n117) );
  NAND3X1 U111 ( .A(n70), .B(n119), .C(n120), .Y(n69) );
  NAND2X1 U112 ( .A(state[0]), .B(n83), .Y(n118) );
  MUX2X1 U113 ( .B(n121), .A(n122), .S(state[0]), .Y(n116) );
  NAND2X1 U114 ( .A(n123), .B(n81), .Y(n122) );
  INVX1 U115 ( .A(byte_received), .Y(n81) );
  NAND2X1 U116 ( .A(d_edge), .B(n119), .Y(n121) );
  MUX2X1 U117 ( .B(n124), .A(n84), .S(n92), .Y(n114) );
  INVX1 U118 ( .A(n108), .Y(n84) );
  OAI21X1 U119 ( .A(state[0]), .B(n76), .C(n86), .Y(n124) );
  NAND3X1 U120 ( .A(n120), .B(n70), .C(state[1]), .Y(n86) );
  NAND2X1 U121 ( .A(state[2]), .B(n123), .Y(n76) );
  INVX1 U122 ( .A(n72), .Y(n123) );
  NAND2X1 U123 ( .A(n119), .B(n125), .Y(n72) );
  AOI21X1 U124 ( .A(d_edge), .B(n107), .C(n106), .Y(n113) );
  NAND3X1 U125 ( .A(n85), .B(n99), .C(n126), .Y(n106) );
  AOI21X1 U126 ( .A(n127), .B(n92), .C(n96), .Y(n126) );
  NOR3X1 U127 ( .A(n83), .B(eop), .C(n108), .Y(n96) );
  NAND3X1 U128 ( .A(n120), .B(n119), .C(state[0]), .Y(n108) );
  NAND2X1 U129 ( .A(eop), .B(shift_enable), .Y(n92) );
  OAI21X1 U130 ( .A(byte_received), .B(n80), .C(n77), .Y(n127) );
  OR2X1 U131 ( .A(n128), .B(state[2]), .Y(n77) );
  OR2X1 U132 ( .A(n128), .B(n73), .Y(n80) );
  NAND3X1 U133 ( .A(state[0]), .B(n125), .C(state[1]), .Y(n128) );
  NAND3X1 U134 ( .A(n73), .B(n125), .C(n129), .Y(n99) );
  NOR2X1 U135 ( .A(state[0]), .B(n119), .Y(n129) );
  INVX1 U136 ( .A(state[2]), .Y(n73) );
  NAND3X1 U137 ( .A(n120), .B(n83), .C(n130), .Y(n85) );
  NOR2X1 U138 ( .A(n70), .B(n119), .Y(n130) );
  INVX1 U139 ( .A(shift_enable), .Y(n83) );
  NOR2X1 U140 ( .A(n125), .B(state[2]), .Y(n120) );
  NOR2X1 U141 ( .A(n75), .B(n119), .Y(n107) );
  INVX1 U142 ( .A(state[1]), .Y(n119) );
  NAND3X1 U143 ( .A(n70), .B(n125), .C(state[2]), .Y(n75) );
  INVX1 U144 ( .A(state[3]), .Y(n125) );
  INVX1 U145 ( .A(state[0]), .Y(n70) );
endmodule

