/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 17 16:07:34 2018
/////////////////////////////////////////////////////////////


module sync_high ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   meta;

  DFFSR meta_reg ( .D(async_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(meta) );
  DFFSR sync_out_reg ( .D(meta), .CLK(clk), .R(1'b1), .S(n_rst), .Q(sync_out)
         );
endmodule


module Decoder ( Sync_Ether, Sample, Shift_Enable, clk, n_rst, e_orig, Idle );
  input Sync_Ether, Sample, Shift_Enable, clk, n_rst;
  output e_orig, Idle;
  wire   prev_sample, n9, n11, n13, n1, n2, n3, n4;

  DFFSR new_sample_reg ( .D(n13), .CLK(clk), .R(n_rst), .S(1'b1), .Q(e_orig)
         );
  DFFSR prev_sample_reg ( .D(n11), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prev_sample) );
  DFFPOSX1 Idle_reg ( .D(n9), .CLK(clk), .Q(Idle) );
  MUX2X1 U2 ( .B(n1), .A(n2), .S(n_rst), .Y(n9) );
  NAND3X1 U3 ( .A(e_orig), .B(Shift_Enable), .C(prev_sample), .Y(n2) );
  INVX1 U4 ( .A(Idle), .Y(n1) );
  INVX1 U5 ( .A(n3), .Y(n13) );
  MUX2X1 U6 ( .B(e_orig), .A(Sync_Ether), .S(Sample), .Y(n3) );
  INVX1 U7 ( .A(n4), .Y(n11) );
  MUX2X1 U8 ( .B(prev_sample), .A(e_orig), .S(Sample), .Y(n4) );
endmodule


module edge_detect ( clk, n_rst, d_plus, d_edge );
  input clk, n_rst, d_plus;
  output d_edge;
  wire   prev_sample, curr_sample;

  DFFSR curr_sample_reg ( .D(d_plus), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_sample) );
  DFFSR prev_sample_reg ( .D(curr_sample), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        prev_sample) );
  XOR2X1 U5 ( .A(prev_sample), .B(curr_sample), .Y(d_edge) );
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


module flex_counter_NUM_CNT_BITS2 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [1:0] rollover_val;
  output [1:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n20, \next_count[0] , next_flag, n2, n3, n4, n5, n6, n7, n8, n9, n13,
         n14, n15, n16, n17, n18, n19;

  DFFSR \count_out_reg[0]  ( .D(\next_count[0] ), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n19), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR rollover_flag_reg ( .D(next_flag), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        n20) );
  BUFX2 U6 ( .A(n20), .Y(rollover_flag) );
  MUX2X1 U7 ( .B(n2), .A(n3), .S(n4), .Y(next_flag) );
  NAND3X1 U8 ( .A(n5), .B(n6), .C(n7), .Y(n3) );
  XNOR2X1 U9 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n7) );
  XNOR2X1 U10 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n5) );
  OAI22X1 U11 ( .A(\next_count[0] ), .B(n8), .C(n19), .D(n9), .Y(n2) );
  INVX1 U12 ( .A(rollover_val[1]), .Y(n9) );
  AND2X1 U13 ( .A(n13), .B(n6), .Y(\next_count[0] ) );
  INVX1 U14 ( .A(clear), .Y(n6) );
  MUX2X1 U15 ( .B(n4), .A(n14), .S(count_out[0]), .Y(n13) );
  NOR2X1 U16 ( .A(n4), .B(n15), .Y(n14) );
  INVX1 U17 ( .A(count_enable), .Y(n4) );
  AOI21X1 U18 ( .A(n15), .B(count_enable), .C(n16), .Y(n19) );
  OR2X1 U19 ( .A(n17), .B(clear), .Y(n16) );
  AOI21X1 U20 ( .A(count_enable), .B(count_out[0]), .C(count_out[1]), .Y(n17)
         );
  NAND2X1 U21 ( .A(rollover_val[1]), .B(n18), .Y(n15) );
  OAI21X1 U22 ( .A(count_out[0]), .B(n8), .C(count_out[1]), .Y(n18) );
  INVX1 U23 ( .A(rollover_val[0]), .Y(n8) );
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


module Timer ( clk, n_rst, d_edge, rcving, reset, byte_received, Shift_Enable, 
        Sample );
  input clk, n_rst, d_edge, rcving, reset;
  output byte_received, Shift_Enable, Sample;
  wire   roll_sample, N0, s_clr, b_clr, n1, n2;
  wire   [2:0] c_out;
  assign Sample = N0;

  flex_counter_NUM_CNT_BITS3 Sample_Generator ( .clk(clk), .n_rst(n_rst), 
        .clear(d_edge), .count_enable(rcving), .rollover_val({1'b1, 1'b0, 1'b1}), .count_out(c_out), .rollover_flag(roll_sample) );
  flex_counter_NUM_CNT_BITS2 Shift_Enable_Generator ( .clk(clk), .n_rst(n_rst), 
        .clear(s_clr), .count_enable(N0), .rollover_val({1'b1, 1'b0}), 
        .rollover_flag(Shift_Enable) );
  flex_counter_NUM_CNT_BITS4_1 Bit_Counter ( .clk(clk), .n_rst(n_rst), .clear(
        b_clr), .count_enable(Shift_Enable), .rollover_val({1'b1, 1'b0, 1'b0, 
        1'b0}), .rollover_flag(byte_received) );
  OR2X2 U3 ( .A(Shift_Enable), .B(reset), .Y(s_clr) );
  OR2X1 U4 ( .A(byte_received), .B(reset), .Y(b_clr) );
  OAI21X1 U5 ( .A(c_out[0]), .B(n1), .C(n2), .Y(N0) );
  INVX1 U6 ( .A(roll_sample), .Y(n2) );
  OR2X1 U7 ( .A(c_out[2]), .B(c_out[1]), .Y(n1) );
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


module Counter ( clk, n_rst, byte_received, cnt_rst, count );
  output [3:0] count;
  input clk, n_rst, byte_received, cnt_rst;


  flex_counter_NUM_CNT_BITS4_0 counter ( .clk(clk), .n_rst(n_rst), .clear(
        cnt_rst), .count_enable(byte_received), .rollover_val({1'b1, 1'b1, 
        1'b1, 1'b1}), .count_out(count) );
endmodule


module flex_stp_sr_NUM_BITS8_SHIFT_MSB1 ( clk, n_rst, shift_enable, serial_in, 
        parallel_out );
  output [7:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n12, n14, n16, n18, n20, n22, n24, n26, n1, n2, n3, n4, n5, n6, n7,
         n8;

  DFFSR \parallel_out_reg[0]  ( .D(n26), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  DFFSR \parallel_out_reg[1]  ( .D(n24), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[2]  ( .D(n22), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[3]  ( .D(n20), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[4]  ( .D(n18), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[5]  ( .D(n16), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[6]  ( .D(n14), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[7]  ( .D(n12), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  INVX1 U2 ( .A(n1), .Y(n26) );
  MUX2X1 U3 ( .B(parallel_out[0]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n24) );
  MUX2X1 U5 ( .B(parallel_out[1]), .A(parallel_out[0]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n22) );
  MUX2X1 U7 ( .B(parallel_out[2]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n20) );
  MUX2X1 U9 ( .B(parallel_out[3]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n18) );
  MUX2X1 U11 ( .B(parallel_out[4]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n16) );
  MUX2X1 U13 ( .B(parallel_out[5]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n14) );
  MUX2X1 U15 ( .B(parallel_out[6]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n12) );
  MUX2X1 U17 ( .B(parallel_out[7]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n8) );
endmodule


module shift_register ( clk, n_rst, shift_enable, d_orig, rcv_data );
  output [7:0] rcv_data;
  input clk, n_rst, shift_enable, d_orig;


  flex_stp_sr_NUM_BITS8_SHIFT_MSB1 shift_stp ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_enable), .serial_in(d_orig), .parallel_out(
        rcv_data) );
endmodule


module ERCU ( clk, n_rst, d_edge, Idle, E_Data, count, ERCU_w, reset, cnt_rst, 
        rcving );
  input [7:0] E_Data;
  input [3:0] count;
  input clk, n_rst, d_edge, Idle;
  output ERCU_w, reset, cnt_rst, rcving;
  wire   N72, N73, N74, N77, N78, N79, N80, N82, N83, N84, N85, N98, N99, N100,
         N101, n51, n52, n53, n54, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n55, n56, n57, n58, n59, n60, n61,
         n62, n63;
  wire   [4:0] state;

  DFFSR \state_reg[0]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[3]  ( .D(n53), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[3])
         );
  DFFSR \state_reg[2]  ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n51), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  AND2X2 U4 ( .A(n24), .B(n40), .Y(n5) );
  OAI21X1 U7 ( .A(n5), .B(n38), .C(n26), .Y(n11) );
  NAND2X1 U8 ( .A(state[0]), .B(n38), .Y(n23) );
  NAND3X1 U9 ( .A(n25), .B(n40), .C(N82), .Y(n10) );
  AOI21X1 U10 ( .A(N77), .B(n24), .C(state[3]), .Y(n7) );
  OAI21X1 U11 ( .A(n40), .B(N82), .C(state[1]), .Y(n6) );
  OAI21X1 U13 ( .A(n40), .B(n7), .C(n6), .Y(n8) );
  NAND2X1 U14 ( .A(n8), .B(state[0]), .Y(n9) );
  NAND3X1 U15 ( .A(n11), .B(n10), .C(n9), .Y(N98) );
  AOI21X1 U16 ( .A(N83), .B(state[2]), .C(n23), .Y(n14) );
  AOI22X1 U17 ( .A(N72), .B(n40), .C(N78), .D(state[2]), .Y(n13) );
  NAND2X1 U18 ( .A(n25), .B(n24), .Y(n12) );
  OAI22X1 U19 ( .A(n24), .B(n14), .C(n13), .D(n12), .Y(N99) );
  AOI22X1 U20 ( .A(N79), .B(n24), .C(N84), .D(state[1]), .Y(n15) );
  AND2X1 U21 ( .A(n15), .B(n25), .Y(n17) );
  NAND3X1 U22 ( .A(n5), .B(n25), .C(N73), .Y(n16) );
  OAI21X1 U23 ( .A(n40), .B(n17), .C(n16), .Y(N100) );
  AOI21X1 U24 ( .A(state[0]), .B(n5), .C(n38), .Y(n22) );
  AOI22X1 U25 ( .A(N80), .B(n24), .C(N85), .D(state[1]), .Y(n20) );
  NAND2X1 U26 ( .A(state[2]), .B(state[0]), .Y(n19) );
  NAND3X1 U27 ( .A(n5), .B(n25), .C(N74), .Y(n18) );
  OAI21X1 U28 ( .A(n20), .B(n19), .C(n18), .Y(n21) );
  OR2X1 U29 ( .A(n22), .B(n21), .Y(N101) );
  INVX2 U30 ( .A(state[1]), .Y(n24) );
  INVX2 U31 ( .A(n23), .Y(n25) );
  INVX2 U32 ( .A(state[0]), .Y(n26) );
  INVX1 U33 ( .A(n28), .Y(n54) );
  MUX2X1 U34 ( .B(N98), .A(state[0]), .S(n29), .Y(n28) );
  INVX1 U35 ( .A(n30), .Y(n53) );
  MUX2X1 U36 ( .B(N101), .A(state[3]), .S(n29), .Y(n30) );
  AND2X1 U37 ( .A(N100), .B(n31), .Y(n52) );
  INVX1 U38 ( .A(n29), .Y(n31) );
  INVX1 U39 ( .A(n32), .Y(n51) );
  MUX2X1 U40 ( .B(N99), .A(state[1]), .S(n29), .Y(n32) );
  OAI21X1 U41 ( .A(d_edge), .B(rcving), .C(n33), .Y(n29) );
  NAND2X1 U42 ( .A(n34), .B(n35), .Y(n33) );
  MUX2X1 U43 ( .B(n36), .A(n37), .S(n24), .Y(n35) );
  NAND2X1 U44 ( .A(state[3]), .B(state[0]), .Y(n37) );
  NAND2X1 U45 ( .A(n26), .B(n38), .Y(n36) );
  NOR2X1 U46 ( .A(state[2]), .B(Idle), .Y(n34) );
  INVX1 U47 ( .A(rcving), .Y(reset) );
  OAI21X1 U48 ( .A(state[0]), .B(n39), .C(rcving), .Y(cnt_rst) );
  NAND3X1 U49 ( .A(n40), .B(n38), .C(n41), .Y(rcving) );
  XNOR2X1 U50 ( .A(state[1]), .B(state[0]), .Y(n41) );
  MUX2X1 U51 ( .B(n38), .A(n24), .S(n40), .Y(n39) );
  NAND2X1 U52 ( .A(n38), .B(n42), .Y(N85) );
  NOR2X1 U53 ( .A(n43), .B(n38), .Y(N80) );
  NAND2X1 U54 ( .A(n40), .B(n44), .Y(N79) );
  NAND2X1 U55 ( .A(n24), .B(n44), .Y(N78) );
  NOR2X1 U56 ( .A(n43), .B(n26), .Y(N77) );
  INVX1 U57 ( .A(n44), .Y(n43) );
  NAND3X1 U58 ( .A(count[2]), .B(count[0]), .C(n45), .Y(n44) );
  NOR2X1 U59 ( .A(count[3]), .B(count[1]), .Y(n45) );
  NOR2X1 U60 ( .A(n46), .B(n38), .Y(N74) );
  OAI21X1 U61 ( .A(n47), .B(n42), .C(n48), .Y(N73) );
  INVX1 U62 ( .A(N84), .Y(n48) );
  NOR2X1 U63 ( .A(n40), .B(n46), .Y(N84) );
  INVX1 U64 ( .A(state[2]), .Y(n40) );
  INVX1 U65 ( .A(n49), .Y(N72) );
  AOI21X1 U66 ( .A(n47), .B(n46), .C(N83), .Y(n49) );
  NOR2X1 U67 ( .A(n24), .B(n46), .Y(N83) );
  NAND3X1 U68 ( .A(n50), .B(n55), .C(n56), .Y(n47) );
  NOR2X1 U69 ( .A(n57), .B(n58), .Y(n56) );
  NAND2X1 U70 ( .A(E_Data[7]), .B(E_Data[5]), .Y(n58) );
  NAND2X1 U71 ( .A(E_Data[3]), .B(E_Data[1]), .Y(n57) );
  NOR2X1 U72 ( .A(E_Data[6]), .B(E_Data[4]), .Y(n55) );
  NOR2X1 U73 ( .A(E_Data[2]), .B(n59), .Y(n50) );
  INVX1 U74 ( .A(E_Data[0]), .Y(n59) );
  NOR2X1 U75 ( .A(n26), .B(n46), .Y(N82) );
  INVX1 U76 ( .A(n42), .Y(n46) );
  NAND3X1 U77 ( .A(count[3]), .B(n60), .C(n61), .Y(n42) );
  NOR2X1 U78 ( .A(count[2]), .B(count[1]), .Y(n61) );
  INVX1 U79 ( .A(count[0]), .Y(n60) );
  NOR2X1 U80 ( .A(n62), .B(n63), .Y(ERCU_w) );
  NAND2X1 U81 ( .A(state[2]), .B(state[0]), .Y(n63) );
  NAND2X1 U82 ( .A(state[1]), .B(n38), .Y(n62) );
  INVX1 U83 ( .A(state[3]), .Y(n38) );
endmodule


module Packet_Processor ( clk, n_rst, FULL, Ethernet_In, w_enable, E_Data, 
        Ethernet_Out );
  output [7:0] E_Data;
  input clk, n_rst, FULL, Ethernet_In;
  output w_enable, Ethernet_Out;
  wire   Ethernet_Out, Sync_Ether, Sample, Shift_Enable, e_orig, Idle, d_edge,
         rcving, reset, byte_received, cnt_rst, ERCU_w, n4, n5;
  wire   [3:0] count;
  assign Ethernet_Out = Ethernet_In;

  sync_high Synchronizer ( .clk(clk), .n_rst(n_rst), .async_in(Ethernet_Out), 
        .sync_out(Sync_Ether) );
  Decoder Manchester_Decoder ( .Sync_Ether(Sync_Ether), .Sample(Sample), 
        .Shift_Enable(Shift_Enable), .clk(clk), .n_rst(n_rst), .e_orig(e_orig), 
        .Idle(Idle) );
  edge_detect Edge_Detector ( .clk(clk), .n_rst(n_rst), .d_plus(Sync_Ether), 
        .d_edge(d_edge) );
  Timer Timer_Control ( .clk(clk), .n_rst(n_rst), .d_edge(d_edge), .rcving(
        rcving), .reset(reset), .byte_received(byte_received), .Shift_Enable(
        Shift_Enable), .Sample(Sample) );
  Counter Counter_Controller ( .clk(clk), .n_rst(n_rst), .byte_received(
        byte_received), .cnt_rst(cnt_rst), .count(count) );
  shift_register Shift_Register ( .clk(clk), .n_rst(n_rst), .shift_enable(
        Shift_Enable), .d_orig(e_orig), .rcv_data(E_Data) );
  ERCU ERCU_FSM ( .clk(clk), .n_rst(n_rst), .d_edge(d_edge), .Idle(Idle), 
        .E_Data(E_Data), .count(count), .ERCU_w(ERCU_w), .reset(reset), 
        .cnt_rst(cnt_rst), .rcving(rcving) );
  INVX1 U4 ( .A(n4), .Y(w_enable) );
  NAND3X1 U5 ( .A(ERCU_w), .B(n5), .C(byte_received), .Y(n4) );
  INVX1 U6 ( .A(FULL), .Y(n5) );
endmodule

