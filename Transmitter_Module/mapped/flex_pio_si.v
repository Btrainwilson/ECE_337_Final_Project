/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sun Apr 22 23:14:35 2018
/////////////////////////////////////////////////////////////


module flex_pio_si ( clk, n_rst, shift_enable, s_reset, serial_in, load_enable, 
        parallel_in, parallel_out, serial_out );
  input [16:0] parallel_in;
  output [16:0] parallel_out;
  input clk, n_rst, shift_enable, s_reset, serial_in, load_enable;
  output serial_out;
  wire   n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114;
  assign serial_out = parallel_out[16];

  DFFSR \tmp_reg_reg[0]  ( .D(n74), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[0]) );
  DFFSR \tmp_reg_reg[1]  ( .D(n73), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[1]) );
  DFFSR \tmp_reg_reg[2]  ( .D(n72), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[2]) );
  DFFSR \tmp_reg_reg[3]  ( .D(n71), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[3]) );
  DFFSR \tmp_reg_reg[4]  ( .D(n70), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[4]) );
  DFFSR \tmp_reg_reg[5]  ( .D(n69), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[5]) );
  DFFSR \tmp_reg_reg[6]  ( .D(n68), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[6]) );
  DFFSR \tmp_reg_reg[7]  ( .D(n67), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[7]) );
  DFFSR \tmp_reg_reg[8]  ( .D(n66), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[8]) );
  DFFSR \tmp_reg_reg[9]  ( .D(n65), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[9]) );
  DFFSR \tmp_reg_reg[10]  ( .D(n64), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[10]) );
  DFFSR \tmp_reg_reg[11]  ( .D(n63), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[11]) );
  DFFSR \tmp_reg_reg[12]  ( .D(n62), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[12]) );
  DFFSR \tmp_reg_reg[13]  ( .D(n61), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[13]) );
  DFFSR \tmp_reg_reg[14]  ( .D(n60), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[14]) );
  DFFSR \tmp_reg_reg[15]  ( .D(n59), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[15]) );
  DFFSR serial_out_reg ( .D(n58), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        parallel_out[16]) );
  AND2X2 U77 ( .A(n111), .B(n110), .Y(n78) );
  INVX2 U78 ( .A(n110), .Y(n79) );
  INVX2 U79 ( .A(load_enable), .Y(n75) );
  OAI21X1 U80 ( .A(n75), .B(n76), .C(n77), .Y(n74) );
  AOI22X1 U81 ( .A(parallel_out[0]), .B(n78), .C(serial_in), .D(n79), .Y(n77)
         );
  INVX1 U82 ( .A(parallel_in[0]), .Y(n76) );
  OAI21X1 U83 ( .A(n75), .B(n80), .C(n81), .Y(n73) );
  AOI22X1 U84 ( .A(parallel_out[1]), .B(n78), .C(n79), .D(parallel_out[0]), 
        .Y(n81) );
  INVX1 U85 ( .A(parallel_in[1]), .Y(n80) );
  OAI21X1 U86 ( .A(n75), .B(n82), .C(n83), .Y(n72) );
  AOI22X1 U87 ( .A(parallel_out[2]), .B(n78), .C(parallel_out[1]), .D(n79), 
        .Y(n83) );
  INVX1 U88 ( .A(parallel_in[2]), .Y(n82) );
  OAI21X1 U89 ( .A(n75), .B(n84), .C(n85), .Y(n71) );
  AOI22X1 U90 ( .A(parallel_out[3]), .B(n78), .C(parallel_out[2]), .D(n79), 
        .Y(n85) );
  INVX1 U91 ( .A(parallel_in[3]), .Y(n84) );
  OAI21X1 U92 ( .A(n75), .B(n86), .C(n87), .Y(n70) );
  AOI22X1 U93 ( .A(parallel_out[4]), .B(n78), .C(parallel_out[3]), .D(n79), 
        .Y(n87) );
  INVX1 U94 ( .A(parallel_in[4]), .Y(n86) );
  OAI21X1 U95 ( .A(n75), .B(n88), .C(n89), .Y(n69) );
  AOI22X1 U96 ( .A(parallel_out[5]), .B(n78), .C(parallel_out[4]), .D(n79), 
        .Y(n89) );
  INVX1 U97 ( .A(parallel_in[5]), .Y(n88) );
  OAI21X1 U98 ( .A(n75), .B(n90), .C(n91), .Y(n68) );
  AOI22X1 U99 ( .A(parallel_out[6]), .B(n78), .C(parallel_out[5]), .D(n79), 
        .Y(n91) );
  INVX1 U100 ( .A(parallel_in[6]), .Y(n90) );
  OAI21X1 U101 ( .A(n75), .B(n92), .C(n93), .Y(n67) );
  AOI22X1 U102 ( .A(parallel_out[7]), .B(n78), .C(parallel_out[6]), .D(n79), 
        .Y(n93) );
  INVX1 U103 ( .A(parallel_in[7]), .Y(n92) );
  OAI21X1 U104 ( .A(n75), .B(n94), .C(n95), .Y(n66) );
  AOI22X1 U105 ( .A(parallel_out[8]), .B(n78), .C(parallel_out[7]), .D(n79), 
        .Y(n95) );
  INVX1 U106 ( .A(parallel_in[8]), .Y(n94) );
  OAI21X1 U107 ( .A(n75), .B(n96), .C(n97), .Y(n65) );
  AOI22X1 U108 ( .A(parallel_out[9]), .B(n78), .C(parallel_out[8]), .D(n79), 
        .Y(n97) );
  INVX1 U109 ( .A(parallel_in[9]), .Y(n96) );
  OAI21X1 U110 ( .A(n75), .B(n98), .C(n99), .Y(n64) );
  AOI22X1 U111 ( .A(parallel_out[10]), .B(n78), .C(parallel_out[9]), .D(n79), 
        .Y(n99) );
  INVX1 U112 ( .A(parallel_in[10]), .Y(n98) );
  OAI21X1 U113 ( .A(n75), .B(n100), .C(n101), .Y(n63) );
  AOI22X1 U114 ( .A(parallel_out[11]), .B(n78), .C(parallel_out[10]), .D(n79), 
        .Y(n101) );
  INVX1 U115 ( .A(parallel_in[11]), .Y(n100) );
  OAI21X1 U116 ( .A(n75), .B(n102), .C(n103), .Y(n62) );
  AOI22X1 U117 ( .A(parallel_out[12]), .B(n78), .C(parallel_out[11]), .D(n79), 
        .Y(n103) );
  INVX1 U118 ( .A(parallel_in[12]), .Y(n102) );
  OAI21X1 U119 ( .A(n75), .B(n104), .C(n105), .Y(n61) );
  AOI22X1 U120 ( .A(parallel_out[13]), .B(n78), .C(parallel_out[12]), .D(n79), 
        .Y(n105) );
  INVX1 U121 ( .A(parallel_in[13]), .Y(n104) );
  OAI21X1 U122 ( .A(n75), .B(n106), .C(n107), .Y(n60) );
  AOI22X1 U123 ( .A(parallel_out[14]), .B(n78), .C(parallel_out[13]), .D(n79), 
        .Y(n107) );
  INVX1 U124 ( .A(parallel_in[14]), .Y(n106) );
  OAI21X1 U125 ( .A(n75), .B(n108), .C(n109), .Y(n59) );
  AOI22X1 U126 ( .A(parallel_out[15]), .B(n78), .C(parallel_out[14]), .D(n79), 
        .Y(n109) );
  NOR2X1 U127 ( .A(s_reset), .B(load_enable), .Y(n111) );
  INVX1 U128 ( .A(parallel_in[15]), .Y(n108) );
  OAI21X1 U129 ( .A(n75), .B(n112), .C(n113), .Y(n58) );
  MUX2X1 U130 ( .B(parallel_out[15]), .A(n114), .S(n110), .Y(n113) );
  NAND2X1 U131 ( .A(shift_enable), .B(n75), .Y(n110) );
  AND2X1 U132 ( .A(parallel_out[16]), .B(n75), .Y(n114) );
  INVX1 U133 ( .A(parallel_in[16]), .Y(n112) );
endmodule

