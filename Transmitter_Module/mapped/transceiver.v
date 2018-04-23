/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Apr 23 15:00:04 2018
/////////////////////////////////////////////////////////////


module txpu ( clk, n_rst, Load_Byte, send_nak, send_data, EOD, send_crc, 
        tim_new_bit, FSM_byte, load_en, select, Tim_rst, Tim_en, eop, 
        eop_new_bit, fifo_r_enable, is_txing, calc_crc, crc_reset );
  output [7:0] FSM_byte;
  output [1:0] select;
  input clk, n_rst, Load_Byte, send_nak, send_data, EOD, send_crc, tim_new_bit;
  output load_en, Tim_rst, Tim_en, eop, eop_new_bit, fifo_r_enable, is_txing,
         calc_crc, crc_reset;
  wire   eop, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, \FSM_byte[6] ;
  wire   [3:0] state;
  wire   [3:0] next_state;
  assign FSM_byte[2] = FSM_byte[5];
  assign eop_new_bit = eop;
  assign FSM_byte[1] = \FSM_byte[6] ;
  assign FSM_byte[3] = \FSM_byte[6] ;
  assign FSM_byte[6] = \FSM_byte[6] ;

  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[0]) );
  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[3]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[1]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  NAND3X1 U7 ( .A(n5), .B(n6), .C(n7), .Y(select[0]) );
  NOR2X1 U8 ( .A(n8), .B(n9), .Y(n7) );
  OR2X1 U9 ( .A(n10), .B(n11), .Y(next_state[3]) );
  OAI21X1 U10 ( .A(Load_Byte), .B(n12), .C(n13), .Y(n11) );
  NAND3X1 U11 ( .A(n6), .B(n14), .C(n15), .Y(n10) );
  NAND3X1 U12 ( .A(n16), .B(n17), .C(n18), .Y(next_state[2]) );
  NOR2X1 U13 ( .A(n19), .B(n20), .Y(n18) );
  OAI21X1 U14 ( .A(n21), .B(n22), .C(n13), .Y(n20) );
  INVX1 U15 ( .A(n23), .Y(n13) );
  OAI21X1 U16 ( .A(n24), .B(n21), .C(n25), .Y(n23) );
  NOR2X1 U17 ( .A(n26), .B(n27), .Y(n25) );
  OAI21X1 U18 ( .A(n28), .B(n29), .C(n30), .Y(n19) );
  NAND2X1 U19 ( .A(n31), .B(n32), .Y(n29) );
  NOR2X1 U20 ( .A(n33), .B(n34), .Y(n17) );
  INVX1 U21 ( .A(n35), .Y(n34) );
  NOR2X1 U22 ( .A(n36), .B(n37), .Y(n16) );
  NAND3X1 U23 ( .A(n38), .B(n39), .C(n40), .Y(next_state[1]) );
  NOR2X1 U24 ( .A(n41), .B(n42), .Y(n40) );
  OAI21X1 U25 ( .A(n43), .B(n44), .C(n45), .Y(n42) );
  NOR2X1 U26 ( .A(n33), .B(n46), .Y(n39) );
  NOR3X1 U27 ( .A(n12), .B(EOD), .C(n21), .Y(n33) );
  AOI22X1 U28 ( .A(n36), .B(Load_Byte), .C(tim_new_bit), .D(n26), .Y(n38) );
  OR2X1 U29 ( .A(n47), .B(n48), .Y(next_state[0]) );
  NAND3X1 U30 ( .A(n49), .B(n45), .C(n50), .Y(n48) );
  MUX2X1 U31 ( .B(n36), .A(n51), .S(Load_Byte), .Y(n50) );
  OR2X1 U32 ( .A(n41), .B(n52), .Y(n51) );
  NAND3X1 U33 ( .A(n5), .B(n53), .C(n30), .Y(n41) );
  AOI21X1 U34 ( .A(n21), .B(n54), .C(n55), .Y(n45) );
  INVX1 U35 ( .A(n22), .Y(n55) );
  INVX1 U36 ( .A(Load_Byte), .Y(n21) );
  MUX2X1 U37 ( .B(n26), .A(n27), .S(tim_new_bit), .Y(n49) );
  INVX1 U38 ( .A(n56), .Y(n27) );
  NAND3X1 U39 ( .A(n57), .B(n6), .C(n58), .Y(n47) );
  AOI22X1 U40 ( .A(send_nak), .B(n31), .C(n8), .D(n44), .Y(n58) );
  INVX1 U41 ( .A(send_crc), .Y(n44) );
  OAI21X1 U42 ( .A(n59), .B(n60), .C(n61), .Y(load_en) );
  INVX1 U43 ( .A(tim_new_bit), .Y(n60) );
  OAI21X1 U44 ( .A(tim_new_bit), .B(n59), .C(n56), .Y(eop) );
  OR2X1 U45 ( .A(n9), .B(n62), .Y(crc_reset) );
  OAI21X1 U46 ( .A(Load_Byte), .B(n30), .C(n56), .Y(n62) );
  NAND3X1 U47 ( .A(n63), .B(n61), .C(n64), .Y(n9) );
  NOR2X1 U48 ( .A(n36), .B(n31), .Y(n64) );
  INVX1 U49 ( .A(n65), .Y(n31) );
  INVX1 U50 ( .A(n66), .Y(n36) );
  INVX1 U51 ( .A(n14), .Y(calc_crc) );
  OAI21X1 U52 ( .A(n65), .B(n67), .C(n68), .Y(Tim_rst) );
  OAI21X1 U53 ( .A(n69), .B(n54), .C(Load_Byte), .Y(n68) );
  NAND2X1 U54 ( .A(n35), .B(n24), .Y(n54) );
  INVX1 U55 ( .A(n30), .Y(n69) );
  NAND2X1 U56 ( .A(n28), .B(n32), .Y(n67) );
  NAND3X1 U57 ( .A(n28), .B(n32), .C(n70), .Y(Tim_en) );
  INVX1 U58 ( .A(is_txing), .Y(n70) );
  NAND2X1 U59 ( .A(n61), .B(n71), .Y(is_txing) );
  INVX1 U60 ( .A(\FSM_byte[6] ), .Y(n71) );
  NAND2X1 U61 ( .A(n63), .B(n72), .Y(\FSM_byte[6] ) );
  INVX1 U62 ( .A(send_nak), .Y(n32) );
  INVX1 U63 ( .A(send_data), .Y(n28) );
  NAND3X1 U64 ( .A(n65), .B(n73), .C(n61), .Y(FSM_byte[7]) );
  NOR2X1 U65 ( .A(n46), .B(n37), .Y(n61) );
  INVX1 U66 ( .A(n57), .Y(n37) );
  NAND2X1 U67 ( .A(n74), .B(n75), .Y(n57) );
  AND2X1 U68 ( .A(n76), .B(n77), .Y(n46) );
  NAND2X1 U69 ( .A(n76), .B(n75), .Y(n65) );
  NAND2X1 U70 ( .A(n63), .B(n73), .Y(FSM_byte[4]) );
  INVX1 U71 ( .A(FSM_byte[5]), .Y(n73) );
  NAND3X1 U72 ( .A(n43), .B(n6), .C(n78), .Y(FSM_byte[5]) );
  NAND2X1 U73 ( .A(EOD), .B(n52), .Y(n6) );
  AND2X1 U74 ( .A(n24), .B(n53), .Y(n63) );
  NAND2X1 U75 ( .A(n76), .B(n79), .Y(n53) );
  NAND2X1 U76 ( .A(n76), .B(n80), .Y(n24) );
  NOR2X1 U77 ( .A(state[3]), .B(state[2]), .Y(n76) );
  INVX1 U78 ( .A(n72), .Y(FSM_byte[0]) );
  NOR2X1 U79 ( .A(n81), .B(n82), .Y(n72) );
  NAND3X1 U80 ( .A(n30), .B(n56), .C(n78), .Y(n82) );
  AOI21X1 U81 ( .A(n79), .B(n83), .C(n26), .Y(n78) );
  INVX1 U82 ( .A(n59), .Y(n26) );
  NAND2X1 U83 ( .A(n77), .B(n83), .Y(n59) );
  NAND2X1 U84 ( .A(n75), .B(n83), .Y(n56) );
  NAND2X1 U85 ( .A(n74), .B(n79), .Y(n30) );
  NAND3X1 U86 ( .A(n66), .B(n14), .C(n84), .Y(n81) );
  NOR2X1 U87 ( .A(n52), .B(fifo_r_enable), .Y(n84) );
  INVX1 U88 ( .A(n15), .Y(fifo_r_enable) );
  NAND2X1 U89 ( .A(n74), .B(n80), .Y(n15) );
  INVX1 U90 ( .A(n12), .Y(n52) );
  NAND2X1 U91 ( .A(n75), .B(n85), .Y(n12) );
  NOR2X1 U92 ( .A(state[1]), .B(state[0]), .Y(n75) );
  NOR2X1 U93 ( .A(n8), .B(select[1]), .Y(n14) );
  NAND3X1 U94 ( .A(n35), .B(n5), .C(n22), .Y(select[1]) );
  NAND2X1 U95 ( .A(n80), .B(n85), .Y(n22) );
  NAND2X1 U96 ( .A(n85), .B(n79), .Y(n5) );
  NOR2X1 U97 ( .A(n86), .B(state[0]), .Y(n79) );
  NAND2X1 U98 ( .A(n80), .B(n83), .Y(n35) );
  NOR2X1 U99 ( .A(n87), .B(n88), .Y(n83) );
  NOR2X1 U100 ( .A(n89), .B(n86), .Y(n80) );
  INVX1 U101 ( .A(state[1]), .Y(n86) );
  INVX1 U102 ( .A(n43), .Y(n8) );
  NAND2X1 U103 ( .A(n77), .B(n85), .Y(n43) );
  NOR2X1 U104 ( .A(n88), .B(state[2]), .Y(n85) );
  INVX1 U105 ( .A(state[3]), .Y(n88) );
  NAND2X1 U106 ( .A(n74), .B(n77), .Y(n66) );
  NOR2X1 U107 ( .A(n89), .B(state[1]), .Y(n77) );
  INVX1 U108 ( .A(state[0]), .Y(n89) );
  NOR2X1 U109 ( .A(n87), .B(state[3]), .Y(n74) );
  INVX1 U110 ( .A(state[2]), .Y(n87) );
endmodule


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
        FIFO_byte, CRC_Bytes, out_bit );
  input [1:0] select;
  input [7:0] FSM_byte;
  input [7:0] FIFO_byte;
  input [15:0] CRC_Bytes;
  input clk, n_rst, load_en, shift_enable;
  output out_bit;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21;
  wire   [7:0] mux_byte;

  flex_pts_sr_NUM_BITS8_SHIFT_MSB0 shiftreg ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_enable), .serial_out(out_bit), .load_enable(
        load_en), .parallel_in(mux_byte) );
  NAND2X1 U1 ( .A(n1), .B(n2), .Y(mux_byte[7]) );
  AOI22X1 U2 ( .A(CRC_Bytes[15]), .B(n3), .C(CRC_Bytes[7]), .D(n4), .Y(n2) );
  AOI22X1 U3 ( .A(FSM_byte[7]), .B(n5), .C(FIFO_byte[7]), .D(n6), .Y(n1) );
  NAND2X1 U4 ( .A(n7), .B(n8), .Y(mux_byte[6]) );
  AOI22X1 U5 ( .A(CRC_Bytes[14]), .B(n3), .C(CRC_Bytes[6]), .D(n4), .Y(n8) );
  AOI22X1 U6 ( .A(FSM_byte[6]), .B(n5), .C(FIFO_byte[6]), .D(n6), .Y(n7) );
  NAND2X1 U7 ( .A(n9), .B(n10), .Y(mux_byte[5]) );
  AOI22X1 U8 ( .A(CRC_Bytes[13]), .B(n3), .C(CRC_Bytes[5]), .D(n4), .Y(n10) );
  AOI22X1 U9 ( .A(FSM_byte[5]), .B(n5), .C(FIFO_byte[5]), .D(n6), .Y(n9) );
  NAND2X1 U10 ( .A(n11), .B(n12), .Y(mux_byte[4]) );
  AOI22X1 U11 ( .A(CRC_Bytes[12]), .B(n3), .C(CRC_Bytes[4]), .D(n4), .Y(n12)
         );
  AOI22X1 U12 ( .A(FSM_byte[4]), .B(n5), .C(FIFO_byte[4]), .D(n6), .Y(n11) );
  NAND2X1 U13 ( .A(n13), .B(n14), .Y(mux_byte[3]) );
  AOI22X1 U14 ( .A(CRC_Bytes[11]), .B(n3), .C(CRC_Bytes[3]), .D(n4), .Y(n14)
         );
  AOI22X1 U15 ( .A(FSM_byte[3]), .B(n5), .C(FIFO_byte[3]), .D(n6), .Y(n13) );
  NAND2X1 U16 ( .A(n15), .B(n16), .Y(mux_byte[2]) );
  AOI22X1 U17 ( .A(CRC_Bytes[10]), .B(n3), .C(CRC_Bytes[2]), .D(n4), .Y(n16)
         );
  AOI22X1 U18 ( .A(FSM_byte[2]), .B(n5), .C(FIFO_byte[2]), .D(n6), .Y(n15) );
  NAND2X1 U19 ( .A(n17), .B(n18), .Y(mux_byte[1]) );
  AOI22X1 U20 ( .A(CRC_Bytes[9]), .B(n3), .C(CRC_Bytes[1]), .D(n4), .Y(n18) );
  AOI22X1 U21 ( .A(FSM_byte[1]), .B(n5), .C(FIFO_byte[1]), .D(n6), .Y(n17) );
  NAND2X1 U22 ( .A(n19), .B(n20), .Y(mux_byte[0]) );
  AOI22X1 U23 ( .A(CRC_Bytes[8]), .B(n3), .C(CRC_Bytes[0]), .D(n4), .Y(n20) );
  AND2X1 U24 ( .A(select[0]), .B(select[1]), .Y(n4) );
  AND2X1 U25 ( .A(select[1]), .B(n21), .Y(n3) );
  AOI22X1 U26 ( .A(FSM_byte[0]), .B(n5), .C(FIFO_byte[0]), .D(n6), .Y(n19) );
  NOR2X1 U27 ( .A(select[0]), .B(select[1]), .Y(n6) );
  NOR2X1 U28 ( .A(n21), .B(select[1]), .Y(n5) );
  INVX1 U29 ( .A(select[0]), .Y(n21) );
endmodule


module flex_counter_NUM_CNT_BITS4_3 ( clk, n_rst, clear, count_enable, 
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


module flex_counter_NUM_CNT_BITS4_2 ( clk, n_rst, clear, count_enable, 
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
  wire   bit_reset, last_bit;

  flex_counter_NUM_CNT_BITS4_3 Width_Generator ( .clk(clk), .n_rst(n_rst), 
        .clear(Tim_rst), .count_enable(Tim_en), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0}), .rollover_flag(new_bit) );
  flex_counter_NUM_CNT_BITS4_2 Bit_Counter ( .clk(clk), .n_rst(n_rst), .clear(
        bit_reset), .count_enable(bit_sent), .rollover_val({1'b0, 1'b1, 1'b1, 
        1'b1}), .rollover_flag(last_bit) );
  flex_counter_NUM_CNT_BITS8 Byte_Counter ( .clk(clk), .n_rst(n_rst), .clear(
        Tim_rst), .count_enable(Load_Byte), .rollover_val({1'b0, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .count_out(byte_out), .rollover_flag(
        EOD) );
  OR2X1 U3 ( .A(Load_Byte), .B(Tim_rst), .Y(bit_reset) );
  AND2X1 U4 ( .A(last_bit), .B(bit_sent), .Y(Load_Byte) );
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


module Encoder ( Data_In, clk, n_rst, eop, idle, new_bit, d_plus, d_minus );
  input Data_In, clk, n_rst, eop, idle, new_bit;
  output d_plus, d_minus;
  wire   n15, n16, n3, n4, n5, n6, n7, n8, n9, n10;

  DFFSR d_minus_reg ( .D(n16), .CLK(clk), .R(n_rst), .S(1'b1), .Q(d_minus) );
  DFFSR d_plus_reg ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(d_plus) );
  MUX2X1 U5 ( .B(n3), .A(n4), .S(d_minus), .Y(n16) );
  NAND3X1 U6 ( .A(n5), .B(n6), .C(n4), .Y(n3) );
  MUX2X1 U7 ( .B(n7), .A(n8), .S(n4), .Y(n15) );
  OAI21X1 U8 ( .A(Data_In), .B(n9), .C(n10), .Y(n4) );
  AND2X1 U9 ( .A(n6), .B(n5), .Y(n10) );
  INVX1 U10 ( .A(idle), .Y(n6) );
  INVX1 U11 ( .A(new_bit), .Y(n9) );
  AOI21X1 U12 ( .A(n5), .B(n7), .C(idle), .Y(n8) );
  NAND2X1 U13 ( .A(new_bit), .B(eop), .Y(n5) );
  INVX1 U14 ( .A(d_plus), .Y(n7) );
endmodule


module byte_transmitter ( clk, n_rst, FSM_byte, FIFO_byte, CRC_Bytes, load_en, 
        select, idle, Tim_rst, Tim_en, eop, eop_new_bit, d_plus, d_minus, 
        to_encoder, Load_Byte, byte_out, EOD, shift_enable, to_stuffer, 
        tim_new_bit );
  input [7:0] FSM_byte;
  input [7:0] FIFO_byte;
  input [15:0] CRC_Bytes;
  input [1:0] select;
  output [7:0] byte_out;
  input clk, n_rst, load_en, idle, Tim_rst, Tim_en, eop, eop_new_bit;
  output d_plus, d_minus, to_encoder, Load_Byte, EOD, shift_enable, to_stuffer,
         tim_new_bit;
  wire   _0_net_, _1_net_;

  Byte_Register incoming_byte ( .clk(clk), .n_rst(n_rst), .load_en(_0_net_), 
        .shift_enable(shift_enable), .select(select), .FSM_byte(FSM_byte), 
        .FIFO_byte(FIFO_byte), .CRC_Bytes(CRC_Bytes), .out_bit(to_stuffer) );
  USB_Timer TX_timer ( .clk(clk), .n_rst(n_rst), .bit_sent(shift_enable), 
        .Tim_rst(Tim_rst), .Tim_en(Tim_en), .new_bit(tim_new_bit), .byte_out(
        byte_out), .EOD(EOD), .Load_Byte(Load_Byte) );
  bit_stuff bit_stuffer ( .send_next_bit(tim_new_bit), .clk(clk), .n_rst(n_rst), .data_bit(to_stuffer), .Tim_en(Tim_en), .raw_to_encoder(to_encoder), 
        .shift_enable(shift_enable) );
  Encoder TX_encode ( .Data_In(to_encoder), .clk(clk), .n_rst(n_rst), .eop(eop), .idle(idle), .new_bit(_1_net_), .d_plus(d_plus), .d_minus(d_minus) );
  OR2X1 U1 ( .A(eop_new_bit), .B(tim_new_bit), .Y(_1_net_) );
  OR2X1 U2 ( .A(Load_Byte), .B(load_en), .Y(_0_net_) );
endmodule


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
  wire   Serial_In, Shift_Enable, n72, n73, n74, n75, n76, n77, n78, n79, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n80, n82;
  wire   [2:0] state;
  wire   [4:0] count;
  wire   SYNOPSYS_UNCONNECTED__0;

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
        n82), .parallel_in({n80, n71, CRC_Bytes[14:3], n70, CRC_Bytes[1], n69}), .parallel_out({SYNOPSYS_UNCONNECTED__0, CRC_Bytes}), .serial_out(serial_out)
         );
  INVX1 U11 ( .A(CRC_Bytes[0]), .Y(n69) );
  INVX1 U12 ( .A(CRC_Bytes[2]), .Y(n70) );
  INVX1 U13 ( .A(CRC_Bytes[15]), .Y(n71) );
  OAI21X1 U14 ( .A(n9), .B(n10), .C(n11), .Y(n79) );
  AOI21X1 U15 ( .A(n12), .B(n13), .C(n14), .Y(n11) );
  OAI22X1 U16 ( .A(CRC_Calc), .B(n15), .C(n16), .D(n17), .Y(n13) );
  MUX2X1 U17 ( .B(n18), .A(n19), .S(count[4]), .Y(n78) );
  AOI21X1 U18 ( .A(n20), .B(n21), .C(n22), .Y(n19) );
  NAND3X1 U19 ( .A(n23), .B(n20), .C(count[3]), .Y(n18) );
  OAI22X1 U20 ( .A(n9), .B(n24), .C(n25), .D(n26), .Y(n77) );
  AOI22X1 U21 ( .A(CRC_Calc), .B(n27), .C(n28), .D(n80), .Y(n25) );
  INVX1 U22 ( .A(serial_out), .Y(n80) );
  OAI21X1 U23 ( .A(serial_out), .B(n29), .C(n30), .Y(n27) );
  NOR2X1 U24 ( .A(n82), .B(n31), .Y(n30) );
  OAI21X1 U25 ( .A(n9), .B(n32), .C(n33), .Y(n76) );
  AOI21X1 U26 ( .A(n12), .B(n34), .C(n14), .Y(n33) );
  NOR2X1 U27 ( .A(n26), .B(n35), .Y(n14) );
  OAI21X1 U28 ( .A(n36), .B(n28), .C(serial_out), .Y(n35) );
  INVX1 U29 ( .A(n37), .Y(n28) );
  OAI22X1 U30 ( .A(CRC_Calc), .B(n38), .C(n17), .D(n39), .Y(n34) );
  INVX1 U31 ( .A(n16), .Y(n39) );
  NOR2X1 U32 ( .A(n40), .B(n41), .Y(n16) );
  NAND3X1 U33 ( .A(state[2]), .B(n42), .C(count[4]), .Y(n41) );
  INVX1 U34 ( .A(count[0]), .Y(n42) );
  NAND3X1 U35 ( .A(n43), .B(n21), .C(n44), .Y(n40) );
  INVX1 U36 ( .A(count[3]), .Y(n21) );
  INVX1 U37 ( .A(count[2]), .Y(n43) );
  INVX1 U38 ( .A(n26), .Y(n12) );
  NAND2X1 U39 ( .A(n45), .B(n46), .Y(n26) );
  INVX1 U40 ( .A(n47), .Y(n9) );
  OAI21X1 U41 ( .A(n48), .B(n49), .C(n46), .Y(n47) );
  OAI21X1 U42 ( .A(CRC_Send), .B(n50), .C(n51), .Y(n46) );
  AOI21X1 U43 ( .A(n52), .B(n53), .C(reset), .Y(n51) );
  NOR2X1 U44 ( .A(CRC_Calc), .B(n31), .Y(n52) );
  INVX1 U45 ( .A(n15), .Y(n31) );
  AOI21X1 U46 ( .A(CRC_Calc), .B(n53), .C(bit_in), .Y(n50) );
  OR2X1 U47 ( .A(n17), .B(state[2]), .Y(n53) );
  INVX1 U48 ( .A(n54), .Y(CRC_Send) );
  NAND2X1 U49 ( .A(n55), .B(n38), .Y(n49) );
  NOR2X1 U50 ( .A(n36), .B(n82), .Y(n38) );
  INVX1 U51 ( .A(n56), .Y(n82) );
  NAND3X1 U52 ( .A(state[1]), .B(n24), .C(state[0]), .Y(n56) );
  INVX1 U53 ( .A(n29), .Y(n36) );
  NAND3X1 U54 ( .A(n32), .B(n24), .C(state[0]), .Y(n29) );
  INVX1 U55 ( .A(n57), .Y(n55) );
  NAND2X1 U56 ( .A(n54), .B(n45), .Y(n48) );
  INVX1 U57 ( .A(reset), .Y(n45) );
  NAND3X1 U58 ( .A(state[1]), .B(n10), .C(state[2]), .Y(n54) );
  MUX2X1 U59 ( .B(n58), .A(n57), .S(count[0]), .Y(n75) );
  MUX2X1 U60 ( .B(n59), .A(n60), .S(count[1]), .Y(n74) );
  INVX1 U61 ( .A(n61), .Y(n60) );
  NAND2X1 U62 ( .A(n20), .B(count[0]), .Y(n59) );
  MUX2X1 U63 ( .B(n62), .A(n63), .S(count[2]), .Y(n73) );
  AOI21X1 U64 ( .A(n20), .B(n44), .C(n61), .Y(n63) );
  OAI21X1 U65 ( .A(count[0]), .B(n58), .C(n57), .Y(n61) );
  INVX1 U66 ( .A(count[1]), .Y(n44) );
  NAND3X1 U67 ( .A(count[1]), .B(count[0]), .C(n20), .Y(n62) );
  MUX2X1 U68 ( .B(n64), .A(n65), .S(count[3]), .Y(n72) );
  INVX1 U69 ( .A(n22), .Y(n65) );
  OAI21X1 U70 ( .A(n23), .B(n58), .C(n57), .Y(n22) );
  NAND2X1 U71 ( .A(n23), .B(n20), .Y(n64) );
  INVX1 U72 ( .A(n58), .Y(n20) );
  NAND2X1 U73 ( .A(n15), .B(n57), .Y(n58) );
  NAND2X1 U74 ( .A(n15), .B(n37), .Y(n57) );
  NAND3X1 U75 ( .A(state[2]), .B(n32), .C(state[0]), .Y(n37) );
  NAND3X1 U76 ( .A(n10), .B(n24), .C(state[1]), .Y(n15) );
  INVX1 U77 ( .A(n66), .Y(n23) );
  NAND3X1 U78 ( .A(count[1]), .B(count[0]), .C(count[2]), .Y(n66) );
  OAI21X1 U79 ( .A(n24), .B(n17), .C(n67), .Y(Shift_Enable) );
  NAND2X1 U80 ( .A(new_bit), .B(n68), .Y(n67) );
  NAND2X1 U81 ( .A(n10), .B(n32), .Y(n17) );
  INVX1 U82 ( .A(state[1]), .Y(n32) );
  INVX1 U83 ( .A(state[0]), .Y(n10) );
  INVX1 U84 ( .A(state[2]), .Y(n24) );
  AND2X1 U85 ( .A(n68), .B(bit_in), .Y(Serial_In) );
  INVX1 U86 ( .A(CRC_Calc), .Y(n68) );
endmodule


module transmitter ( clk, n_rst, send_nak, send_data, FIFO_byte, fifo_r_enable, 
        is_txing, d_plus, d_minus );
  input [7:0] FIFO_byte;
  input clk, n_rst, send_nak, send_data;
  output fifo_r_enable, is_txing, d_plus, d_minus;
  wire   Load_Byte, EOD, load_en, Tim_rst, Tim_en, eop, eop_new_bit, calc_crc,
         send_crc, crc_reset, tim_new_bit, shift_enable, to_encoder, n1;
  wire   [7:0] FSM_byte;
  wire   [1:0] select;
  wire   [15:0] CRC_Bytes;

  txpu Controller ( .clk(clk), .n_rst(n_rst), .Load_Byte(Load_Byte), 
        .send_nak(send_nak), .send_data(send_data), .EOD(EOD), .send_crc(
        send_crc), .tim_new_bit(tim_new_bit), .FSM_byte(FSM_byte), .load_en(
        load_en), .select(select), .Tim_rst(Tim_rst), .Tim_en(Tim_en), .eop(
        eop), .eop_new_bit(eop_new_bit), .fifo_r_enable(fifo_r_enable), 
        .is_txing(is_txing), .calc_crc(calc_crc), .crc_reset(crc_reset) );
  byte_transmitter Pipeline ( .clk(clk), .n_rst(n_rst), .FSM_byte(FSM_byte), 
        .FIFO_byte(FIFO_byte), .CRC_Bytes(CRC_Bytes), .load_en(load_en), 
        .select(select), .idle(n1), .Tim_rst(Tim_rst), .Tim_en(Tim_en), .eop(
        eop), .eop_new_bit(eop_new_bit), .d_plus(d_plus), .d_minus(d_minus), 
        .to_encoder(to_encoder), .Load_Byte(Load_Byte), .EOD(EOD), 
        .shift_enable(shift_enable), .tim_new_bit(tim_new_bit) );
  CRC_Calculator CRC ( .clk(clk), .n_rst(n_rst), .bit_in(shift_enable), 
        .new_bit(to_encoder), .reset(crc_reset), .CRC_Calc(calc_crc), 
        .CRC_Send(send_crc), .CRC_Bytes(CRC_Bytes) );
  INVX1 U1 ( .A(is_txing), .Y(n1) );
endmodule


module rxpu ( clk, n_rst, is_tx_active, is_rcv_empty, is_eop_rcvd, 
        is_data_ready, rcv_bus, read_rcv_fifo, send_data, send_nak );
  input [7:0] rcv_bus;
  input clk, n_rst, is_tx_active, is_rcv_empty, is_eop_rcvd, is_data_ready;
  output read_rcv_fifo, send_data, send_nak;
  wire   n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58;
  wire   [3:0] state;
  wire   [3:0] next_state;

  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[0]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[1]) );
  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[3]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  NOR2X1 U7 ( .A(n5), .B(n6), .Y(send_nak) );
  NAND2X1 U8 ( .A(state[3]), .B(state[1]), .Y(n6) );
  NAND2X1 U9 ( .A(n7), .B(n8), .Y(n5) );
  AND2X1 U10 ( .A(n9), .B(is_data_ready), .Y(send_data) );
  OAI21X1 U11 ( .A(is_rcv_empty), .B(n10), .C(n11), .Y(read_rcv_fifo) );
  NOR2X1 U12 ( .A(n12), .B(n13), .Y(n10) );
  AOI21X1 U13 ( .A(n14), .B(n15), .C(n16), .Y(n13) );
  NAND2X1 U14 ( .A(n17), .B(n18), .Y(next_state[3]) );
  MUX2X1 U15 ( .B(n12), .A(n19), .S(n20), .Y(n18) );
  NOR2X1 U16 ( .A(n15), .B(n16), .Y(n19) );
  AOI22X1 U17 ( .A(n9), .B(n21), .C(n22), .D(n23), .Y(n17) );
  INVX1 U18 ( .A(n24), .Y(n22) );
  OAI21X1 U19 ( .A(is_rcv_empty), .B(n25), .C(n26), .Y(next_state[2]) );
  AOI21X1 U20 ( .A(n12), .B(n20), .C(n27), .Y(n26) );
  NAND2X1 U21 ( .A(n28), .B(n29), .Y(n12) );
  OR2X1 U22 ( .A(n30), .B(n31), .Y(next_state[1]) );
  OAI21X1 U23 ( .A(is_eop_rcvd), .B(n28), .C(n32), .Y(n31) );
  AOI22X1 U24 ( .A(n9), .B(n21), .C(is_rcv_empty), .D(n33), .Y(n32) );
  INVX1 U25 ( .A(is_data_ready), .Y(n21) );
  NOR2X1 U26 ( .A(n34), .B(n15), .Y(n9) );
  INVX1 U27 ( .A(n35), .Y(n28) );
  NAND3X1 U28 ( .A(n11), .B(n36), .C(n29), .Y(n30) );
  INVX1 U29 ( .A(n37), .Y(n29) );
  INVX1 U30 ( .A(n27), .Y(n36) );
  INVX1 U31 ( .A(n38), .Y(n11) );
  OR2X1 U32 ( .A(n39), .B(n40), .Y(next_state[0]) );
  OAI21X1 U33 ( .A(n41), .B(n7), .C(n42), .Y(n40) );
  MUX2X1 U34 ( .B(n35), .A(n37), .S(n20), .Y(n42) );
  INVX1 U35 ( .A(is_eop_rcvd), .Y(n20) );
  NOR2X1 U36 ( .A(n43), .B(n7), .Y(n37) );
  NOR2X1 U37 ( .A(n43), .B(state[0]), .Y(n35) );
  NAND3X1 U38 ( .A(state[1]), .B(n15), .C(state[2]), .Y(n43) );
  NOR2X1 U39 ( .A(n27), .B(n33), .Y(n41) );
  INVX1 U40 ( .A(n25), .Y(n33) );
  NAND3X1 U41 ( .A(n8), .B(n15), .C(state[1]), .Y(n25) );
  NOR2X1 U42 ( .A(n23), .B(n24), .Y(n27) );
  NAND3X1 U43 ( .A(n44), .B(n15), .C(state[2]), .Y(n24) );
  OR2X1 U44 ( .A(n45), .B(n46), .Y(n23) );
  NAND3X1 U45 ( .A(rcv_bus[2]), .B(n47), .C(rcv_bus[3]), .Y(n46) );
  INVX1 U46 ( .A(rcv_bus[0]), .Y(n47) );
  NAND3X1 U47 ( .A(n48), .B(n49), .C(n50), .Y(n45) );
  INVX1 U48 ( .A(rcv_bus[5]), .Y(n49) );
  INVX1 U49 ( .A(rcv_bus[4]), .Y(n48) );
  OAI21X1 U50 ( .A(n51), .B(n52), .C(n53), .Y(n39) );
  OAI21X1 U51 ( .A(n54), .B(n55), .C(n38), .Y(n53) );
  NOR2X1 U52 ( .A(n34), .B(state[3]), .Y(n38) );
  NAND3X1 U53 ( .A(n44), .B(n8), .C(state[0]), .Y(n34) );
  NAND3X1 U54 ( .A(rcv_bus[6]), .B(rcv_bus[5]), .C(n56), .Y(n55) );
  AND2X1 U55 ( .A(rcv_bus[3]), .B(rcv_bus[0]), .Y(n56) );
  NAND3X1 U56 ( .A(n50), .B(n57), .C(n58), .Y(n54) );
  NOR2X1 U57 ( .A(rcv_bus[7]), .B(rcv_bus[4]), .Y(n58) );
  INVX1 U58 ( .A(rcv_bus[2]), .Y(n57) );
  INVX1 U59 ( .A(rcv_bus[1]), .Y(n50) );
  OR2X1 U60 ( .A(n16), .B(is_rcv_empty), .Y(n52) );
  NAND3X1 U61 ( .A(n44), .B(n8), .C(n7), .Y(n16) );
  INVX1 U62 ( .A(state[0]), .Y(n7) );
  INVX1 U63 ( .A(state[2]), .Y(n8) );
  INVX1 U64 ( .A(state[1]), .Y(n44) );
  NAND2X1 U65 ( .A(n14), .B(n15), .Y(n51) );
  INVX1 U66 ( .A(state[3]), .Y(n15) );
  INVX1 U67 ( .A(is_tx_active), .Y(n14) );
endmodule


module sync_1 ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   intermediate;

  DFFSR intermediate_reg ( .D(async_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        intermediate) );
  DFFSR sync_out_reg ( .D(intermediate), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        sync_out) );
endmodule


module sync_0 ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   intermediate;

  DFFSR intermediate_reg ( .D(async_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        intermediate) );
  DFFSR sync_out_reg ( .D(intermediate), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        sync_out) );
endmodule


module eop_detect ( d_plus, d_minus, eop );
  input d_plus, d_minus;
  output eop;


  NOR2X1 U1 ( .A(d_plus), .B(d_minus), .Y(eop) );
endmodule


module decode ( clk, n_rst, d_plus, shift_enable, eop, d_orig );
  input clk, n_rst, d_plus, shift_enable, eop;
  output d_orig;
  wire   d_plus_sync, internal, next_d_orig, n7, n4, n5, n6, n8;

  DFFSR d_plus_sync_reg ( .D(d_plus), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        d_plus_sync) );
  DFFSR internal_reg ( .D(n7), .CLK(clk), .R(1'b1), .S(n_rst), .Q(internal) );
  DFFSR d_orig_reg ( .D(next_d_orig), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        d_orig) );
  NOR2X1 U6 ( .A(n4), .B(n5), .Y(next_d_orig) );
  XOR2X1 U7 ( .A(internal), .B(d_plus_sync), .Y(n5) );
  INVX1 U8 ( .A(n6), .Y(n4) );
  NAND2X1 U9 ( .A(n8), .B(n6), .Y(n7) );
  NAND2X1 U10 ( .A(shift_enable), .B(eop), .Y(n6) );
  MUX2X1 U11 ( .B(internal), .A(d_plus_sync), .S(shift_enable), .Y(n8) );
endmodule


module edge_detect ( clk, n_rst, d_plus, d_edge );
  input clk, n_rst, d_plus;
  output d_edge;
  wire   d_plus_sync, d_plus_sync_prev;

  DFFSR d_plus_sync_reg ( .D(d_plus), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        d_plus_sync) );
  DFFSR d_plus_sync_prev_reg ( .D(d_plus_sync), .CLK(clk), .R(1'b1), .S(n_rst), 
        .Q(d_plus_sync_prev) );
  XOR2X1 U5 ( .A(d_plus_sync_prev), .B(d_plus_sync), .Y(d_edge) );
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


module timer ( clk, n_rst, d_edge, rcving, shift_enable, byte_received );
  input clk, n_rst, d_edge, rcving;
  output shift_enable, byte_received;
  wire   _0_net_, _2_net_, n1, n2, n3;
  wire   [3:0] sampling_count;

  flex_counter_NUM_CNT_BITS4_1 samplingTimer ( .clk(clk), .n_rst(n_rst), 
        .clear(_0_net_), .count_enable(rcving), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0}), .count_out(sampling_count) );
  flex_counter_NUM_CNT_BITS4_0 sampleCount ( .clk(clk), .n_rst(n_rst), .clear(
        _2_net_), .count_enable(shift_enable), .rollover_val({1'b1, 1'b0, 1'b0, 
        1'b0}), .rollover_flag(byte_received) );
  INVX2 U3 ( .A(n1), .Y(shift_enable) );
  NAND3X1 U4 ( .A(sampling_count[1]), .B(sampling_count[0]), .C(n2), .Y(n1) );
  NOR2X1 U5 ( .A(sampling_count[3]), .B(sampling_count[2]), .Y(n2) );
  OR2X1 U6 ( .A(byte_received), .B(n3), .Y(_2_net_) );
  OR2X1 U7 ( .A(d_edge), .B(n3), .Y(_0_net_) );
  INVX1 U8 ( .A(rcving), .Y(n3) );
endmodule


module flex_stp_sr_NUM_BITS8_SHIFT_MSB0 ( clk, n_rst, shift_enable, serial_in, 
        parallel_out );
  output [7:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n12, n14, n16, n18, n20, n22, n24, n26, n1, n2, n3, n4, n5, n6, n7,
         n8;

  DFFSR \parallel_out_reg[7]  ( .D(n26), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \parallel_out_reg[6]  ( .D(n24), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[5]  ( .D(n22), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[4]  ( .D(n20), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[3]  ( .D(n18), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[2]  ( .D(n16), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[1]  ( .D(n14), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[0]  ( .D(n12), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  INVX1 U2 ( .A(n1), .Y(n26) );
  MUX2X1 U3 ( .B(parallel_out[7]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n24) );
  MUX2X1 U5 ( .B(parallel_out[6]), .A(parallel_out[7]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n22) );
  MUX2X1 U7 ( .B(parallel_out[5]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n20) );
  MUX2X1 U9 ( .B(parallel_out[4]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n18) );
  MUX2X1 U11 ( .B(parallel_out[3]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n16) );
  MUX2X1 U13 ( .B(parallel_out[2]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n14) );
  MUX2X1 U15 ( .B(parallel_out[1]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n12) );
  MUX2X1 U17 ( .B(parallel_out[0]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n8) );
endmodule


module shift_register ( clk, n_rst, shift_enable, d_orig, rcv_data );
  output [7:0] rcv_data;
  input clk, n_rst, shift_enable, d_orig;


  flex_stp_sr_NUM_BITS8_SHIFT_MSB0 shiftreg ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_enable), .serial_in(d_orig), .parallel_out(
        rcv_data) );
endmodule


module rcu ( clk, n_rst, d_edge, eop, shift_enable, rcv_data, byte_received, 
        rcving, w_enable, r_error );
  input [7:0] rcv_data;
  input clk, n_rst, d_edge, eop, shift_enable, byte_received;
  output rcving, w_enable, r_error;
  wire   n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66;
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
  OAI21X1 U7 ( .A(state[3]), .B(n5), .C(n6), .Y(rcving) );
  AOI21X1 U8 ( .A(n7), .B(n8), .C(n9), .Y(n6) );
  NAND3X1 U9 ( .A(n10), .B(n11), .C(n12), .Y(r_error) );
  OR2X1 U10 ( .A(n13), .B(n14), .Y(nextstate[3]) );
  OAI21X1 U11 ( .A(n15), .B(n16), .C(n17), .Y(n14) );
  OAI21X1 U12 ( .A(eop), .B(n18), .C(n19), .Y(n17) );
  NAND3X1 U13 ( .A(n20), .B(n21), .C(n22), .Y(n13) );
  OR2X1 U14 ( .A(n23), .B(n24), .Y(nextstate[2]) );
  OAI21X1 U15 ( .A(d_edge), .B(n25), .C(n26), .Y(n24) );
  INVX1 U16 ( .A(n27), .Y(n26) );
  OAI22X1 U17 ( .A(n12), .B(n28), .C(n15), .D(byte_received), .Y(n27) );
  OAI21X1 U18 ( .A(n29), .B(n30), .C(n31), .Y(n23) );
  NOR2X1 U19 ( .A(n9), .B(n32), .Y(n31) );
  INVX1 U20 ( .A(n11), .Y(n9) );
  NAND3X1 U21 ( .A(rcv_data[7]), .B(n33), .C(n34), .Y(n30) );
  NOR2X1 U22 ( .A(rcv_data[1]), .B(rcv_data[0]), .Y(n34) );
  INVX1 U23 ( .A(n35), .Y(n33) );
  NAND3X1 U24 ( .A(n36), .B(n37), .C(n38), .Y(n29) );
  NOR2X1 U25 ( .A(rcv_data[3]), .B(rcv_data[2]), .Y(n38) );
  INVX1 U26 ( .A(rcv_data[4]), .Y(n37) );
  NOR2X1 U27 ( .A(rcv_data[6]), .B(rcv_data[5]), .Y(n36) );
  OR2X1 U28 ( .A(n39), .B(n40), .Y(nextstate[1]) );
  OAI21X1 U29 ( .A(d_edge), .B(n25), .C(n41), .Y(n40) );
  INVX1 U30 ( .A(n42), .Y(n41) );
  INVX1 U31 ( .A(n43), .Y(n25) );
  OAI21X1 U32 ( .A(n44), .B(n28), .C(n45), .Y(n39) );
  AOI21X1 U33 ( .A(n46), .B(n47), .C(n48), .Y(n45) );
  INVX1 U34 ( .A(n22), .Y(n48) );
  MUX2X1 U35 ( .B(n16), .A(n18), .S(state[2]), .Y(n47) );
  NOR2X1 U36 ( .A(n7), .B(n5), .Y(n46) );
  NAND3X1 U37 ( .A(n49), .B(n50), .C(n51), .Y(nextstate[0]) );
  AOI21X1 U38 ( .A(n52), .B(n8), .C(n53), .Y(n51) );
  OAI21X1 U39 ( .A(n11), .B(n54), .C(n20), .Y(n53) );
  NAND2X1 U40 ( .A(state[0]), .B(n18), .Y(n54) );
  MUX2X1 U41 ( .B(n55), .A(n56), .S(state[0]), .Y(n52) );
  NAND2X1 U42 ( .A(n57), .B(n16), .Y(n56) );
  INVX1 U43 ( .A(byte_received), .Y(n16) );
  NAND2X1 U44 ( .A(d_edge), .B(n58), .Y(n55) );
  MUX2X1 U45 ( .B(n59), .A(n19), .S(n28), .Y(n50) );
  INVX1 U46 ( .A(n44), .Y(n19) );
  OAI21X1 U47 ( .A(state[0]), .B(n11), .C(n22), .Y(n59) );
  NAND3X1 U48 ( .A(state[1]), .B(n5), .C(n60), .Y(n22) );
  NAND2X1 U49 ( .A(state[2]), .B(n57), .Y(n11) );
  INVX1 U50 ( .A(n7), .Y(n57) );
  NAND2X1 U51 ( .A(n58), .B(n61), .Y(n7) );
  AOI21X1 U52 ( .A(d_edge), .B(n43), .C(n42), .Y(n49) );
  NAND3X1 U53 ( .A(n21), .B(n35), .C(n62), .Y(n42) );
  AOI21X1 U54 ( .A(n63), .B(n28), .C(n32), .Y(n62) );
  NOR3X1 U55 ( .A(n18), .B(eop), .C(n44), .Y(n32) );
  NAND3X1 U56 ( .A(state[0]), .B(n58), .C(n60), .Y(n44) );
  INVX1 U57 ( .A(shift_enable), .Y(n18) );
  NAND2X1 U58 ( .A(eop), .B(shift_enable), .Y(n28) );
  OAI21X1 U59 ( .A(byte_received), .B(n15), .C(n12), .Y(n63) );
  OR2X1 U60 ( .A(n64), .B(state[2]), .Y(n12) );
  OR2X1 U61 ( .A(n64), .B(n8), .Y(n15) );
  NAND3X1 U62 ( .A(state[0]), .B(n61), .C(state[1]), .Y(n64) );
  NAND3X1 U63 ( .A(n8), .B(n61), .C(n65), .Y(n35) );
  NOR2X1 U64 ( .A(state[0]), .B(n58), .Y(n65) );
  INVX1 U65 ( .A(state[2]), .Y(n8) );
  NAND3X1 U66 ( .A(n60), .B(state[1]), .C(n66), .Y(n21) );
  NOR2X1 U67 ( .A(shift_enable), .B(n5), .Y(n66) );
  NOR2X1 U68 ( .A(n10), .B(n58), .Y(n43) );
  NAND3X1 U69 ( .A(n5), .B(n61), .C(state[2]), .Y(n10) );
  INVX1 U70 ( .A(n20), .Y(w_enable) );
  NAND3X1 U71 ( .A(n5), .B(n58), .C(n60), .Y(n20) );
  NOR2X1 U72 ( .A(n61), .B(state[2]), .Y(n60) );
  INVX1 U73 ( .A(state[3]), .Y(n61) );
  INVX1 U74 ( .A(state[1]), .Y(n58) );
  INVX1 U75 ( .A(state[0]), .Y(n5) );
endmodule


module fiforam ( wclk, wenable, waddr, raddr, wdata, rdata );
  input [2:0] waddr;
  input [2:0] raddr;
  input [7:0] wdata;
  output [7:0] rdata;
  input wclk, wenable;
  wire   N10, N11, N12, N13, N14, N15, \fiforeg[0][7] , \fiforeg[0][6] ,
         \fiforeg[0][5] , \fiforeg[0][4] , \fiforeg[0][3] , \fiforeg[0][2] ,
         \fiforeg[0][1] , \fiforeg[0][0] , \fiforeg[1][7] , \fiforeg[1][6] ,
         \fiforeg[1][5] , \fiforeg[1][4] , \fiforeg[1][3] , \fiforeg[1][2] ,
         \fiforeg[1][1] , \fiforeg[1][0] , \fiforeg[2][7] , \fiforeg[2][6] ,
         \fiforeg[2][5] , \fiforeg[2][4] , \fiforeg[2][3] , \fiforeg[2][2] ,
         \fiforeg[2][1] , \fiforeg[2][0] , \fiforeg[3][7] , \fiforeg[3][6] ,
         \fiforeg[3][5] , \fiforeg[3][4] , \fiforeg[3][3] , \fiforeg[3][2] ,
         \fiforeg[3][1] , \fiforeg[3][0] , \fiforeg[4][7] , \fiforeg[4][6] ,
         \fiforeg[4][5] , \fiforeg[4][4] , \fiforeg[4][3] , \fiforeg[4][2] ,
         \fiforeg[4][1] , \fiforeg[4][0] , \fiforeg[5][7] , \fiforeg[5][6] ,
         \fiforeg[5][5] , \fiforeg[5][4] , \fiforeg[5][3] , \fiforeg[5][2] ,
         \fiforeg[5][1] , \fiforeg[5][0] , \fiforeg[6][7] , \fiforeg[6][6] ,
         \fiforeg[6][5] , \fiforeg[6][4] , \fiforeg[6][3] , \fiforeg[6][2] ,
         \fiforeg[6][1] , \fiforeg[6][0] , \fiforeg[7][7] , \fiforeg[7][6] ,
         \fiforeg[7][5] , \fiforeg[7][4] , \fiforeg[7][3] , \fiforeg[7][2] ,
         \fiforeg[7][1] , \fiforeg[7][0] , N17, N18, N19, N20, N21, N22, N23,
         N24, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n153,
         n154, n155, n156, n157, n158, n159, n160, n161, n162, n163, n164,
         n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n175,
         n176, n177, n178, n179, n180, n181, n182, n183, n184, n185, n186,
         n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, n197,
         n198, n199, n200, n201, n202, n203, n204, n205, n206, n207, n208,
         n209, n210, n211, n212, n213, n214, n215, n216, n217, n218, n219,
         n220, n221, n222, n223, n224, n225, n226, n227, n228, n229, n230,
         n231, n232, n233, n234, n235, n236, n237, n238, n239, n240, n241,
         n242, n243, n244, n245, n246, n247, n248, n249, n250, n251, n252,
         n253, n254, n255, n256, n257, n258, n259, n260, n261, n262;
  assign N10 = raddr[0];
  assign N11 = raddr[1];
  assign N12 = raddr[2];
  assign N13 = waddr[0];
  assign N14 = waddr[1];
  assign N15 = waddr[2];

  DFFPOSX1 \fiforeg_reg[0][7]  ( .D(n152), .CLK(wclk), .Q(\fiforeg[0][7] ) );
  DFFPOSX1 \fiforeg_reg[0][6]  ( .D(n151), .CLK(wclk), .Q(\fiforeg[0][6] ) );
  DFFPOSX1 \fiforeg_reg[0][5]  ( .D(n150), .CLK(wclk), .Q(\fiforeg[0][5] ) );
  DFFPOSX1 \fiforeg_reg[0][4]  ( .D(n149), .CLK(wclk), .Q(\fiforeg[0][4] ) );
  DFFPOSX1 \fiforeg_reg[0][3]  ( .D(n148), .CLK(wclk), .Q(\fiforeg[0][3] ) );
  DFFPOSX1 \fiforeg_reg[0][2]  ( .D(n147), .CLK(wclk), .Q(\fiforeg[0][2] ) );
  DFFPOSX1 \fiforeg_reg[0][1]  ( .D(n146), .CLK(wclk), .Q(\fiforeg[0][1] ) );
  DFFPOSX1 \fiforeg_reg[0][0]  ( .D(n145), .CLK(wclk), .Q(\fiforeg[0][0] ) );
  DFFPOSX1 \fiforeg_reg[1][7]  ( .D(n144), .CLK(wclk), .Q(\fiforeg[1][7] ) );
  DFFPOSX1 \fiforeg_reg[1][6]  ( .D(n143), .CLK(wclk), .Q(\fiforeg[1][6] ) );
  DFFPOSX1 \fiforeg_reg[1][5]  ( .D(n142), .CLK(wclk), .Q(\fiforeg[1][5] ) );
  DFFPOSX1 \fiforeg_reg[1][4]  ( .D(n141), .CLK(wclk), .Q(\fiforeg[1][4] ) );
  DFFPOSX1 \fiforeg_reg[1][3]  ( .D(n140), .CLK(wclk), .Q(\fiforeg[1][3] ) );
  DFFPOSX1 \fiforeg_reg[1][2]  ( .D(n139), .CLK(wclk), .Q(\fiforeg[1][2] ) );
  DFFPOSX1 \fiforeg_reg[1][1]  ( .D(n138), .CLK(wclk), .Q(\fiforeg[1][1] ) );
  DFFPOSX1 \fiforeg_reg[1][0]  ( .D(n137), .CLK(wclk), .Q(\fiforeg[1][0] ) );
  DFFPOSX1 \fiforeg_reg[2][7]  ( .D(n136), .CLK(wclk), .Q(\fiforeg[2][7] ) );
  DFFPOSX1 \fiforeg_reg[2][6]  ( .D(n135), .CLK(wclk), .Q(\fiforeg[2][6] ) );
  DFFPOSX1 \fiforeg_reg[2][5]  ( .D(n134), .CLK(wclk), .Q(\fiforeg[2][5] ) );
  DFFPOSX1 \fiforeg_reg[2][4]  ( .D(n133), .CLK(wclk), .Q(\fiforeg[2][4] ) );
  DFFPOSX1 \fiforeg_reg[2][3]  ( .D(n132), .CLK(wclk), .Q(\fiforeg[2][3] ) );
  DFFPOSX1 \fiforeg_reg[2][2]  ( .D(n131), .CLK(wclk), .Q(\fiforeg[2][2] ) );
  DFFPOSX1 \fiforeg_reg[2][1]  ( .D(n130), .CLK(wclk), .Q(\fiforeg[2][1] ) );
  DFFPOSX1 \fiforeg_reg[2][0]  ( .D(n129), .CLK(wclk), .Q(\fiforeg[2][0] ) );
  DFFPOSX1 \fiforeg_reg[3][7]  ( .D(n128), .CLK(wclk), .Q(\fiforeg[3][7] ) );
  DFFPOSX1 \fiforeg_reg[3][6]  ( .D(n127), .CLK(wclk), .Q(\fiforeg[3][6] ) );
  DFFPOSX1 \fiforeg_reg[3][5]  ( .D(n126), .CLK(wclk), .Q(\fiforeg[3][5] ) );
  DFFPOSX1 \fiforeg_reg[3][4]  ( .D(n125), .CLK(wclk), .Q(\fiforeg[3][4] ) );
  DFFPOSX1 \fiforeg_reg[3][3]  ( .D(n124), .CLK(wclk), .Q(\fiforeg[3][3] ) );
  DFFPOSX1 \fiforeg_reg[3][2]  ( .D(n123), .CLK(wclk), .Q(\fiforeg[3][2] ) );
  DFFPOSX1 \fiforeg_reg[3][1]  ( .D(n122), .CLK(wclk), .Q(\fiforeg[3][1] ) );
  DFFPOSX1 \fiforeg_reg[3][0]  ( .D(n121), .CLK(wclk), .Q(\fiforeg[3][0] ) );
  DFFPOSX1 \fiforeg_reg[4][7]  ( .D(n120), .CLK(wclk), .Q(\fiforeg[4][7] ) );
  DFFPOSX1 \fiforeg_reg[4][6]  ( .D(n119), .CLK(wclk), .Q(\fiforeg[4][6] ) );
  DFFPOSX1 \fiforeg_reg[4][5]  ( .D(n118), .CLK(wclk), .Q(\fiforeg[4][5] ) );
  DFFPOSX1 \fiforeg_reg[4][4]  ( .D(n117), .CLK(wclk), .Q(\fiforeg[4][4] ) );
  DFFPOSX1 \fiforeg_reg[4][3]  ( .D(n116), .CLK(wclk), .Q(\fiforeg[4][3] ) );
  DFFPOSX1 \fiforeg_reg[4][2]  ( .D(n115), .CLK(wclk), .Q(\fiforeg[4][2] ) );
  DFFPOSX1 \fiforeg_reg[4][1]  ( .D(n114), .CLK(wclk), .Q(\fiforeg[4][1] ) );
  DFFPOSX1 \fiforeg_reg[4][0]  ( .D(n113), .CLK(wclk), .Q(\fiforeg[4][0] ) );
  DFFPOSX1 \fiforeg_reg[5][7]  ( .D(n112), .CLK(wclk), .Q(\fiforeg[5][7] ) );
  DFFPOSX1 \fiforeg_reg[5][6]  ( .D(n111), .CLK(wclk), .Q(\fiforeg[5][6] ) );
  DFFPOSX1 \fiforeg_reg[5][5]  ( .D(n110), .CLK(wclk), .Q(\fiforeg[5][5] ) );
  DFFPOSX1 \fiforeg_reg[5][4]  ( .D(n109), .CLK(wclk), .Q(\fiforeg[5][4] ) );
  DFFPOSX1 \fiforeg_reg[5][3]  ( .D(n108), .CLK(wclk), .Q(\fiforeg[5][3] ) );
  DFFPOSX1 \fiforeg_reg[5][2]  ( .D(n107), .CLK(wclk), .Q(\fiforeg[5][2] ) );
  DFFPOSX1 \fiforeg_reg[5][1]  ( .D(n106), .CLK(wclk), .Q(\fiforeg[5][1] ) );
  DFFPOSX1 \fiforeg_reg[5][0]  ( .D(n105), .CLK(wclk), .Q(\fiforeg[5][0] ) );
  DFFPOSX1 \fiforeg_reg[6][7]  ( .D(n104), .CLK(wclk), .Q(\fiforeg[6][7] ) );
  DFFPOSX1 \fiforeg_reg[6][6]  ( .D(n103), .CLK(wclk), .Q(\fiforeg[6][6] ) );
  DFFPOSX1 \fiforeg_reg[6][5]  ( .D(n102), .CLK(wclk), .Q(\fiforeg[6][5] ) );
  DFFPOSX1 \fiforeg_reg[6][4]  ( .D(n101), .CLK(wclk), .Q(\fiforeg[6][4] ) );
  DFFPOSX1 \fiforeg_reg[6][3]  ( .D(n100), .CLK(wclk), .Q(\fiforeg[6][3] ) );
  DFFPOSX1 \fiforeg_reg[6][2]  ( .D(n99), .CLK(wclk), .Q(\fiforeg[6][2] ) );
  DFFPOSX1 \fiforeg_reg[6][1]  ( .D(n98), .CLK(wclk), .Q(\fiforeg[6][1] ) );
  DFFPOSX1 \fiforeg_reg[6][0]  ( .D(n97), .CLK(wclk), .Q(\fiforeg[6][0] ) );
  DFFPOSX1 \fiforeg_reg[7][7]  ( .D(n96), .CLK(wclk), .Q(\fiforeg[7][7] ) );
  DFFPOSX1 \fiforeg_reg[7][6]  ( .D(n95), .CLK(wclk), .Q(\fiforeg[7][6] ) );
  DFFPOSX1 \fiforeg_reg[7][5]  ( .D(n94), .CLK(wclk), .Q(\fiforeg[7][5] ) );
  DFFPOSX1 \fiforeg_reg[7][4]  ( .D(n93), .CLK(wclk), .Q(\fiforeg[7][4] ) );
  DFFPOSX1 \fiforeg_reg[7][3]  ( .D(n92), .CLK(wclk), .Q(\fiforeg[7][3] ) );
  DFFPOSX1 \fiforeg_reg[7][2]  ( .D(n91), .CLK(wclk), .Q(\fiforeg[7][2] ) );
  DFFPOSX1 \fiforeg_reg[7][1]  ( .D(n90), .CLK(wclk), .Q(\fiforeg[7][1] ) );
  DFFPOSX1 \fiforeg_reg[7][0]  ( .D(n89), .CLK(wclk), .Q(\fiforeg[7][0] ) );
  BUFX2 U2 ( .A(n54), .Y(n1) );
  BUFX2 U3 ( .A(n56), .Y(n2) );
  BUFX2 U4 ( .A(n175), .Y(n3) );
  BUFX2 U5 ( .A(n172), .Y(n4) );
  BUFX2 U6 ( .A(n53), .Y(n5) );
  BUFX2 U7 ( .A(n173), .Y(n6) );
  BUFX2 U8 ( .A(n174), .Y(n7) );
  BUFX2 U9 ( .A(n55), .Y(n8) );
  NOR2X1 U10 ( .A(n63), .B(N11), .Y(n54) );
  NOR2X1 U11 ( .A(n63), .B(n62), .Y(n53) );
  AOI22X1 U12 ( .A(\fiforeg[4][0] ), .B(n1), .C(\fiforeg[6][0] ), .D(n5), .Y(
        n10) );
  NOR2X1 U13 ( .A(N11), .B(N12), .Y(n56) );
  NOR2X1 U14 ( .A(n62), .B(N12), .Y(n55) );
  AOI22X1 U15 ( .A(\fiforeg[0][0] ), .B(n2), .C(\fiforeg[2][0] ), .D(n8), .Y(
        n9) );
  AOI21X1 U16 ( .A(n10), .B(n9), .C(N10), .Y(n14) );
  AOI22X1 U17 ( .A(\fiforeg[5][0] ), .B(n1), .C(\fiforeg[7][0] ), .D(n5), .Y(
        n12) );
  AOI22X1 U18 ( .A(\fiforeg[1][0] ), .B(n2), .C(\fiforeg[3][0] ), .D(n8), .Y(
        n11) );
  AOI21X1 U19 ( .A(n12), .B(n11), .C(n61), .Y(n13) );
  OR2X1 U20 ( .A(n14), .B(n13), .Y(rdata[0]) );
  AOI22X1 U21 ( .A(\fiforeg[4][1] ), .B(n1), .C(\fiforeg[6][1] ), .D(n5), .Y(
        n16) );
  AOI22X1 U22 ( .A(\fiforeg[0][1] ), .B(n2), .C(\fiforeg[2][1] ), .D(n8), .Y(
        n15) );
  AOI21X1 U23 ( .A(n16), .B(n15), .C(N10), .Y(n20) );
  AOI22X1 U24 ( .A(\fiforeg[5][1] ), .B(n1), .C(\fiforeg[7][1] ), .D(n5), .Y(
        n18) );
  AOI22X1 U25 ( .A(\fiforeg[1][1] ), .B(n2), .C(\fiforeg[3][1] ), .D(n8), .Y(
        n17) );
  AOI21X1 U26 ( .A(n18), .B(n17), .C(n61), .Y(n19) );
  OR2X1 U27 ( .A(n20), .B(n19), .Y(rdata[1]) );
  AOI22X1 U28 ( .A(\fiforeg[4][2] ), .B(n1), .C(\fiforeg[6][2] ), .D(n5), .Y(
        n22) );
  AOI22X1 U29 ( .A(\fiforeg[0][2] ), .B(n2), .C(\fiforeg[2][2] ), .D(n8), .Y(
        n21) );
  AOI21X1 U30 ( .A(n22), .B(n21), .C(N10), .Y(n26) );
  AOI22X1 U31 ( .A(\fiforeg[5][2] ), .B(n1), .C(\fiforeg[7][2] ), .D(n5), .Y(
        n24) );
  AOI22X1 U32 ( .A(\fiforeg[1][2] ), .B(n2), .C(\fiforeg[3][2] ), .D(n8), .Y(
        n23) );
  AOI21X1 U33 ( .A(n24), .B(n23), .C(n61), .Y(n25) );
  OR2X1 U34 ( .A(n26), .B(n25), .Y(rdata[2]) );
  AOI22X1 U35 ( .A(\fiforeg[4][3] ), .B(n1), .C(\fiforeg[6][3] ), .D(n5), .Y(
        n28) );
  AOI22X1 U36 ( .A(\fiforeg[0][3] ), .B(n2), .C(\fiforeg[2][3] ), .D(n8), .Y(
        n27) );
  AOI21X1 U37 ( .A(n28), .B(n27), .C(N10), .Y(n32) );
  AOI22X1 U38 ( .A(\fiforeg[5][3] ), .B(n1), .C(\fiforeg[7][3] ), .D(n5), .Y(
        n30) );
  AOI22X1 U39 ( .A(\fiforeg[1][3] ), .B(n2), .C(\fiforeg[3][3] ), .D(n8), .Y(
        n29) );
  AOI21X1 U40 ( .A(n30), .B(n29), .C(n61), .Y(n31) );
  OR2X1 U41 ( .A(n32), .B(n31), .Y(rdata[3]) );
  AOI22X1 U42 ( .A(\fiforeg[4][4] ), .B(n1), .C(\fiforeg[6][4] ), .D(n5), .Y(
        n34) );
  AOI22X1 U43 ( .A(\fiforeg[0][4] ), .B(n2), .C(\fiforeg[2][4] ), .D(n8), .Y(
        n33) );
  AOI21X1 U44 ( .A(n34), .B(n33), .C(N10), .Y(n38) );
  AOI22X1 U45 ( .A(\fiforeg[5][4] ), .B(n1), .C(\fiforeg[7][4] ), .D(n5), .Y(
        n36) );
  AOI22X1 U46 ( .A(\fiforeg[1][4] ), .B(n2), .C(\fiforeg[3][4] ), .D(n8), .Y(
        n35) );
  AOI21X1 U47 ( .A(n36), .B(n35), .C(n61), .Y(n37) );
  OR2X1 U48 ( .A(n38), .B(n37), .Y(rdata[4]) );
  AOI22X1 U49 ( .A(\fiforeg[4][5] ), .B(n1), .C(\fiforeg[6][5] ), .D(n5), .Y(
        n40) );
  AOI22X1 U50 ( .A(\fiforeg[0][5] ), .B(n2), .C(\fiforeg[2][5] ), .D(n8), .Y(
        n39) );
  AOI21X1 U51 ( .A(n40), .B(n39), .C(N10), .Y(n44) );
  AOI22X1 U52 ( .A(\fiforeg[5][5] ), .B(n1), .C(\fiforeg[7][5] ), .D(n5), .Y(
        n42) );
  AOI22X1 U53 ( .A(\fiforeg[1][5] ), .B(n2), .C(\fiforeg[3][5] ), .D(n8), .Y(
        n41) );
  AOI21X1 U54 ( .A(n42), .B(n41), .C(n61), .Y(n43) );
  OR2X1 U55 ( .A(n44), .B(n43), .Y(rdata[5]) );
  AOI22X1 U56 ( .A(\fiforeg[4][6] ), .B(n1), .C(\fiforeg[6][6] ), .D(n5), .Y(
        n46) );
  AOI22X1 U57 ( .A(\fiforeg[0][6] ), .B(n2), .C(\fiforeg[2][6] ), .D(n8), .Y(
        n45) );
  AOI21X1 U58 ( .A(n46), .B(n45), .C(N10), .Y(n50) );
  AOI22X1 U59 ( .A(\fiforeg[5][6] ), .B(n1), .C(\fiforeg[7][6] ), .D(n5), .Y(
        n48) );
  AOI22X1 U60 ( .A(\fiforeg[1][6] ), .B(n2), .C(\fiforeg[3][6] ), .D(n8), .Y(
        n47) );
  AOI21X1 U61 ( .A(n48), .B(n47), .C(n61), .Y(n49) );
  OR2X1 U62 ( .A(n50), .B(n49), .Y(rdata[6]) );
  AOI22X1 U63 ( .A(\fiforeg[4][7] ), .B(n1), .C(\fiforeg[6][7] ), .D(n5), .Y(
        n52) );
  AOI22X1 U64 ( .A(\fiforeg[0][7] ), .B(n2), .C(\fiforeg[2][7] ), .D(n8), .Y(
        n51) );
  AOI21X1 U65 ( .A(n52), .B(n51), .C(N10), .Y(n60) );
  AOI22X1 U66 ( .A(\fiforeg[5][7] ), .B(n1), .C(\fiforeg[7][7] ), .D(n5), .Y(
        n58) );
  AOI22X1 U67 ( .A(\fiforeg[1][7] ), .B(n2), .C(\fiforeg[3][7] ), .D(n8), .Y(
        n57) );
  AOI21X1 U68 ( .A(n58), .B(n57), .C(n61), .Y(n59) );
  OR2X1 U69 ( .A(n60), .B(n59), .Y(rdata[7]) );
  INVX2 U70 ( .A(N10), .Y(n61) );
  INVX2 U71 ( .A(N11), .Y(n62) );
  INVX2 U72 ( .A(N12), .Y(n63) );
  NOR2X1 U73 ( .A(n211), .B(N14), .Y(n173) );
  NOR2X1 U74 ( .A(n211), .B(n180), .Y(n172) );
  AOI22X1 U75 ( .A(\fiforeg[4][0] ), .B(n6), .C(\fiforeg[6][0] ), .D(n4), .Y(
        n65) );
  NOR2X1 U76 ( .A(N14), .B(N15), .Y(n175) );
  NOR2X1 U77 ( .A(n180), .B(N15), .Y(n174) );
  AOI22X1 U78 ( .A(\fiforeg[0][0] ), .B(n3), .C(\fiforeg[2][0] ), .D(n7), .Y(
        n64) );
  AOI21X1 U79 ( .A(n65), .B(n64), .C(N13), .Y(n69) );
  AOI22X1 U80 ( .A(\fiforeg[5][0] ), .B(n6), .C(\fiforeg[7][0] ), .D(n4), .Y(
        n67) );
  AOI22X1 U81 ( .A(\fiforeg[1][0] ), .B(n3), .C(\fiforeg[3][0] ), .D(n7), .Y(
        n66) );
  AOI21X1 U82 ( .A(n67), .B(n66), .C(n212), .Y(n68) );
  OR2X1 U83 ( .A(n69), .B(n68), .Y(N24) );
  AOI22X1 U84 ( .A(\fiforeg[4][1] ), .B(n6), .C(\fiforeg[6][1] ), .D(n4), .Y(
        n71) );
  AOI22X1 U85 ( .A(\fiforeg[0][1] ), .B(n3), .C(\fiforeg[2][1] ), .D(n7), .Y(
        n70) );
  AOI21X1 U86 ( .A(n71), .B(n70), .C(N13), .Y(n75) );
  AOI22X1 U87 ( .A(\fiforeg[5][1] ), .B(n6), .C(\fiforeg[7][1] ), .D(n4), .Y(
        n73) );
  AOI22X1 U88 ( .A(\fiforeg[1][1] ), .B(n3), .C(\fiforeg[3][1] ), .D(n7), .Y(
        n72) );
  AOI21X1 U89 ( .A(n73), .B(n72), .C(n212), .Y(n74) );
  OR2X1 U90 ( .A(n75), .B(n74), .Y(N23) );
  AOI22X1 U91 ( .A(\fiforeg[4][2] ), .B(n6), .C(\fiforeg[6][2] ), .D(n4), .Y(
        n77) );
  AOI22X1 U92 ( .A(\fiforeg[0][2] ), .B(n3), .C(\fiforeg[2][2] ), .D(n7), .Y(
        n76) );
  AOI21X1 U93 ( .A(n77), .B(n76), .C(N13), .Y(n81) );
  AOI22X1 U94 ( .A(\fiforeg[5][2] ), .B(n6), .C(\fiforeg[7][2] ), .D(n4), .Y(
        n79) );
  AOI22X1 U95 ( .A(\fiforeg[1][2] ), .B(n3), .C(\fiforeg[3][2] ), .D(n7), .Y(
        n78) );
  AOI21X1 U96 ( .A(n79), .B(n78), .C(n212), .Y(n80) );
  OR2X1 U97 ( .A(n81), .B(n80), .Y(N22) );
  AOI22X1 U98 ( .A(\fiforeg[4][3] ), .B(n6), .C(\fiforeg[6][3] ), .D(n4), .Y(
        n83) );
  AOI22X1 U99 ( .A(\fiforeg[0][3] ), .B(n3), .C(\fiforeg[2][3] ), .D(n7), .Y(
        n82) );
  AOI21X1 U100 ( .A(n83), .B(n82), .C(N13), .Y(n87) );
  AOI22X1 U101 ( .A(\fiforeg[5][3] ), .B(n6), .C(\fiforeg[7][3] ), .D(n4), .Y(
        n85) );
  AOI22X1 U102 ( .A(\fiforeg[1][3] ), .B(n3), .C(\fiforeg[3][3] ), .D(n7), .Y(
        n84) );
  AOI21X1 U103 ( .A(n85), .B(n84), .C(n212), .Y(n86) );
  OR2X1 U104 ( .A(n87), .B(n86), .Y(N21) );
  AOI22X1 U105 ( .A(\fiforeg[4][4] ), .B(n6), .C(\fiforeg[6][4] ), .D(n4), .Y(
        n153) );
  AOI22X1 U106 ( .A(\fiforeg[0][4] ), .B(n3), .C(\fiforeg[2][4] ), .D(n7), .Y(
        n88) );
  AOI21X1 U107 ( .A(n153), .B(n88), .C(N13), .Y(n157) );
  AOI22X1 U108 ( .A(\fiforeg[5][4] ), .B(n6), .C(\fiforeg[7][4] ), .D(n4), .Y(
        n155) );
  AOI22X1 U109 ( .A(\fiforeg[1][4] ), .B(n3), .C(\fiforeg[3][4] ), .D(n7), .Y(
        n154) );
  AOI21X1 U110 ( .A(n155), .B(n154), .C(n212), .Y(n156) );
  OR2X1 U111 ( .A(n157), .B(n156), .Y(N20) );
  AOI22X1 U112 ( .A(\fiforeg[4][5] ), .B(n6), .C(\fiforeg[6][5] ), .D(n4), .Y(
        n159) );
  AOI22X1 U113 ( .A(\fiforeg[0][5] ), .B(n3), .C(\fiforeg[2][5] ), .D(n7), .Y(
        n158) );
  AOI21X1 U114 ( .A(n159), .B(n158), .C(N13), .Y(n163) );
  AOI22X1 U115 ( .A(\fiforeg[5][5] ), .B(n6), .C(\fiforeg[7][5] ), .D(n4), .Y(
        n161) );
  AOI22X1 U116 ( .A(\fiforeg[1][5] ), .B(n3), .C(\fiforeg[3][5] ), .D(n7), .Y(
        n160) );
  AOI21X1 U117 ( .A(n161), .B(n160), .C(n212), .Y(n162) );
  OR2X1 U118 ( .A(n163), .B(n162), .Y(N19) );
  AOI22X1 U119 ( .A(\fiforeg[4][6] ), .B(n6), .C(\fiforeg[6][6] ), .D(n4), .Y(
        n165) );
  AOI22X1 U120 ( .A(\fiforeg[0][6] ), .B(n3), .C(\fiforeg[2][6] ), .D(n7), .Y(
        n164) );
  AOI21X1 U121 ( .A(n165), .B(n164), .C(N13), .Y(n169) );
  AOI22X1 U122 ( .A(\fiforeg[5][6] ), .B(n6), .C(\fiforeg[7][6] ), .D(n4), .Y(
        n167) );
  AOI22X1 U123 ( .A(\fiforeg[1][6] ), .B(n3), .C(\fiforeg[3][6] ), .D(n7), .Y(
        n166) );
  AOI21X1 U124 ( .A(n167), .B(n166), .C(n212), .Y(n168) );
  OR2X1 U125 ( .A(n169), .B(n168), .Y(N18) );
  AOI22X1 U126 ( .A(\fiforeg[4][7] ), .B(n6), .C(\fiforeg[6][7] ), .D(n4), .Y(
        n171) );
  AOI22X1 U127 ( .A(\fiforeg[0][7] ), .B(n3), .C(\fiforeg[2][7] ), .D(n7), .Y(
        n170) );
  AOI21X1 U128 ( .A(n171), .B(n170), .C(N13), .Y(n179) );
  AOI22X1 U129 ( .A(\fiforeg[5][7] ), .B(n6), .C(\fiforeg[7][7] ), .D(n4), .Y(
        n177) );
  AOI22X1 U130 ( .A(\fiforeg[1][7] ), .B(n3), .C(\fiforeg[3][7] ), .D(n7), .Y(
        n176) );
  AOI21X1 U131 ( .A(n177), .B(n176), .C(n212), .Y(n178) );
  OR2X1 U132 ( .A(n179), .B(n178), .Y(N17) );
  INVX2 U133 ( .A(N14), .Y(n180) );
  MUX2X1 U134 ( .B(n181), .A(n182), .S(n183), .Y(n99) );
  INVX1 U135 ( .A(\fiforeg[6][2] ), .Y(n182) );
  MUX2X1 U136 ( .B(n184), .A(n185), .S(n183), .Y(n98) );
  INVX1 U137 ( .A(\fiforeg[6][1] ), .Y(n185) );
  MUX2X1 U138 ( .B(n186), .A(n187), .S(n183), .Y(n97) );
  INVX1 U139 ( .A(\fiforeg[6][0] ), .Y(n187) );
  MUX2X1 U140 ( .B(n188), .A(n189), .S(n190), .Y(n96) );
  INVX1 U141 ( .A(\fiforeg[7][7] ), .Y(n189) );
  MUX2X1 U142 ( .B(n191), .A(n192), .S(n190), .Y(n95) );
  INVX1 U143 ( .A(\fiforeg[7][6] ), .Y(n192) );
  MUX2X1 U144 ( .B(n193), .A(n194), .S(n190), .Y(n94) );
  INVX1 U145 ( .A(\fiforeg[7][5] ), .Y(n194) );
  MUX2X1 U146 ( .B(n195), .A(n196), .S(n190), .Y(n93) );
  INVX1 U147 ( .A(\fiforeg[7][4] ), .Y(n196) );
  MUX2X1 U148 ( .B(n197), .A(n198), .S(n190), .Y(n92) );
  INVX1 U149 ( .A(\fiforeg[7][3] ), .Y(n198) );
  MUX2X1 U150 ( .B(n181), .A(n199), .S(n190), .Y(n91) );
  INVX1 U151 ( .A(\fiforeg[7][2] ), .Y(n199) );
  MUX2X1 U152 ( .B(n184), .A(n200), .S(n190), .Y(n90) );
  INVX1 U153 ( .A(\fiforeg[7][1] ), .Y(n200) );
  MUX2X1 U154 ( .B(n186), .A(n201), .S(n190), .Y(n89) );
  NAND3X1 U155 ( .A(N15), .B(N14), .C(N13), .Y(n190) );
  INVX1 U156 ( .A(\fiforeg[7][0] ), .Y(n201) );
  MUX2X1 U157 ( .B(n188), .A(n202), .S(n203), .Y(n152) );
  INVX1 U158 ( .A(\fiforeg[0][7] ), .Y(n202) );
  MUX2X1 U159 ( .B(n191), .A(n204), .S(n203), .Y(n151) );
  INVX1 U160 ( .A(\fiforeg[0][6] ), .Y(n204) );
  MUX2X1 U161 ( .B(n193), .A(n205), .S(n203), .Y(n150) );
  INVX1 U162 ( .A(\fiforeg[0][5] ), .Y(n205) );
  MUX2X1 U163 ( .B(n195), .A(n206), .S(n203), .Y(n149) );
  INVX1 U164 ( .A(\fiforeg[0][4] ), .Y(n206) );
  MUX2X1 U165 ( .B(n197), .A(n207), .S(n203), .Y(n148) );
  INVX1 U166 ( .A(\fiforeg[0][3] ), .Y(n207) );
  MUX2X1 U167 ( .B(n181), .A(n208), .S(n203), .Y(n147) );
  INVX1 U168 ( .A(\fiforeg[0][2] ), .Y(n208) );
  MUX2X1 U169 ( .B(n184), .A(n209), .S(n203), .Y(n146) );
  INVX1 U170 ( .A(\fiforeg[0][1] ), .Y(n209) );
  MUX2X1 U171 ( .B(n186), .A(n210), .S(n203), .Y(n145) );
  NAND3X1 U172 ( .A(n180), .B(n211), .C(n212), .Y(n203) );
  INVX1 U173 ( .A(\fiforeg[0][0] ), .Y(n210) );
  MUX2X1 U174 ( .B(n188), .A(n213), .S(n214), .Y(n144) );
  INVX1 U175 ( .A(\fiforeg[1][7] ), .Y(n213) );
  MUX2X1 U176 ( .B(n191), .A(n215), .S(n214), .Y(n143) );
  INVX1 U177 ( .A(\fiforeg[1][6] ), .Y(n215) );
  MUX2X1 U178 ( .B(n193), .A(n216), .S(n214), .Y(n142) );
  INVX1 U179 ( .A(\fiforeg[1][5] ), .Y(n216) );
  MUX2X1 U180 ( .B(n195), .A(n217), .S(n214), .Y(n141) );
  INVX1 U181 ( .A(\fiforeg[1][4] ), .Y(n217) );
  MUX2X1 U182 ( .B(n197), .A(n218), .S(n214), .Y(n140) );
  INVX1 U183 ( .A(\fiforeg[1][3] ), .Y(n218) );
  MUX2X1 U184 ( .B(n181), .A(n219), .S(n214), .Y(n139) );
  INVX1 U185 ( .A(\fiforeg[1][2] ), .Y(n219) );
  MUX2X1 U186 ( .B(n184), .A(n220), .S(n214), .Y(n138) );
  INVX1 U187 ( .A(\fiforeg[1][1] ), .Y(n220) );
  MUX2X1 U188 ( .B(n186), .A(n221), .S(n214), .Y(n137) );
  NAND3X1 U189 ( .A(n180), .B(n211), .C(N13), .Y(n214) );
  INVX1 U190 ( .A(\fiforeg[1][0] ), .Y(n221) );
  MUX2X1 U191 ( .B(n188), .A(n222), .S(n223), .Y(n136) );
  INVX1 U192 ( .A(\fiforeg[2][7] ), .Y(n222) );
  MUX2X1 U193 ( .B(n191), .A(n224), .S(n223), .Y(n135) );
  INVX1 U194 ( .A(\fiforeg[2][6] ), .Y(n224) );
  MUX2X1 U195 ( .B(n193), .A(n225), .S(n223), .Y(n134) );
  INVX1 U196 ( .A(\fiforeg[2][5] ), .Y(n225) );
  MUX2X1 U197 ( .B(n195), .A(n226), .S(n223), .Y(n133) );
  INVX1 U198 ( .A(\fiforeg[2][4] ), .Y(n226) );
  MUX2X1 U199 ( .B(n197), .A(n227), .S(n223), .Y(n132) );
  INVX1 U200 ( .A(\fiforeg[2][3] ), .Y(n227) );
  MUX2X1 U201 ( .B(n181), .A(n228), .S(n223), .Y(n131) );
  INVX1 U202 ( .A(\fiforeg[2][2] ), .Y(n228) );
  MUX2X1 U203 ( .B(n184), .A(n229), .S(n223), .Y(n130) );
  INVX1 U204 ( .A(\fiforeg[2][1] ), .Y(n229) );
  MUX2X1 U205 ( .B(n186), .A(n230), .S(n223), .Y(n129) );
  NAND3X1 U206 ( .A(n212), .B(n211), .C(N14), .Y(n223) );
  INVX1 U207 ( .A(\fiforeg[2][0] ), .Y(n230) );
  MUX2X1 U208 ( .B(n188), .A(n231), .S(n232), .Y(n128) );
  INVX1 U209 ( .A(\fiforeg[3][7] ), .Y(n231) );
  MUX2X1 U210 ( .B(n191), .A(n233), .S(n232), .Y(n127) );
  INVX1 U211 ( .A(\fiforeg[3][6] ), .Y(n233) );
  MUX2X1 U212 ( .B(n193), .A(n234), .S(n232), .Y(n126) );
  INVX1 U213 ( .A(\fiforeg[3][5] ), .Y(n234) );
  MUX2X1 U214 ( .B(n195), .A(n235), .S(n232), .Y(n125) );
  INVX1 U215 ( .A(\fiforeg[3][4] ), .Y(n235) );
  MUX2X1 U216 ( .B(n197), .A(n236), .S(n232), .Y(n124) );
  INVX1 U217 ( .A(\fiforeg[3][3] ), .Y(n236) );
  MUX2X1 U218 ( .B(n181), .A(n237), .S(n232), .Y(n123) );
  INVX1 U219 ( .A(\fiforeg[3][2] ), .Y(n237) );
  MUX2X1 U220 ( .B(n184), .A(n238), .S(n232), .Y(n122) );
  INVX1 U221 ( .A(\fiforeg[3][1] ), .Y(n238) );
  MUX2X1 U222 ( .B(n186), .A(n239), .S(n232), .Y(n121) );
  NAND3X1 U223 ( .A(N14), .B(n211), .C(N13), .Y(n232) );
  INVX1 U224 ( .A(N15), .Y(n211) );
  INVX1 U225 ( .A(\fiforeg[3][0] ), .Y(n239) );
  MUX2X1 U226 ( .B(n188), .A(n240), .S(n241), .Y(n120) );
  INVX1 U227 ( .A(\fiforeg[4][7] ), .Y(n240) );
  MUX2X1 U228 ( .B(n191), .A(n242), .S(n241), .Y(n119) );
  INVX1 U229 ( .A(\fiforeg[4][6] ), .Y(n242) );
  MUX2X1 U230 ( .B(n193), .A(n243), .S(n241), .Y(n118) );
  INVX1 U231 ( .A(\fiforeg[4][5] ), .Y(n243) );
  MUX2X1 U232 ( .B(n195), .A(n244), .S(n241), .Y(n117) );
  INVX1 U233 ( .A(\fiforeg[4][4] ), .Y(n244) );
  MUX2X1 U234 ( .B(n197), .A(n245), .S(n241), .Y(n116) );
  INVX1 U235 ( .A(\fiforeg[4][3] ), .Y(n245) );
  MUX2X1 U236 ( .B(n181), .A(n246), .S(n241), .Y(n115) );
  INVX1 U237 ( .A(\fiforeg[4][2] ), .Y(n246) );
  MUX2X1 U238 ( .B(n184), .A(n247), .S(n241), .Y(n114) );
  INVX1 U239 ( .A(\fiforeg[4][1] ), .Y(n247) );
  MUX2X1 U240 ( .B(n186), .A(n248), .S(n241), .Y(n113) );
  NAND3X1 U241 ( .A(n212), .B(n180), .C(N15), .Y(n241) );
  INVX1 U242 ( .A(\fiforeg[4][0] ), .Y(n248) );
  MUX2X1 U243 ( .B(n188), .A(n249), .S(n250), .Y(n112) );
  INVX1 U244 ( .A(\fiforeg[5][7] ), .Y(n249) );
  MUX2X1 U245 ( .B(n191), .A(n251), .S(n250), .Y(n111) );
  INVX1 U246 ( .A(\fiforeg[5][6] ), .Y(n251) );
  MUX2X1 U247 ( .B(n193), .A(n252), .S(n250), .Y(n110) );
  INVX1 U248 ( .A(\fiforeg[5][5] ), .Y(n252) );
  MUX2X1 U249 ( .B(n195), .A(n253), .S(n250), .Y(n109) );
  INVX1 U250 ( .A(\fiforeg[5][4] ), .Y(n253) );
  MUX2X1 U251 ( .B(n197), .A(n254), .S(n250), .Y(n108) );
  INVX1 U252 ( .A(\fiforeg[5][3] ), .Y(n254) );
  MUX2X1 U253 ( .B(n181), .A(n255), .S(n250), .Y(n107) );
  INVX1 U254 ( .A(\fiforeg[5][2] ), .Y(n255) );
  MUX2X1 U255 ( .B(N22), .A(wdata[2]), .S(wenable), .Y(n181) );
  MUX2X1 U256 ( .B(n184), .A(n256), .S(n250), .Y(n106) );
  INVX1 U257 ( .A(\fiforeg[5][1] ), .Y(n256) );
  MUX2X1 U258 ( .B(N23), .A(wdata[1]), .S(wenable), .Y(n184) );
  MUX2X1 U259 ( .B(n186), .A(n257), .S(n250), .Y(n105) );
  NAND3X1 U260 ( .A(N15), .B(n180), .C(N13), .Y(n250) );
  INVX1 U261 ( .A(\fiforeg[5][0] ), .Y(n257) );
  MUX2X1 U262 ( .B(N24), .A(wdata[0]), .S(wenable), .Y(n186) );
  MUX2X1 U263 ( .B(n188), .A(n258), .S(n183), .Y(n104) );
  INVX1 U264 ( .A(\fiforeg[6][7] ), .Y(n258) );
  MUX2X1 U265 ( .B(N17), .A(wdata[7]), .S(wenable), .Y(n188) );
  MUX2X1 U266 ( .B(n191), .A(n259), .S(n183), .Y(n103) );
  INVX1 U267 ( .A(\fiforeg[6][6] ), .Y(n259) );
  MUX2X1 U268 ( .B(N18), .A(wdata[6]), .S(wenable), .Y(n191) );
  MUX2X1 U269 ( .B(n193), .A(n260), .S(n183), .Y(n102) );
  INVX1 U270 ( .A(\fiforeg[6][5] ), .Y(n260) );
  MUX2X1 U271 ( .B(N19), .A(wdata[5]), .S(wenable), .Y(n193) );
  MUX2X1 U272 ( .B(n195), .A(n261), .S(n183), .Y(n101) );
  INVX1 U273 ( .A(\fiforeg[6][4] ), .Y(n261) );
  MUX2X1 U274 ( .B(N20), .A(wdata[4]), .S(wenable), .Y(n195) );
  MUX2X1 U275 ( .B(n197), .A(n262), .S(n183), .Y(n100) );
  NAND3X1 U276 ( .A(N14), .B(n212), .C(N15), .Y(n183) );
  INVX1 U277 ( .A(N13), .Y(n212) );
  INVX1 U278 ( .A(\fiforeg[6][3] ), .Y(n262) );
  MUX2X1 U279 ( .B(N21), .A(wdata[3]), .S(wenable), .Y(n197) );
endmodule


module write_ptr ( wclk, rst_n, wenable, wptr, wptr_nxt );
  output [3:0] wptr;
  output [3:0] wptr_nxt;
  input wclk, rst_n, wenable;
  wire   n9, n10, n11, n12;
  wire   [2:0] binary_nxt;
  wire   [3:0] binary_r;

  DFFSR \binary_r_reg[0]  ( .D(binary_nxt[0]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[0]) );
  DFFSR \binary_r_reg[1]  ( .D(binary_nxt[1]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[1]) );
  DFFSR \binary_r_reg[2]  ( .D(binary_nxt[2]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[2]) );
  DFFSR \binary_r_reg[3]  ( .D(wptr_nxt[3]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[3]) );
  DFFSR \gray_r_reg[3]  ( .D(wptr_nxt[3]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[3]) );
  DFFSR \gray_r_reg[2]  ( .D(wptr_nxt[2]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[2]) );
  DFFSR \gray_r_reg[1]  ( .D(wptr_nxt[1]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[1]) );
  DFFSR \gray_r_reg[0]  ( .D(wptr_nxt[0]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wptr[0]) );
  XOR2X1 U11 ( .A(wptr_nxt[3]), .B(binary_nxt[2]), .Y(wptr_nxt[2]) );
  XNOR2X1 U12 ( .A(n9), .B(binary_r[3]), .Y(wptr_nxt[3]) );
  NAND2X1 U13 ( .A(binary_r[2]), .B(n10), .Y(n9) );
  XOR2X1 U14 ( .A(binary_nxt[2]), .B(binary_nxt[1]), .Y(wptr_nxt[1]) );
  XOR2X1 U15 ( .A(binary_nxt[1]), .B(binary_nxt[0]), .Y(wptr_nxt[0]) );
  XOR2X1 U16 ( .A(n10), .B(binary_r[2]), .Y(binary_nxt[2]) );
  INVX1 U17 ( .A(n11), .Y(n10) );
  NAND3X1 U18 ( .A(binary_r[1]), .B(binary_r[0]), .C(wenable), .Y(n11) );
  XNOR2X1 U19 ( .A(n12), .B(binary_r[1]), .Y(binary_nxt[1]) );
  NAND2X1 U20 ( .A(wenable), .B(binary_r[0]), .Y(n12) );
  XOR2X1 U21 ( .A(binary_r[0]), .B(wenable), .Y(binary_nxt[0]) );
endmodule


module write_fifo_ctrl ( wclk, rst_n, wenable, rptr, wenable_fifo, wptr, waddr, 
        full_flag );
  input [3:0] rptr;
  output [3:0] wptr;
  output [2:0] waddr;
  input wclk, rst_n, wenable;
  output wenable_fifo, full_flag;
  wire   n22, \gray_wptr[2] , N5, n2, n3, n16, n17, n18, n19, n20, n21;
  wire   [3:0] wptr_nxt;
  wire   [3:0] wrptr_r2;
  wire   [3:0] wrptr_r1;

  DFFSR \wrptr_r1_reg[3]  ( .D(rptr[3]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[3]) );
  DFFSR \wrptr_r1_reg[2]  ( .D(rptr[2]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[2]) );
  DFFSR \wrptr_r1_reg[1]  ( .D(rptr[1]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[1]) );
  DFFSR \wrptr_r1_reg[0]  ( .D(rptr[0]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        wrptr_r1[0]) );
  DFFSR \wrptr_r2_reg[3]  ( .D(wrptr_r1[3]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[3]) );
  DFFSR \wrptr_r2_reg[2]  ( .D(wrptr_r1[2]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[2]) );
  DFFSR \wrptr_r2_reg[1]  ( .D(wrptr_r1[1]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[1]) );
  DFFSR \wrptr_r2_reg[0]  ( .D(wrptr_r1[0]), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(wrptr_r2[0]) );
  DFFSR full_flag_r_reg ( .D(N5), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        full_flag) );
  DFFSR \waddr_reg[2]  ( .D(\gray_wptr[2] ), .CLK(wclk), .R(rst_n), .S(1'b1), 
        .Q(waddr[2]) );
  DFFSR \waddr_reg[1]  ( .D(wptr_nxt[1]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        waddr[1]) );
  DFFSR \waddr_reg[0]  ( .D(wptr_nxt[0]), .CLK(wclk), .R(rst_n), .S(1'b1), .Q(
        waddr[0]) );
  write_ptr WPU1 ( .wclk(wclk), .rst_n(rst_n), .wenable(wenable_fifo), .wptr(
        wptr), .wptr_nxt(wptr_nxt) );
  BUFX2 U15 ( .A(n22), .Y(wenable_fifo) );
  NOR2X1 U16 ( .A(full_flag), .B(n2), .Y(n22) );
  INVX1 U17 ( .A(wenable), .Y(n2) );
  NOR2X1 U18 ( .A(n3), .B(n16), .Y(N5) );
  NAND2X1 U19 ( .A(n17), .B(n18), .Y(n16) );
  XOR2X1 U20 ( .A(n19), .B(\gray_wptr[2] ), .Y(n18) );
  XOR2X1 U21 ( .A(wptr_nxt[3]), .B(wptr_nxt[2]), .Y(\gray_wptr[2] ) );
  XNOR2X1 U22 ( .A(wrptr_r2[3]), .B(wrptr_r2[2]), .Y(n19) );
  XNOR2X1 U23 ( .A(wrptr_r2[1]), .B(wptr_nxt[1]), .Y(n17) );
  NAND2X1 U24 ( .A(n20), .B(n21), .Y(n3) );
  XOR2X1 U25 ( .A(wrptr_r2[3]), .B(wptr_nxt[3]), .Y(n21) );
  XNOR2X1 U26 ( .A(wrptr_r2[0]), .B(wptr_nxt[0]), .Y(n20) );
endmodule


module read_ptr ( rclk, rst_n, renable, rptr, rptr_nxt );
  output [3:0] rptr;
  output [3:0] rptr_nxt;
  input rclk, rst_n, renable;
  wire   n9, n10, n11, n12;
  wire   [2:0] binary_nxt;
  wire   [3:0] binary_r;

  DFFSR \binary_r_reg[0]  ( .D(binary_nxt[0]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[0]) );
  DFFSR \binary_r_reg[1]  ( .D(binary_nxt[1]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[1]) );
  DFFSR \binary_r_reg[2]  ( .D(binary_nxt[2]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[2]) );
  DFFSR \binary_r_reg[3]  ( .D(rptr_nxt[3]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(binary_r[3]) );
  DFFSR \gray_r_reg[3]  ( .D(rptr_nxt[3]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rptr[3]) );
  DFFSR \gray_r_reg[2]  ( .D(rptr_nxt[2]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rptr[2]) );
  DFFSR \gray_r_reg[1]  ( .D(rptr_nxt[1]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rptr[1]) );
  DFFSR \gray_r_reg[0]  ( .D(rptr_nxt[0]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rptr[0]) );
  XOR2X1 U11 ( .A(rptr_nxt[3]), .B(binary_nxt[2]), .Y(rptr_nxt[2]) );
  XNOR2X1 U12 ( .A(n9), .B(binary_r[3]), .Y(rptr_nxt[3]) );
  NAND2X1 U13 ( .A(binary_r[2]), .B(n10), .Y(n9) );
  XOR2X1 U14 ( .A(binary_nxt[2]), .B(binary_nxt[1]), .Y(rptr_nxt[1]) );
  XOR2X1 U15 ( .A(binary_nxt[1]), .B(binary_nxt[0]), .Y(rptr_nxt[0]) );
  XOR2X1 U16 ( .A(n10), .B(binary_r[2]), .Y(binary_nxt[2]) );
  INVX1 U17 ( .A(n11), .Y(n10) );
  NAND3X1 U18 ( .A(binary_r[1]), .B(binary_r[0]), .C(renable), .Y(n11) );
  XNOR2X1 U19 ( .A(n12), .B(binary_r[1]), .Y(binary_nxt[1]) );
  NAND2X1 U20 ( .A(renable), .B(binary_r[0]), .Y(n12) );
  XOR2X1 U21 ( .A(binary_r[0]), .B(renable), .Y(binary_nxt[0]) );
endmodule


module read_fifo_ctrl ( rclk, rst_n, renable, wptr, rptr, raddr, empty_flag );
  input [3:0] wptr;
  output [3:0] rptr;
  output [2:0] raddr;
  input rclk, rst_n, renable;
  output empty_flag;
  wire   renable_p2, \gray_rptr[2] , N3, n1, n2, n3, n16, n17, n18, n19, n20;
  wire   [3:0] rptr_nxt;
  wire   [3:0] rwptr_r2;
  wire   [3:0] rwptr_r1;

  DFFSR \rwptr_r1_reg[3]  ( .D(wptr[3]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[3]) );
  DFFSR \rwptr_r1_reg[2]  ( .D(wptr[2]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[2]) );
  DFFSR \rwptr_r1_reg[1]  ( .D(wptr[1]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[1]) );
  DFFSR \rwptr_r1_reg[0]  ( .D(wptr[0]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        rwptr_r1[0]) );
  DFFSR \rwptr_r2_reg[3]  ( .D(rwptr_r1[3]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[3]) );
  DFFSR \rwptr_r2_reg[2]  ( .D(rwptr_r1[2]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[2]) );
  DFFSR \rwptr_r2_reg[1]  ( .D(rwptr_r1[1]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[1]) );
  DFFSR \rwptr_r2_reg[0]  ( .D(rwptr_r1[0]), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(rwptr_r2[0]) );
  DFFSR empty_flag_r_reg ( .D(N3), .CLK(rclk), .R(1'b1), .S(rst_n), .Q(
        empty_flag) );
  DFFSR \raddr_reg[2]  ( .D(\gray_rptr[2] ), .CLK(rclk), .R(rst_n), .S(1'b1), 
        .Q(raddr[2]) );
  DFFSR \raddr_reg[1]  ( .D(rptr_nxt[1]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        raddr[1]) );
  DFFSR \raddr_reg[0]  ( .D(rptr_nxt[0]), .CLK(rclk), .R(rst_n), .S(1'b1), .Q(
        raddr[0]) );
  read_ptr RPU1 ( .rclk(rclk), .rst_n(rst_n), .renable(renable_p2), .rptr(rptr), .rptr_nxt(rptr_nxt) );
  NOR2X1 U15 ( .A(empty_flag), .B(n1), .Y(renable_p2) );
  INVX1 U16 ( .A(renable), .Y(n1) );
  NOR2X1 U17 ( .A(n2), .B(n3), .Y(N3) );
  NAND2X1 U18 ( .A(n16), .B(n17), .Y(n3) );
  XOR2X1 U19 ( .A(n18), .B(\gray_rptr[2] ), .Y(n17) );
  XOR2X1 U20 ( .A(rptr_nxt[3]), .B(rptr_nxt[2]), .Y(\gray_rptr[2] ) );
  XNOR2X1 U21 ( .A(rwptr_r2[3]), .B(rwptr_r2[2]), .Y(n18) );
  XNOR2X1 U22 ( .A(rwptr_r2[1]), .B(rptr_nxt[1]), .Y(n16) );
  NAND2X1 U23 ( .A(n19), .B(n20), .Y(n2) );
  XNOR2X1 U24 ( .A(rwptr_r2[0]), .B(rptr_nxt[0]), .Y(n20) );
  XNOR2X1 U25 ( .A(rptr_nxt[3]), .B(rwptr_r2[3]), .Y(n19) );
endmodule


module fifo ( r_clk, w_clk, n_rst, r_enable, w_enable, w_data, r_data, empty, 
        full );
  input [7:0] w_data;
  output [7:0] r_data;
  input r_clk, w_clk, n_rst, r_enable, w_enable;
  output empty, full;
  wire   wenable_fifo;
  wire   [2:0] waddr;
  wire   [2:0] raddr;
  wire   [3:0] rptr;
  wire   [3:0] wptr;

  fiforam UFIFORAM ( .wclk(w_clk), .wenable(wenable_fifo), .waddr(waddr), 
        .raddr(raddr), .wdata(w_data), .rdata(r_data) );
  write_fifo_ctrl UWFC ( .wclk(w_clk), .rst_n(n_rst), .wenable(w_enable), 
        .rptr(rptr), .wenable_fifo(wenable_fifo), .wptr(wptr), .waddr(waddr), 
        .full_flag(full) );
  read_fifo_ctrl URFC ( .rclk(r_clk), .rst_n(n_rst), .renable(r_enable), 
        .wptr(wptr), .rptr(rptr), .raddr(raddr), .empty_flag(empty) );
endmodule


module rx_fifo ( clk, n_rst, r_enable, w_enable, w_data, r_data, empty, full
 );
  input [7:0] w_data;
  output [7:0] r_data;
  input clk, n_rst, r_enable, w_enable;
  output empty, full;


  fifo RX ( .r_clk(clk), .w_clk(clk), .n_rst(n_rst), .r_enable(r_enable), 
        .w_enable(w_enable), .w_data(w_data), .r_data(r_data), .empty(empty), 
        .full(full) );
endmodule


module usb_receiver ( clk, n_rst, d_plus, d_minus, r_enable, r_data, empty, 
        full, rcving, r_error, w_enable, eop );
  output [7:0] r_data;
  input clk, n_rst, d_plus, d_minus, r_enable;
  output empty, full, rcving, r_error, w_enable, eop;
  wire   d_plus_sync, d_minus_sync, shift_enable, d_orig, d_edge,
         byte_received;
  wire   [7:0] rcv_data;

  sync_1 high ( .clk(clk), .n_rst(n_rst), .async_in(d_plus), .sync_out(
        d_plus_sync) );
  sync_0 low ( .clk(clk), .n_rst(n_rst), .async_in(d_minus), .sync_out(
        d_minus_sync) );
  eop_detect EOPDETECTOR ( .d_plus(d_plus_sync), .d_minus(d_minus_sync), .eop(
        eop) );
  decode DECODER ( .clk(clk), .n_rst(n_rst), .d_plus(d_plus_sync), 
        .shift_enable(shift_enable), .eop(eop), .d_orig(d_orig) );
  edge_detect EDGEDETECTOR ( .clk(clk), .n_rst(n_rst), .d_plus(d_plus_sync), 
        .d_edge(d_edge) );
  timer SAMPLETIMER ( .clk(clk), .n_rst(n_rst), .d_edge(d_edge), .rcving(
        rcving), .shift_enable(shift_enable), .byte_received(byte_received) );
  shift_register SHIFTREG ( .clk(clk), .n_rst(n_rst), .shift_enable(
        shift_enable), .d_orig(d_orig), .rcv_data(rcv_data) );
  rcu CONTROLLER ( .clk(clk), .n_rst(n_rst), .d_edge(d_edge), .eop(eop), 
        .shift_enable(shift_enable), .rcv_data(rcv_data), .byte_received(
        byte_received), .rcving(rcving), .w_enable(w_enable), .r_error(r_error) );
  rx_fifo FIFO ( .clk(clk), .n_rst(n_rst), .r_enable(r_enable), .w_enable(
        w_enable), .w_data(rcv_data), .r_data(r_data), .empty(empty), .full(
        full) );
endmodule


module receiver ( d_plus, d_minus, fifo_ready, clk, n_rst, is_tx_active, 
        send_data, send_nak );
  input d_plus, d_minus, fifo_ready, clk, n_rst, is_tx_active;
  output send_data, send_nak;
  wire   fifo_empty, eop, read_rcv_fifo;
  wire   [7:0] fifo_bus;

  rxpu RXPU_OF_DESTINY ( .clk(clk), .n_rst(n_rst), .is_tx_active(is_tx_active), 
        .is_rcv_empty(fifo_empty), .is_eop_rcvd(eop), .is_data_ready(
        fifo_ready), .rcv_bus(fifo_bus), .read_rcv_fifo(read_rcv_fifo), 
        .send_data(send_data), .send_nak(send_nak) );
  usb_receiver USB_RECEIVER ( .clk(clk), .n_rst(n_rst), .d_plus(d_plus), 
        .d_minus(d_minus), .r_enable(read_rcv_fifo), .r_data(fifo_bus), 
        .empty(fifo_empty), .eop(eop) );
endmodule


module transceiver ( clk, n_rst, FIFO_byte, fifo_ready, tx_d_plus, tx_d_minus, 
        rx_d_plus, rx_d_minus, fifo_r_enable, is_txing );
  input [7:0] FIFO_byte;
  input clk, n_rst, fifo_ready, rx_d_plus, rx_d_minus;
  output tx_d_plus, tx_d_minus, fifo_r_enable, is_txing;
  wire   send_nak, send_data;

  transmitter TX ( .clk(clk), .n_rst(n_rst), .send_nak(send_nak), .send_data(
        send_data), .FIFO_byte(FIFO_byte), .fifo_r_enable(fifo_r_enable), 
        .is_txing(is_txing), .d_plus(tx_d_plus), .d_minus(tx_d_minus) );
  receiver RX ( .d_plus(rx_d_plus), .d_minus(rx_d_minus), .fifo_ready(
        fifo_ready), .clk(clk), .n_rst(n_rst), .is_tx_active(is_txing), 
        .send_data(send_data), .send_nak(send_nak) );
endmodule

