/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Apr 16 12:31:42 2018
/////////////////////////////////////////////////////////////


module flex_pts_sr_NUM_BITS8_SHIFT_MSB0 ( clk, n_rst, shift_enable, serial_out, 
        load_enable, parallel_in );
  input [7:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;
  wire   n29, n30, n31, n32, n33, n34, n35, n36, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27;
  wire   [7:1] tmp_reg;

  DFFSR \tmp_reg_reg[7]  ( .D(n36), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        tmp_reg[7]) );
  DFFSR \tmp_reg_reg[6]  ( .D(n35), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        tmp_reg[6]) );
  DFFSR \tmp_reg_reg[5]  ( .D(n34), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        tmp_reg[5]) );
  DFFSR \tmp_reg_reg[4]  ( .D(n33), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        tmp_reg[4]) );
  DFFSR \tmp_reg_reg[3]  ( .D(n32), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        tmp_reg[3]) );
  DFFSR \tmp_reg_reg[2]  ( .D(n31), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        tmp_reg[2]) );
  DFFSR \tmp_reg_reg[1]  ( .D(n30), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        tmp_reg[1]) );
  DFFSR serial_out_reg ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        serial_out) );
  OAI21X1 U11 ( .A(n9), .B(n10), .C(n11), .Y(n36) );
  AOI21X1 U12 ( .A(tmp_reg[7]), .B(n12), .C(n13), .Y(n11) );
  INVX1 U13 ( .A(parallel_in[7]), .Y(n10) );
  OAI21X1 U14 ( .A(n9), .B(n14), .C(n15), .Y(n35) );
  AOI22X1 U15 ( .A(tmp_reg[6]), .B(n12), .C(n13), .D(tmp_reg[7]), .Y(n15) );
  INVX1 U16 ( .A(parallel_in[6]), .Y(n14) );
  OAI21X1 U17 ( .A(n9), .B(n16), .C(n17), .Y(n34) );
  AOI22X1 U18 ( .A(tmp_reg[5]), .B(n12), .C(n13), .D(tmp_reg[6]), .Y(n17) );
  INVX1 U19 ( .A(parallel_in[5]), .Y(n16) );
  OAI21X1 U20 ( .A(n9), .B(n18), .C(n19), .Y(n33) );
  AOI22X1 U21 ( .A(tmp_reg[4]), .B(n12), .C(tmp_reg[5]), .D(n13), .Y(n19) );
  INVX1 U22 ( .A(parallel_in[4]), .Y(n18) );
  OAI21X1 U23 ( .A(n9), .B(n20), .C(n21), .Y(n32) );
  AOI22X1 U24 ( .A(tmp_reg[3]), .B(n12), .C(tmp_reg[4]), .D(n13), .Y(n21) );
  INVX1 U25 ( .A(parallel_in[3]), .Y(n20) );
  OAI21X1 U26 ( .A(n9), .B(n22), .C(n23), .Y(n31) );
  AOI22X1 U27 ( .A(tmp_reg[2]), .B(n12), .C(tmp_reg[3]), .D(n13), .Y(n23) );
  INVX1 U28 ( .A(parallel_in[2]), .Y(n22) );
  OAI21X1 U29 ( .A(n9), .B(n24), .C(n25), .Y(n30) );
  AOI22X1 U30 ( .A(tmp_reg[1]), .B(n12), .C(tmp_reg[2]), .D(n13), .Y(n25) );
  INVX1 U31 ( .A(parallel_in[1]), .Y(n24) );
  OAI21X1 U32 ( .A(n9), .B(n26), .C(n27), .Y(n29) );
  AOI22X1 U33 ( .A(serial_out), .B(n12), .C(tmp_reg[1]), .D(n13), .Y(n27) );
  NOR2X1 U34 ( .A(load_enable), .B(n13), .Y(n12) );
  AND2X1 U35 ( .A(shift_enable), .B(n9), .Y(n13) );
  INVX1 U36 ( .A(parallel_in[0]), .Y(n26) );
  INVX1 U37 ( .A(load_enable), .Y(n9) );
endmodule


module Byte_Register ( clk, n_rst, load_en, shift_enable, select, FSM_byte, 
        FIFO_byte, out_bit );
  input [7:0] FSM_byte;
  input [7:0] FIFO_byte;
  input clk, n_rst, load_en, shift_enable, select;
  output out_bit;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16
;

  flex_pts_sr_NUM_BITS8_SHIFT_MSB0 shiftreg ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_enable), .serial_out(out_bit), .load_enable(
        load_en), .parallel_in({n9, n10, n11, n12, n13, n14, n15, n16}) );
  INVX1 U1 ( .A(n1), .Y(n9) );
  MUX2X1 U2 ( .B(FIFO_byte[7]), .A(FSM_byte[7]), .S(select), .Y(n1) );
  INVX1 U3 ( .A(n2), .Y(n10) );
  MUX2X1 U4 ( .B(FIFO_byte[6]), .A(FSM_byte[6]), .S(select), .Y(n2) );
  INVX1 U5 ( .A(n3), .Y(n11) );
  MUX2X1 U6 ( .B(FIFO_byte[5]), .A(FSM_byte[5]), .S(select), .Y(n3) );
  INVX1 U7 ( .A(n4), .Y(n12) );
  MUX2X1 U8 ( .B(FIFO_byte[4]), .A(FSM_byte[4]), .S(select), .Y(n4) );
  INVX1 U9 ( .A(n5), .Y(n13) );
  MUX2X1 U10 ( .B(FIFO_byte[3]), .A(FSM_byte[3]), .S(select), .Y(n5) );
  INVX1 U11 ( .A(n6), .Y(n14) );
  MUX2X1 U12 ( .B(FIFO_byte[2]), .A(FSM_byte[2]), .S(select), .Y(n6) );
  INVX1 U13 ( .A(n7), .Y(n15) );
  MUX2X1 U14 ( .B(FIFO_byte[1]), .A(FSM_byte[1]), .S(select), .Y(n7) );
  INVX1 U15 ( .A(n8), .Y(n16) );
  MUX2X1 U16 ( .B(FIFO_byte[0]), .A(FSM_byte[0]), .S(select), .Y(n8) );
endmodule


module flex_counter_NUM_CNT_BITS4_1 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_flag, n1, n2, n3, n4, n5, n6, n7, n8, n9, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41;
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
  OAI21X1 U8 ( .A(n1), .B(n2), .C(n3), .Y(next_flag) );
  NAND3X1 U9 ( .A(n4), .B(n5), .C(n6), .Y(n3) );
  NOR2X1 U10 ( .A(n7), .B(n8), .Y(n6) );
  OAI22X1 U11 ( .A(rollover_val[1]), .B(n9), .C(rollover_val[0]), .D(n15), .Y(
        n8) );
  OAI21X1 U12 ( .A(next_count[2]), .B(n16), .C(count_enable), .Y(n2) );
  OAI21X1 U13 ( .A(next_count[1]), .B(n17), .C(n18), .Y(n1) );
  INVX1 U14 ( .A(n19), .Y(n18) );
  OAI22X1 U15 ( .A(n20), .B(next_count[3]), .C(n21), .D(next_count[0]), .Y(n19) );
  INVX1 U16 ( .A(rollover_val[0]), .Y(n21) );
  OAI22X1 U17 ( .A(n22), .B(n23), .C(n24), .D(n25), .Y(next_count[3]) );
  AOI22X1 U18 ( .A(count_out[3]), .B(n26), .C(n27), .D(n28), .Y(n24) );
  OAI22X1 U19 ( .A(n29), .B(n23), .C(n30), .D(n25), .Y(next_count[2]) );
  XNOR2X1 U20 ( .A(n27), .B(n28), .Y(n30) );
  NOR2X1 U21 ( .A(n29), .B(n4), .Y(n28) );
  AND2X1 U22 ( .A(n31), .B(count_out[1]), .Y(n27) );
  OAI22X1 U23 ( .A(n9), .B(n23), .C(n32), .D(n25), .Y(next_count[1]) );
  XOR2X1 U24 ( .A(n33), .B(n31), .Y(n32) );
  NAND2X1 U25 ( .A(count_out[1]), .B(n26), .Y(n33) );
  OAI22X1 U26 ( .A(n15), .B(n23), .C(n31), .D(n25), .Y(next_count[0]) );
  NAND2X1 U27 ( .A(count_enable), .B(n34), .Y(n25) );
  INVX1 U28 ( .A(clear), .Y(n34) );
  NOR2X1 U29 ( .A(n15), .B(n4), .Y(n31) );
  INVX1 U30 ( .A(n26), .Y(n4) );
  OAI21X1 U31 ( .A(count_out[3]), .B(n20), .C(n35), .Y(n26) );
  NAND2X1 U32 ( .A(n36), .B(n37), .Y(n35) );
  OAI21X1 U33 ( .A(count_out[2]), .B(n16), .C(n38), .Y(n37) );
  OAI21X1 U34 ( .A(n39), .B(n9), .C(n40), .Y(n38) );
  OAI21X1 U35 ( .A(count_out[1]), .B(n41), .C(n17), .Y(n40) );
  INVX1 U36 ( .A(rollover_val[1]), .Y(n17) );
  INVX1 U37 ( .A(count_out[1]), .Y(n9) );
  INVX1 U38 ( .A(n41), .Y(n39) );
  NAND2X1 U39 ( .A(rollover_val[0]), .B(n15), .Y(n41) );
  INVX1 U40 ( .A(rollover_val[2]), .Y(n16) );
  INVX1 U41 ( .A(n7), .Y(n36) );
  OAI22X1 U42 ( .A(rollover_val[3]), .B(n22), .C(rollover_val[2]), .D(n29), 
        .Y(n7) );
  INVX1 U43 ( .A(count_out[2]), .Y(n29) );
  INVX1 U44 ( .A(count_out[3]), .Y(n22) );
  INVX1 U45 ( .A(rollover_val[3]), .Y(n20) );
  INVX1 U46 ( .A(n5), .Y(n23) );
  NOR2X1 U47 ( .A(count_enable), .B(clear), .Y(n5) );
  INVX1 U48 ( .A(count_out[0]), .Y(n15) );
endmodule


module flex_counter_NUM_CNT_BITS4_0 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_flag, n1, n2, n3, n4, n5, n6, n7, n8, n9, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41;
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
  OAI21X1 U8 ( .A(n1), .B(n2), .C(n3), .Y(next_flag) );
  NAND3X1 U9 ( .A(n4), .B(n5), .C(n6), .Y(n3) );
  NOR2X1 U10 ( .A(n7), .B(n8), .Y(n6) );
  OAI22X1 U11 ( .A(rollover_val[1]), .B(n9), .C(rollover_val[0]), .D(n15), .Y(
        n8) );
  OAI21X1 U12 ( .A(next_count[2]), .B(n16), .C(count_enable), .Y(n2) );
  OAI21X1 U13 ( .A(next_count[1]), .B(n17), .C(n18), .Y(n1) );
  INVX1 U14 ( .A(n19), .Y(n18) );
  OAI22X1 U15 ( .A(n20), .B(next_count[3]), .C(n21), .D(next_count[0]), .Y(n19) );
  INVX1 U16 ( .A(rollover_val[0]), .Y(n21) );
  OAI22X1 U17 ( .A(n22), .B(n23), .C(n24), .D(n25), .Y(next_count[3]) );
  AOI22X1 U18 ( .A(count_out[3]), .B(n26), .C(n27), .D(n28), .Y(n24) );
  OAI22X1 U19 ( .A(n29), .B(n23), .C(n30), .D(n25), .Y(next_count[2]) );
  XNOR2X1 U20 ( .A(n27), .B(n28), .Y(n30) );
  NOR2X1 U21 ( .A(n29), .B(n4), .Y(n28) );
  AND2X1 U22 ( .A(n31), .B(count_out[1]), .Y(n27) );
  OAI22X1 U23 ( .A(n9), .B(n23), .C(n32), .D(n25), .Y(next_count[1]) );
  XOR2X1 U24 ( .A(n33), .B(n31), .Y(n32) );
  NAND2X1 U25 ( .A(count_out[1]), .B(n26), .Y(n33) );
  OAI22X1 U26 ( .A(n15), .B(n23), .C(n31), .D(n25), .Y(next_count[0]) );
  NAND2X1 U27 ( .A(count_enable), .B(n34), .Y(n25) );
  INVX1 U28 ( .A(clear), .Y(n34) );
  NOR2X1 U29 ( .A(n15), .B(n4), .Y(n31) );
  INVX1 U30 ( .A(n26), .Y(n4) );
  OAI21X1 U31 ( .A(count_out[3]), .B(n20), .C(n35), .Y(n26) );
  NAND2X1 U32 ( .A(n36), .B(n37), .Y(n35) );
  OAI21X1 U33 ( .A(count_out[2]), .B(n16), .C(n38), .Y(n37) );
  OAI21X1 U34 ( .A(n39), .B(n9), .C(n40), .Y(n38) );
  OAI21X1 U35 ( .A(count_out[1]), .B(n41), .C(n17), .Y(n40) );
  INVX1 U36 ( .A(rollover_val[1]), .Y(n17) );
  INVX1 U37 ( .A(count_out[1]), .Y(n9) );
  INVX1 U38 ( .A(n41), .Y(n39) );
  NAND2X1 U39 ( .A(rollover_val[0]), .B(n15), .Y(n41) );
  INVX1 U40 ( .A(rollover_val[2]), .Y(n16) );
  INVX1 U41 ( .A(n7), .Y(n36) );
  OAI22X1 U42 ( .A(rollover_val[3]), .B(n22), .C(rollover_val[2]), .D(n29), 
        .Y(n7) );
  INVX1 U43 ( .A(count_out[2]), .Y(n29) );
  INVX1 U44 ( .A(count_out[3]), .Y(n22) );
  INVX1 U45 ( .A(rollover_val[3]), .Y(n20) );
  INVX1 U46 ( .A(n5), .Y(n23) );
  NOR2X1 U47 ( .A(count_enable), .B(clear), .Y(n5) );
  INVX1 U48 ( .A(count_out[0]), .Y(n15) );
endmodule


module flex_counter_NUM_CNT_BITS8_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
endmodule


module flex_counter_NUM_CNT_BITS8 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [7:0] rollover_val;
  output [7:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N8, N9, N10, N11, N12, N13, N14, N15, N26, N27, N28, N29, N30, N31,
         N32, N33, \gte_84/B[0] , \gte_84/B[1] , \gte_84/B[2] , \gte_84/B[3] ,
         \gte_84/B[4] , \gte_84/B[5] , \gte_84/B[6] , \gte_84/B[7] , n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81;

  DFFSR \count_out_reg[0]  ( .D(\gte_84/B[0] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(\gte_84/B[1] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(\gte_84/B[2] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(\gte_84/B[3] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(\gte_84/B[4] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(\gte_84/B[5] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(\gte_84/B[6] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[6]) );
  DFFSR \count_out_reg[7]  ( .D(\gte_84/B[7] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[7]) );
  DFFSR rollover_flag_reg ( .D(n81), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  flex_counter_NUM_CNT_BITS8_DW01_inc_0 add_59_aco ( .A({N33, N32, N31, N30, 
        N29, N28, N27, N26}), .SUM({N15, N14, N13, N12, N11, N10, N9, N8}) );
  OAI21X1 U6 ( .A(n1), .B(n2), .C(n3), .Y(n81) );
  NAND2X1 U7 ( .A(count_enable), .B(n4), .Y(n3) );
  OAI21X1 U8 ( .A(rollover_val[7]), .B(n5), .C(n6), .Y(n4) );
  OAI21X1 U15 ( .A(\gte_84/B[7] ), .B(n7), .C(n8), .Y(n6) );
  OAI21X1 U16 ( .A(rollover_val[6]), .B(n9), .C(n19), .Y(n8) );
  OAI21X1 U17 ( .A(\gte_84/B[6] ), .B(n20), .C(n21), .Y(n19) );
  INVX1 U18 ( .A(n22), .Y(n21) );
  OAI22X1 U19 ( .A(n23), .B(n24), .C(n25), .D(\gte_84/B[5] ), .Y(n22) );
  AND2X1 U20 ( .A(\gte_84/B[5] ), .B(n25), .Y(n24) );
  OAI22X1 U21 ( .A(n26), .B(n27), .C(rollover_val[4]), .D(n28), .Y(n25) );
  OAI21X1 U22 ( .A(\gte_84/B[3] ), .B(n29), .C(n30), .Y(n27) );
  INVX1 U23 ( .A(n31), .Y(n30) );
  AOI21X1 U24 ( .A(n29), .B(\gte_84/B[3] ), .C(n32), .Y(n31) );
  OAI21X1 U25 ( .A(rollover_val[2]), .B(n33), .C(n34), .Y(n29) );
  OAI21X1 U26 ( .A(\gte_84/B[1] ), .B(n35), .C(n36), .Y(n34) );
  AOI22X1 U27 ( .A(n37), .B(rollover_val[0]), .C(rollover_val[2]), .D(n33), 
        .Y(n36) );
  AOI21X1 U28 ( .A(n35), .B(\gte_84/B[1] ), .C(\gte_84/B[0] ), .Y(n37) );
  INVX1 U29 ( .A(\gte_84/B[2] ), .Y(n33) );
  AND2X1 U30 ( .A(n28), .B(rollover_val[4]), .Y(n26) );
  INVX1 U31 ( .A(\gte_84/B[4] ), .Y(n28) );
  INVX1 U32 ( .A(\gte_84/B[6] ), .Y(n9) );
  INVX1 U33 ( .A(rollover_val[7]), .Y(n7) );
  INVX1 U34 ( .A(\gte_84/B[7] ), .Y(n5) );
  NAND3X1 U35 ( .A(n38), .B(n39), .C(n40), .Y(n2) );
  AOI21X1 U36 ( .A(count_out[6]), .B(n20), .C(n41), .Y(n40) );
  OAI22X1 U37 ( .A(rollover_val[5]), .B(n42), .C(rollover_val[1]), .D(n43), 
        .Y(n41) );
  OR2X1 U38 ( .A(n44), .B(n45), .Y(n1) );
  OAI22X1 U39 ( .A(rollover_val[0]), .B(n46), .C(rollover_val[7]), .D(n47), 
        .Y(n45) );
  OAI21X1 U40 ( .A(rollover_val[2]), .B(n48), .C(n49), .Y(n44) );
  OAI21X1 U41 ( .A(n47), .B(n50), .C(n51), .Y(\gte_84/B[7] ) );
  NAND2X1 U42 ( .A(N15), .B(n52), .Y(n51) );
  OAI21X1 U43 ( .A(n53), .B(n50), .C(n54), .Y(\gte_84/B[6] ) );
  NAND2X1 U44 ( .A(N14), .B(n52), .Y(n54) );
  OAI21X1 U45 ( .A(n42), .B(n50), .C(n55), .Y(\gte_84/B[5] ) );
  NAND2X1 U46 ( .A(N13), .B(n52), .Y(n55) );
  OAI21X1 U47 ( .A(n56), .B(n50), .C(n57), .Y(\gte_84/B[4] ) );
  NAND2X1 U48 ( .A(N12), .B(n52), .Y(n57) );
  OAI21X1 U49 ( .A(n58), .B(n50), .C(n59), .Y(\gte_84/B[3] ) );
  NAND2X1 U50 ( .A(N11), .B(n52), .Y(n59) );
  OAI21X1 U51 ( .A(n48), .B(n50), .C(n60), .Y(\gte_84/B[2] ) );
  NAND2X1 U52 ( .A(N10), .B(n52), .Y(n60) );
  OAI21X1 U53 ( .A(n43), .B(n50), .C(n61), .Y(\gte_84/B[1] ) );
  NAND2X1 U54 ( .A(N9), .B(n52), .Y(n61) );
  OAI21X1 U55 ( .A(n46), .B(n50), .C(n62), .Y(\gte_84/B[0] ) );
  NAND2X1 U56 ( .A(N8), .B(n52), .Y(n62) );
  NOR2X1 U57 ( .A(n63), .B(clear), .Y(n52) );
  INVX1 U58 ( .A(count_enable), .Y(n63) );
  INVX1 U59 ( .A(n38), .Y(n50) );
  NOR2X1 U60 ( .A(clear), .B(count_enable), .Y(n38) );
  NOR2X1 U61 ( .A(n39), .B(n47), .Y(N33) );
  NOR2X1 U62 ( .A(n39), .B(n53), .Y(N32) );
  NOR2X1 U63 ( .A(n39), .B(n42), .Y(N31) );
  NOR2X1 U64 ( .A(n39), .B(n56), .Y(N30) );
  NOR2X1 U65 ( .A(n39), .B(n58), .Y(N29) );
  NOR2X1 U66 ( .A(n39), .B(n48), .Y(N28) );
  NOR2X1 U67 ( .A(n39), .B(n43), .Y(N27) );
  NOR2X1 U68 ( .A(n39), .B(n46), .Y(N26) );
  INVX1 U69 ( .A(n64), .Y(n39) );
  OAI21X1 U70 ( .A(count_out[7]), .B(n65), .C(n66), .Y(n64) );
  OAI21X1 U71 ( .A(n67), .B(n47), .C(rollover_val[7]), .Y(n66) );
  INVX1 U72 ( .A(count_out[7]), .Y(n47) );
  INVX1 U73 ( .A(n65), .Y(n67) );
  OAI21X1 U74 ( .A(rollover_val[6]), .B(n53), .C(n68), .Y(n65) );
  OAI21X1 U75 ( .A(count_out[6]), .B(n20), .C(n69), .Y(n68) );
  OAI21X1 U76 ( .A(rollover_val[5]), .B(n42), .C(n70), .Y(n69) );
  OAI21X1 U77 ( .A(count_out[5]), .B(n23), .C(n71), .Y(n70) );
  AOI22X1 U78 ( .A(n49), .B(n72), .C(rollover_val[4]), .D(n56), .Y(n71) );
  OAI21X1 U79 ( .A(count_out[3]), .B(n32), .C(n73), .Y(n72) );
  AOI22X1 U80 ( .A(n74), .B(n75), .C(rollover_val[2]), .D(n48), .Y(n73) );
  INVX1 U81 ( .A(count_out[2]), .Y(n48) );
  OAI21X1 U82 ( .A(count_out[0]), .B(n76), .C(count_out[1]), .Y(n75) );
  INVX1 U83 ( .A(rollover_val[0]), .Y(n76) );
  AOI22X1 U84 ( .A(n77), .B(n35), .C(count_out[2]), .D(n78), .Y(n74) );
  INVX1 U85 ( .A(rollover_val[2]), .Y(n78) );
  INVX1 U86 ( .A(rollover_val[1]), .Y(n35) );
  NAND3X1 U87 ( .A(n46), .B(n43), .C(rollover_val[0]), .Y(n77) );
  INVX1 U88 ( .A(count_out[1]), .Y(n43) );
  INVX1 U89 ( .A(count_out[0]), .Y(n46) );
  INVX1 U90 ( .A(rollover_val[3]), .Y(n32) );
  NOR2X1 U91 ( .A(n79), .B(n80), .Y(n49) );
  NOR2X1 U92 ( .A(n58), .B(rollover_val[3]), .Y(n80) );
  INVX1 U93 ( .A(count_out[3]), .Y(n58) );
  NOR2X1 U94 ( .A(n56), .B(rollover_val[4]), .Y(n79) );
  INVX1 U95 ( .A(count_out[4]), .Y(n56) );
  INVX1 U96 ( .A(rollover_val[5]), .Y(n23) );
  INVX1 U97 ( .A(count_out[5]), .Y(n42) );
  INVX1 U98 ( .A(rollover_val[6]), .Y(n20) );
  INVX1 U99 ( .A(count_out[6]), .Y(n53) );
endmodule


module USB_Timer ( clk, n_rst, bit_sent, Tim_rst, Tim_en, new_bit, byte_out, 
        EOD, Load_Byte );
  output [7:0] byte_out;
  input clk, n_rst, bit_sent, Tim_rst, Tim_en;
  output new_bit, EOD, Load_Byte;


  flex_counter_NUM_CNT_BITS4_1 Width_Generator ( .clk(clk), .n_rst(n_rst), 
        .clear(Tim_rst), .count_enable(Tim_en), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0}), .rollover_flag(new_bit) );
  flex_counter_NUM_CNT_BITS4_0 Bit_Counter ( .clk(clk), .n_rst(n_rst), .clear(
        Tim_rst), .count_enable(bit_sent), .rollover_val({1'b1, 1'b0, 1'b0, 
        1'b0}), .rollover_flag(Load_Byte) );
  flex_counter_NUM_CNT_BITS8 Byte_Counter ( .clk(clk), .n_rst(n_rst), .clear(
        Tim_rst), .count_enable(Load_Byte), .rollover_val({1'b0, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .count_out(byte_out), .rollover_flag(
        EOD) );
endmodule


module flex_counter_NUM_CNT_BITS3 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [2:0] rollover_val;
  output [2:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_flag, n1, n2, n3, n4, n5, n6, n7, n8, n9, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36;
  wire   [2:0] next_count;

  DFFSR \count_out_reg[0]  ( .D(next_count[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(next_count[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(next_count[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[2]) );
  DFFSR rollover_flag_reg ( .D(next_flag), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  MUX2X1 U7 ( .B(n1), .A(n2), .S(n3), .Y(next_flag) );
  NAND3X1 U8 ( .A(n4), .B(n5), .C(n6), .Y(n2) );
  AOI21X1 U9 ( .A(count_out[0]), .B(n7), .C(n8), .Y(n6) );
  NAND2X1 U10 ( .A(n9), .B(n14), .Y(n8) );
  XNOR2X1 U11 ( .A(rollover_val[1]), .B(count_out[1]), .Y(n5) );
  XNOR2X1 U12 ( .A(rollover_val[2]), .B(count_out[2]), .Y(n4) );
  OAI21X1 U13 ( .A(next_count[2]), .B(n15), .C(n16), .Y(n1) );
  INVX1 U14 ( .A(n17), .Y(n16) );
  OAI22X1 U15 ( .A(n7), .B(next_count[0]), .C(n18), .D(next_count[1]), .Y(n17)
         );
  INVX1 U16 ( .A(rollover_val[2]), .Y(n15) );
  OAI21X1 U17 ( .A(n19), .B(n20), .C(n21), .Y(next_count[2]) );
  NAND3X1 U18 ( .A(n22), .B(count_out[1]), .C(n23), .Y(n21) );
  OAI21X1 U19 ( .A(n3), .B(n24), .C(n14), .Y(n20) );
  OAI21X1 U20 ( .A(n25), .B(n26), .C(n27), .Y(next_count[1]) );
  NAND3X1 U21 ( .A(n22), .B(n25), .C(n23), .Y(n27) );
  OAI21X1 U22 ( .A(n28), .B(n3), .C(n14), .Y(n26) );
  NOR2X1 U23 ( .A(n23), .B(n29), .Y(n28) );
  INVX1 U24 ( .A(n24), .Y(n29) );
  OAI21X1 U25 ( .A(n23), .B(n30), .C(n31), .Y(next_count[0]) );
  NAND3X1 U26 ( .A(n14), .B(n3), .C(count_out[0]), .Y(n31) );
  INVX1 U27 ( .A(clear), .Y(n14) );
  INVX1 U28 ( .A(n22), .Y(n30) );
  NOR2X1 U29 ( .A(n3), .B(clear), .Y(n22) );
  INVX1 U30 ( .A(count_enable), .Y(n3) );
  AND2X1 U31 ( .A(count_out[0]), .B(n24), .Y(n23) );
  OAI21X1 U32 ( .A(count_out[2]), .B(n32), .C(n33), .Y(n24) );
  OAI21X1 U33 ( .A(n34), .B(n19), .C(rollover_val[2]), .Y(n33) );
  INVX1 U34 ( .A(count_out[2]), .Y(n19) );
  INVX1 U35 ( .A(n32), .Y(n34) );
  OAI21X1 U36 ( .A(n35), .B(n25), .C(n36), .Y(n32) );
  OAI21X1 U37 ( .A(count_out[1]), .B(n9), .C(n18), .Y(n36) );
  INVX1 U38 ( .A(rollover_val[1]), .Y(n18) );
  INVX1 U39 ( .A(n35), .Y(n9) );
  INVX1 U40 ( .A(count_out[1]), .Y(n25) );
  NOR2X1 U41 ( .A(n7), .B(count_out[0]), .Y(n35) );
  INVX1 U42 ( .A(rollover_val[0]), .Y(n7) );
endmodule


module bit_stuff ( send_next_bit, clk, n_rst, data_bit, Tim_en, raw_to_encoder, 
        shift_enable );
  input send_next_bit, clk, n_rst, data_bit, Tim_en;
  output raw_to_encoder, shift_enable;
  wire   _0_net_, _1_net_, is_stuffing, N0, n2, n3, n4;

  DFFSR raw_to_encoder_reg ( .D(N0), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        raw_to_encoder) );
  flex_counter_NUM_CNT_BITS3 ones_counter ( .clk(clk), .n_rst(n_rst), .clear(
        _0_net_), .count_enable(_1_net_), .rollover_val({1'b1, 1'b1, 1'b0}), 
        .rollover_flag(is_stuffing) );
  NOR2X1 U4 ( .A(is_stuffing), .B(n2), .Y(shift_enable) );
  NOR2X1 U5 ( .A(n2), .B(n3), .Y(_1_net_) );
  INVX1 U6 ( .A(send_next_bit), .Y(n2) );
  NAND2X1 U7 ( .A(n4), .B(Tim_en), .Y(_0_net_) );
  AOI21X1 U8 ( .A(is_stuffing), .B(send_next_bit), .C(n3), .Y(n4) );
  NOR2X1 U9 ( .A(is_stuffing), .B(n3), .Y(N0) );
  INVX1 U10 ( .A(data_bit), .Y(n3) );
endmodule


module Encoder ( Data_In, clk, n_rst, eop, idle, d_plus, d_minus );
  input Data_In, clk, n_rst, eop, idle;
  output d_plus, d_minus;
  wire   n7, n8, n3, n4, n5, n6;

  DFFSR d_minus_reg ( .D(n8), .CLK(clk), .R(n_rst), .S(1'b1), .Q(d_minus) );
  DFFSR d_plus_reg ( .D(n7), .CLK(clk), .R(1'b1), .S(n_rst), .Q(d_plus) );
  NOR2X1 U5 ( .A(n3), .B(n4), .Y(n8) );
  OR2X1 U6 ( .A(eop), .B(idle), .Y(n4) );
  XOR2X1 U7 ( .A(d_minus), .B(Data_In), .Y(n3) );
  OAI21X1 U8 ( .A(eop), .B(n5), .C(n6), .Y(n7) );
  INVX1 U9 ( .A(idle), .Y(n6) );
  XOR2X1 U10 ( .A(d_plus), .B(Data_In), .Y(n5) );
endmodule


module byte_transmitter ( clk, n_rst, FSM_byte, FIFO_byte, load_en, select, 
        idle, Tim_rst, Tim_en, eop, d_plus, d_minus, Load_Byte, byte_out, EOD
 );
  input [7:0] FSM_byte;
  input [7:0] FIFO_byte;
  output [7:0] byte_out;
  input clk, n_rst, load_en, select, idle, Tim_rst, Tim_en, eop;
  output d_plus, d_minus, Load_Byte, EOD;
  wire   shift_enable, to_stuffer, new_bit, to_encoder;

  Byte_Register incoming_byte ( .clk(clk), .n_rst(n_rst), .load_en(load_en), 
        .shift_enable(shift_enable), .select(select), .FSM_byte(FSM_byte), 
        .FIFO_byte(FIFO_byte), .out_bit(to_stuffer) );
  USB_Timer TX_timer ( .clk(clk), .n_rst(n_rst), .bit_sent(shift_enable), 
        .Tim_rst(Tim_rst), .Tim_en(Tim_en), .new_bit(new_bit), .byte_out(
        byte_out), .EOD(EOD), .Load_Byte(Load_Byte) );
  bit_stuff bit_stuffer ( .send_next_bit(new_bit), .clk(clk), .n_rst(n_rst), 
        .data_bit(to_stuffer), .Tim_en(Tim_en), .raw_to_encoder(to_encoder), 
        .shift_enable(shift_enable) );
  Encoder TX_encode ( .Data_In(to_encoder), .clk(clk), .n_rst(n_rst), .eop(eop), .idle(idle), .d_plus(d_plus), .d_minus(d_minus) );
endmodule

