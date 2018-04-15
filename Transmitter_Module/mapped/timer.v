/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar 31 19:44:17 2018
/////////////////////////////////////////////////////////////


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


module timer ( clk, n_rst, d_edge, rcving, shift_enable, byte_received );
  input clk, n_rst, d_edge, rcving;
  output shift_enable, byte_received;
  wire   _0_net_, _2_net_, n5, n6, n7;
  wire   [3:0] sampling_count;

  flex_counter_NUM_CNT_BITS4_1 samplingTimer ( .clk(clk), .n_rst(n_rst), 
        .clear(_0_net_), .count_enable(rcving), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0}), .count_out(sampling_count) );
  flex_counter_NUM_CNT_BITS4_0 sampleCount ( .clk(clk), .n_rst(n_rst), .clear(
        _2_net_), .count_enable(shift_enable), .rollover_val({1'b1, 1'b0, 1'b0, 
        1'b0}), .rollover_flag(byte_received) );
  INVX1 U9 ( .A(n5), .Y(shift_enable) );
  NAND3X1 U10 ( .A(sampling_count[1]), .B(sampling_count[0]), .C(n6), .Y(n5)
         );
  NOR2X1 U11 ( .A(sampling_count[3]), .B(sampling_count[2]), .Y(n6) );
  OR2X1 U12 ( .A(byte_received), .B(n7), .Y(_2_net_) );
  OR2X1 U13 ( .A(d_edge), .B(n7), .Y(_0_net_) );
  INVX1 U14 ( .A(rcving), .Y(n7) );
endmodule

