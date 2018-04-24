/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Apr 23 19:38:11 2018
/////////////////////////////////////////////////////////////


module shabang ( w_clk, r_clk, n_rst, Ethernet_In, rx_d_plus, rx_d_minus, 
        tx_d_plus, tx_d_minus, is_txing );
  input w_clk, r_clk, n_rst, Ethernet_In, rx_d_plus, rx_d_minus;
  output tx_d_plus, tx_d_minus, is_txing;

  tri   w_clk;
  tri   r_clk;
  tri   n_rst;
  tri   Ethernet_In;
  tri   rx_d_plus;
  tri   rx_d_minus;
  tri   tx_d_plus;
  tri   tx_d_minus;
  tri   is_txing;
  tri   r_en;
  tri   fifo_ready;
  tri   [7:0] r_data;

  Packet_Storage Ethernet_input ( .w_clk(w_clk), .r_clk(r_clk), .n_rst(n_rst), 
        .Ethernet_In(Ethernet_In), .r_en(r_en), .ready(fifo_ready), .r_data(
        r_data) );
  transceiver USB_output ( .clk(r_clk), .n_rst(n_rst), .FIFO_byte(r_data), 
        .fifo_ready(fifo_ready), .tx_d_plus(tx_d_plus), .tx_d_minus(tx_d_minus), .rx_d_plus(rx_d_plus), .rx_d_minus(rx_d_minus), .fifo_r_enable(r_en), 
        .is_txing(is_txing) );
endmodule

