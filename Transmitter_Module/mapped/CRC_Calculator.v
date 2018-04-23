/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sun Apr 22 23:47:36 2018
/////////////////////////////////////////////////////////////


module flex_pio_si_11 ( clk, n_rst, shift_enable, s_reset, serial_in, 
        load_enable, parallel_in, parallel_out, serial_out );
  input [16:0] parallel_in;
  output [16:0] parallel_out;
  input clk, n_rst, shift_enable, s_reset, serial_in, load_enable;
  output serial_out;
  wire   n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57;
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
  AND2X2 U20 ( .A(n54), .B(n53), .Y(n21) );
  INVX2 U21 ( .A(n53), .Y(n22) );
  INVX2 U22 ( .A(load_enable), .Y(n18) );
  OAI21X1 U23 ( .A(n18), .B(n19), .C(n20), .Y(n74) );
  AOI22X1 U24 ( .A(parallel_out[0]), .B(n21), .C(serial_in), .D(n22), .Y(n20)
         );
  INVX1 U25 ( .A(parallel_in[0]), .Y(n19) );
  OAI21X1 U26 ( .A(n18), .B(n23), .C(n24), .Y(n73) );
  AOI22X1 U27 ( .A(parallel_out[1]), .B(n21), .C(n22), .D(parallel_out[0]), 
        .Y(n24) );
  INVX1 U28 ( .A(parallel_in[1]), .Y(n23) );
  OAI21X1 U29 ( .A(n18), .B(n25), .C(n26), .Y(n72) );
  AOI22X1 U30 ( .A(parallel_out[2]), .B(n21), .C(parallel_out[1]), .D(n22), 
        .Y(n26) );
  INVX1 U31 ( .A(parallel_in[2]), .Y(n25) );
  OAI21X1 U32 ( .A(n18), .B(n27), .C(n28), .Y(n71) );
  AOI22X1 U33 ( .A(parallel_out[3]), .B(n21), .C(parallel_out[2]), .D(n22), 
        .Y(n28) );
  INVX1 U34 ( .A(parallel_in[3]), .Y(n27) );
  OAI21X1 U35 ( .A(n18), .B(n29), .C(n30), .Y(n70) );
  AOI22X1 U36 ( .A(parallel_out[4]), .B(n21), .C(parallel_out[3]), .D(n22), 
        .Y(n30) );
  INVX1 U37 ( .A(parallel_in[4]), .Y(n29) );
  OAI21X1 U38 ( .A(n18), .B(n31), .C(n32), .Y(n69) );
  AOI22X1 U39 ( .A(parallel_out[5]), .B(n21), .C(parallel_out[4]), .D(n22), 
        .Y(n32) );
  INVX1 U40 ( .A(parallel_in[5]), .Y(n31) );
  OAI21X1 U41 ( .A(n18), .B(n33), .C(n34), .Y(n68) );
  AOI22X1 U42 ( .A(parallel_out[6]), .B(n21), .C(parallel_out[5]), .D(n22), 
        .Y(n34) );
  INVX1 U43 ( .A(parallel_in[6]), .Y(n33) );
  OAI21X1 U44 ( .A(n18), .B(n35), .C(n36), .Y(n67) );
  AOI22X1 U45 ( .A(parallel_out[7]), .B(n21), .C(parallel_out[6]), .D(n22), 
        .Y(n36) );
  INVX1 U46 ( .A(parallel_in[7]), .Y(n35) );
  OAI21X1 U47 ( .A(n18), .B(n37), .C(n38), .Y(n66) );
  AOI22X1 U48 ( .A(parallel_out[8]), .B(n21), .C(parallel_out[7]), .D(n22), 
        .Y(n38) );
  INVX1 U49 ( .A(parallel_in[8]), .Y(n37) );
  OAI21X1 U50 ( .A(n18), .B(n39), .C(n40), .Y(n65) );
  AOI22X1 U51 ( .A(parallel_out[9]), .B(n21), .C(parallel_out[8]), .D(n22), 
        .Y(n40) );
  INVX1 U52 ( .A(parallel_in[9]), .Y(n39) );
  OAI21X1 U53 ( .A(n18), .B(n41), .C(n42), .Y(n64) );
  AOI22X1 U54 ( .A(parallel_out[10]), .B(n21), .C(parallel_out[9]), .D(n22), 
        .Y(n42) );
  INVX1 U55 ( .A(parallel_in[10]), .Y(n41) );
  OAI21X1 U56 ( .A(n18), .B(n43), .C(n44), .Y(n63) );
  AOI22X1 U57 ( .A(parallel_out[11]), .B(n21), .C(parallel_out[10]), .D(n22), 
        .Y(n44) );
  INVX1 U58 ( .A(parallel_in[11]), .Y(n43) );
  OAI21X1 U59 ( .A(n18), .B(n45), .C(n46), .Y(n62) );
  AOI22X1 U60 ( .A(parallel_out[12]), .B(n21), .C(parallel_out[11]), .D(n22), 
        .Y(n46) );
  INVX1 U61 ( .A(parallel_in[12]), .Y(n45) );
  OAI21X1 U62 ( .A(n18), .B(n47), .C(n48), .Y(n61) );
  AOI22X1 U63 ( .A(parallel_out[13]), .B(n21), .C(parallel_out[12]), .D(n22), 
        .Y(n48) );
  INVX1 U64 ( .A(parallel_in[13]), .Y(n47) );
  OAI21X1 U65 ( .A(n18), .B(n49), .C(n50), .Y(n60) );
  AOI22X1 U66 ( .A(parallel_out[14]), .B(n21), .C(parallel_out[13]), .D(n22), 
        .Y(n50) );
  INVX1 U67 ( .A(parallel_in[14]), .Y(n49) );
  OAI21X1 U68 ( .A(n18), .B(n51), .C(n52), .Y(n59) );
  AOI22X1 U69 ( .A(parallel_out[15]), .B(n21), .C(parallel_out[14]), .D(n22), 
        .Y(n52) );
  NOR2X1 U70 ( .A(s_reset), .B(load_enable), .Y(n54) );
  INVX1 U71 ( .A(parallel_in[15]), .Y(n51) );
  OAI21X1 U72 ( .A(n18), .B(n55), .C(n56), .Y(n58) );
  MUX2X1 U73 ( .B(parallel_out[15]), .A(n57), .S(n53), .Y(n56) );
  NAND2X1 U74 ( .A(shift_enable), .B(n18), .Y(n53) );
  AND2X1 U75 ( .A(parallel_out[16]), .B(n18), .Y(n57) );
  INVX1 U76 ( .A(parallel_in[16]), .Y(n55) );
endmodule


module CRC_Calculator ( clk, n_rst, bit_in, new_bit, reset, CRC_Calc, CRC_Send, 
        serial_out, CRC_Bytes );
  output [15:0] CRC_Bytes;
  input clk, n_rst, bit_in, new_bit, reset, CRC_Calc;
  output CRC_Send, serial_out;
  wire   \Parallel_out[16] , Serial_In, Shift_Enable, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114,
         n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n143, n145;
  wire   [2:0] state;
  wire   [4:0] count;

  DFFSR \state_reg[0]  ( .D(n79), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n76), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[2]  ( .D(n77), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \count_reg[4]  ( .D(n78), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[4])
         );
  DFFSR \count_reg[0]  ( .D(n75), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[0])
         );
  DFFSR \count_reg[1]  ( .D(n74), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[1])
         );
  DFFSR \count_reg[2]  ( .D(n73), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[2])
         );
  DFFSR \count_reg[3]  ( .D(n72), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[3])
         );
  flex_pio_si_11 CRC_Register ( .clk(clk), .n_rst(n_rst), .shift_enable(
        Shift_Enable), .s_reset(reset), .serial_in(Serial_In), .load_enable(
        n145), .parallel_in({n143, n142, CRC_Bytes[14:3], n141, CRC_Bytes[1], 
        n140}), .parallel_out({\Parallel_out[16] , CRC_Bytes}), .serial_out(
        serial_out) );
  INVX1 U84 ( .A(CRC_Bytes[0]), .Y(n140) );
  INVX1 U85 ( .A(CRC_Bytes[2]), .Y(n141) );
  INVX1 U86 ( .A(CRC_Bytes[15]), .Y(n142) );
  OAI21X1 U87 ( .A(n80), .B(n81), .C(n82), .Y(n79) );
  AOI21X1 U88 ( .A(n83), .B(n84), .C(n85), .Y(n82) );
  OAI22X1 U89 ( .A(CRC_Calc), .B(n86), .C(n87), .D(n88), .Y(n84) );
  MUX2X1 U90 ( .B(n89), .A(n90), .S(count[4]), .Y(n78) );
  AOI21X1 U91 ( .A(n91), .B(n92), .C(n93), .Y(n90) );
  NAND3X1 U92 ( .A(n94), .B(n91), .C(count[3]), .Y(n89) );
  OAI22X1 U93 ( .A(n80), .B(n95), .C(n96), .D(n97), .Y(n77) );
  AOI22X1 U94 ( .A(CRC_Calc), .B(n98), .C(n99), .D(n143), .Y(n96) );
  INVX1 U95 ( .A(serial_out), .Y(n143) );
  OAI21X1 U96 ( .A(serial_out), .B(n100), .C(n101), .Y(n98) );
  NOR2X1 U97 ( .A(n145), .B(n102), .Y(n101) );
  OAI21X1 U98 ( .A(n80), .B(n103), .C(n104), .Y(n76) );
  AOI21X1 U99 ( .A(n83), .B(n105), .C(n85), .Y(n104) );
  NOR2X1 U100 ( .A(n97), .B(n106), .Y(n85) );
  OAI21X1 U101 ( .A(n107), .B(n99), .C(serial_out), .Y(n106) );
  INVX1 U102 ( .A(n108), .Y(n99) );
  OAI22X1 U103 ( .A(CRC_Calc), .B(n109), .C(n88), .D(n110), .Y(n105) );
  INVX1 U104 ( .A(n87), .Y(n110) );
  NOR2X1 U105 ( .A(n111), .B(n112), .Y(n87) );
  NAND3X1 U106 ( .A(state[2]), .B(n113), .C(count[4]), .Y(n112) );
  INVX1 U107 ( .A(count[0]), .Y(n113) );
  NAND3X1 U108 ( .A(n114), .B(n92), .C(n115), .Y(n111) );
  INVX1 U109 ( .A(count[3]), .Y(n92) );
  INVX1 U110 ( .A(count[2]), .Y(n114) );
  INVX1 U111 ( .A(n97), .Y(n83) );
  NAND2X1 U112 ( .A(n116), .B(n117), .Y(n97) );
  INVX1 U113 ( .A(n118), .Y(n80) );
  OAI21X1 U114 ( .A(n119), .B(n120), .C(n117), .Y(n118) );
  OAI21X1 U115 ( .A(CRC_Send), .B(n121), .C(n122), .Y(n117) );
  AOI21X1 U116 ( .A(n123), .B(n124), .C(reset), .Y(n122) );
  NOR2X1 U117 ( .A(CRC_Calc), .B(n102), .Y(n123) );
  INVX1 U118 ( .A(n86), .Y(n102) );
  AOI21X1 U119 ( .A(CRC_Calc), .B(n124), .C(bit_in), .Y(n121) );
  OR2X1 U120 ( .A(n88), .B(state[2]), .Y(n124) );
  INVX1 U121 ( .A(n125), .Y(CRC_Send) );
  NAND2X1 U122 ( .A(n126), .B(n109), .Y(n120) );
  NOR2X1 U123 ( .A(n107), .B(n145), .Y(n109) );
  INVX1 U124 ( .A(n127), .Y(n145) );
  NAND3X1 U125 ( .A(state[1]), .B(n95), .C(state[0]), .Y(n127) );
  INVX1 U126 ( .A(n100), .Y(n107) );
  NAND3X1 U127 ( .A(n103), .B(n95), .C(state[0]), .Y(n100) );
  INVX1 U128 ( .A(n128), .Y(n126) );
  NAND2X1 U129 ( .A(n125), .B(n116), .Y(n119) );
  INVX1 U130 ( .A(reset), .Y(n116) );
  NAND3X1 U131 ( .A(state[1]), .B(n81), .C(state[2]), .Y(n125) );
  MUX2X1 U132 ( .B(n129), .A(n128), .S(count[0]), .Y(n75) );
  MUX2X1 U133 ( .B(n130), .A(n131), .S(count[1]), .Y(n74) );
  INVX1 U134 ( .A(n132), .Y(n131) );
  NAND2X1 U135 ( .A(n91), .B(count[0]), .Y(n130) );
  MUX2X1 U136 ( .B(n133), .A(n134), .S(count[2]), .Y(n73) );
  AOI21X1 U137 ( .A(n91), .B(n115), .C(n132), .Y(n134) );
  OAI21X1 U138 ( .A(count[0]), .B(n129), .C(n128), .Y(n132) );
  INVX1 U139 ( .A(count[1]), .Y(n115) );
  NAND3X1 U140 ( .A(count[1]), .B(count[0]), .C(n91), .Y(n133) );
  MUX2X1 U141 ( .B(n135), .A(n136), .S(count[3]), .Y(n72) );
  INVX1 U142 ( .A(n93), .Y(n136) );
  OAI21X1 U143 ( .A(n94), .B(n129), .C(n128), .Y(n93) );
  NAND2X1 U144 ( .A(n94), .B(n91), .Y(n135) );
  INVX1 U145 ( .A(n129), .Y(n91) );
  NAND2X1 U146 ( .A(n86), .B(n128), .Y(n129) );
  NAND2X1 U147 ( .A(n86), .B(n108), .Y(n128) );
  NAND3X1 U148 ( .A(state[2]), .B(n103), .C(state[0]), .Y(n108) );
  NAND3X1 U149 ( .A(n81), .B(n95), .C(state[1]), .Y(n86) );
  INVX1 U150 ( .A(n137), .Y(n94) );
  NAND3X1 U151 ( .A(count[1]), .B(count[0]), .C(count[2]), .Y(n137) );
  OAI21X1 U152 ( .A(n95), .B(n88), .C(n138), .Y(Shift_Enable) );
  NAND2X1 U153 ( .A(new_bit), .B(n139), .Y(n138) );
  NAND2X1 U154 ( .A(n81), .B(n103), .Y(n88) );
  INVX1 U155 ( .A(state[1]), .Y(n103) );
  INVX1 U156 ( .A(state[0]), .Y(n81) );
  INVX1 U157 ( .A(state[2]), .Y(n95) );
  AND2X1 U158 ( .A(n139), .B(bit_in), .Y(Serial_In) );
  INVX1 U159 ( .A(CRC_Calc), .Y(n139) );
endmodule

