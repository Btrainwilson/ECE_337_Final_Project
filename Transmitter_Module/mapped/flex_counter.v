/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar 31 20:05:27 2018
/////////////////////////////////////////////////////////////


module flex_counter ( clk, n_rst, clear, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_flag, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88;
  wire   [3:0] next_count;

  DFFSR \count_out_reg[0]  ( .D(next_count[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(next_count[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(next_count[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(next_count[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[3]) );
  DFFSR rollover_flag_reg ( .D(next_flag), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  OAI21X1 U52 ( .A(n53), .B(n54), .C(n55), .Y(next_flag) );
  NAND3X1 U53 ( .A(n56), .B(n57), .C(n58), .Y(n55) );
  NOR2X1 U54 ( .A(n59), .B(n60), .Y(n58) );
  OAI22X1 U55 ( .A(rollover_val[1]), .B(n61), .C(rollover_val[0]), .D(n62), 
        .Y(n60) );
  OAI21X1 U56 ( .A(next_count[2]), .B(n63), .C(count_enable), .Y(n54) );
  OAI21X1 U57 ( .A(next_count[1]), .B(n64), .C(n65), .Y(n53) );
  INVX1 U58 ( .A(n66), .Y(n65) );
  OAI22X1 U59 ( .A(n67), .B(next_count[3]), .C(n68), .D(next_count[0]), .Y(n66) );
  INVX1 U60 ( .A(rollover_val[0]), .Y(n68) );
  OAI22X1 U61 ( .A(n69), .B(n70), .C(n71), .D(n72), .Y(next_count[3]) );
  AOI22X1 U62 ( .A(count_out[3]), .B(n73), .C(n74), .D(n75), .Y(n71) );
  OAI22X1 U63 ( .A(n76), .B(n70), .C(n77), .D(n72), .Y(next_count[2]) );
  XNOR2X1 U64 ( .A(n74), .B(n75), .Y(n77) );
  NOR2X1 U65 ( .A(n76), .B(n56), .Y(n75) );
  AND2X1 U66 ( .A(n78), .B(count_out[1]), .Y(n74) );
  OAI22X1 U67 ( .A(n61), .B(n70), .C(n79), .D(n72), .Y(next_count[1]) );
  XOR2X1 U68 ( .A(n80), .B(n78), .Y(n79) );
  NAND2X1 U69 ( .A(count_out[1]), .B(n73), .Y(n80) );
  OAI22X1 U70 ( .A(n62), .B(n70), .C(n78), .D(n72), .Y(next_count[0]) );
  NAND2X1 U71 ( .A(count_enable), .B(n81), .Y(n72) );
  INVX1 U72 ( .A(clear), .Y(n81) );
  NOR2X1 U73 ( .A(n62), .B(n56), .Y(n78) );
  INVX1 U74 ( .A(n73), .Y(n56) );
  OAI21X1 U75 ( .A(count_out[3]), .B(n67), .C(n82), .Y(n73) );
  NAND2X1 U76 ( .A(n83), .B(n84), .Y(n82) );
  OAI21X1 U77 ( .A(count_out[2]), .B(n63), .C(n85), .Y(n84) );
  OAI21X1 U78 ( .A(n86), .B(n61), .C(n87), .Y(n85) );
  OAI21X1 U79 ( .A(count_out[1]), .B(n88), .C(n64), .Y(n87) );
  INVX1 U80 ( .A(rollover_val[1]), .Y(n64) );
  INVX1 U81 ( .A(count_out[1]), .Y(n61) );
  INVX1 U82 ( .A(n88), .Y(n86) );
  NAND2X1 U83 ( .A(rollover_val[0]), .B(n62), .Y(n88) );
  INVX1 U84 ( .A(rollover_val[2]), .Y(n63) );
  INVX1 U85 ( .A(n59), .Y(n83) );
  OAI22X1 U86 ( .A(rollover_val[3]), .B(n69), .C(rollover_val[2]), .D(n76), 
        .Y(n59) );
  INVX1 U87 ( .A(count_out[2]), .Y(n76) );
  INVX1 U88 ( .A(count_out[3]), .Y(n69) );
  INVX1 U89 ( .A(rollover_val[3]), .Y(n67) );
  INVX1 U90 ( .A(n57), .Y(n70) );
  NOR2X1 U91 ( .A(count_enable), .B(clear), .Y(n57) );
  INVX1 U92 ( .A(count_out[0]), .Y(n62) );
endmodule

