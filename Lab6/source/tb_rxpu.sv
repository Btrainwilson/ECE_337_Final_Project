// Id:          mg43
// File name:   rxpu.sv
// Created:     4/17/2018
// Author:      Caleb Tung
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Testing the RXPU!!!! *cross-arms*

`timescale 1ns / 10ps

module tb_rxpu
();
    localparam CLK_PERIOD = 10.0 * 100.0 / 96.0; // 10ns * 100 MHz = CLK_PERIOD * 96 MHz.
    localparam DUT_ADDR = 8'b01001100;
    localparam OTHER_ADDR = 8'b01010010;
    localparam IN_PID = 8'b01101001;
    localparam MEH_PID = 8'b00111100;

    reg tb_clk;
    reg tb_n_rst;
    reg tb_is_tx_active;
    reg tb_is_rcv_empty;
    reg tb_is_eop_rcvd;
    reg tb_is_data_ready;
    reg [7:0] tb_rcv_bus;

    reg tb_read_rcv_fifo;
    reg tb_send_data;
    reg tb_send_nak;
    

    // 96 MHz test bench clock
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

    rxpu DUT
    (
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .is_tx_active(tb_is_tx_active), // asserted when TXPU is transmitting
        .is_rcv_empty(tb_is_rcv_empty), // asserted when packet FIFO is empty
        .is_eop_rcvd(tb_is_eop_rcvd), // asserted when receiver sees the EOP
        .is_data_ready(tb_is_data_ready), // asserted when data FIFO is ready to transmit
        .rcv_bus(tb_rcv_bus), // 1 byte from the USB data lines
        
        .read_rcv_fifo(tb_read_rcv_fifo),
        .send_data(tb_send_data),
        .send_nak(tb_send_nak)
    );

    task reset_DUT;
    begin
        tb_is_tx_active = 0;
        tb_is_rcv_empty = 1;        
        tb_is_eop_rcvd = 0;
        tb_is_data_ready = 0;
        tb_rcv_bus = 8'b0;
        
        tb_n_rst = 1'b0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_n_rst = 1'b1;
		@(posedge tb_clk);
		@(posedge tb_clk);
    end
    endtask

    task wait_8_cycles;
    begin
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
    end
    endtask

    initial
    begin
        reset_DUT();
        
// Test 1: Confirm that reset device stays IDLE
        $display("**********************************");
        $display("TEST 1: Confirm that reset device stays IDLE");
        assert(tb_read_rcv_fifo == 0)
            $info("PASS - IDLE state doesn't mess with read pointer");
        else
            $error("FAIL - IDLE state moved read pointer");

        assert(tb_send_data == 0)
            $info("PASS - IDLE state doesn't trigger Send data");
        else
            $error("FAIL - IDLE state triggered send data");

        assert(tb_send_nak == 0)
            $info("PASS - IDLE state doesn't trigger Send Nak");
        else
            $error("FAIL - IDLE state triggered Send Nak");
        
        // Wait a good long while
        wait_8_cycles();

        assert(tb_read_rcv_fifo == 0)
            $info("PASS - IDLE state still doesn't mess with read pointer");
        else
            $error("FAIL - IDLE state still moved read pointer");

        assert(tb_send_data == 0)
            $info("PASS - IDLE state still doesn't trigger Send data");
        else
            $error("FAIL - IDLE state still triggered send data");

        assert(tb_send_nak == 0)
            $info("PASS - IDLE state still doesn't trigger Send Nak");
        else
            $error("FAIL - IDLE state still triggered Send Nak");

// Test 2: Check that device ignores improperly addressed IN packets
        $display("**********************************");
        $display("TEST 2: Check that device ignores improperly addressed IN packets");
        reset_DUT();
        wait_8_cycles();
        tb_rcv_bus = IN_PID;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear IN PID off bus");
        else
            $error("FAIL - Doesn't try to clear IN PID off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");

        wait_8_cycles();
        tb_rcv_bus = OTHER_ADDR;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear stuff off bus");
        else
            $error("FAIL - Doesn't try to clear stuff off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);

        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");
        
        tb_is_eop_rcvd = 1;
        @(posedge tb_clk);

        assert(tb_send_data == 0)
            $info("PASS - Send Data stays down when IN not addressed to me");
        else
            $error("FAIL - Send Data Responded when IN not addressed to me");

        assert(tb_send_nak == 0)
            $info("PASS - Send Nak stays down when IN not addressed to me");
        else
            $error("FAIL - Send Nak Responded when IN not addressed to me");

// Test 3: Check that device ignores improperly addressed MEH packets
        $display("**********************************");
        $display("TEST 3: Check that device ignores improperly addressed MEH packets");
        reset_DUT();
        wait_8_cycles();
        tb_rcv_bus = MEH_PID;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear MEH PID off bus");
        else
            $error("FAIL - Doesn't try to clear MEH PID off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");

        wait_8_cycles();
        tb_rcv_bus = OTHER_ADDR;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear stuff off bus");
        else
            $error("FAIL - Doesn't try to clear stuff off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);

        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");
        
        tb_is_eop_rcvd = 1;
        @(posedge tb_clk);

        assert(tb_send_data == 0)
            $info("PASS - Send Data stays down when MEH not addressed to me");
        else
            $error("FAIL - Send Data Responded when MEH not addressed to me");

        assert(tb_send_nak == 0)
            $info("PASS - Send Nak stays down when MEH not addressed to me");
        else
            $error("FAIL - Send Nak Responded when MEH not addressed to me");

// Test 4: Check that device responds to properly addressed IN packets when data is ready
        $display("**********************************");
        $display("TEST 4: Check that device responds to properly addressed IN packets when data is ready");
        reset_DUT();
        wait_8_cycles();
        tb_rcv_bus = IN_PID;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear IN PID off bus");
        else
            $error("FAIL - Doesn't try to clear IN PID off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");

        wait_8_cycles();
        tb_rcv_bus = DUT_ADDR;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear stuff off bus");
        else
            $error("FAIL - Doesn't try to clear stuff off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);

        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");
        
        tb_is_data_ready = 1;
        tb_is_eop_rcvd = 1;
        @(posedge tb_clk);
        @(posedge tb_clk);

        assert(tb_send_data == 1)
            $info("PASS - Send Data responded when IN addressed to me and Data Ready");
        else
            $error("FAIL - Send Data stayed down even though IN addressed to me and Data Ready");

        assert(tb_send_nak == 0)
            $info("PASS - Send Nak stays down when IN addressed to me and Data Ready");
        else
            $error("FAIL - Send Nak Responded even though IN addressed to me and Data Ready");

// Test 5: Check that device responds to properly addressed IN packets when data is NOT ready
        $display("**********************************");
        $display("TEST 5: Check that device responds to properly addressed IN packets when data is NOT ready");
        reset_DUT();
        wait_8_cycles();
        tb_rcv_bus = IN_PID;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear IN PID off bus");
        else
            $error("FAIL - Doesn't try to clear IN PID off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");

        wait_8_cycles();
        tb_rcv_bus = DUT_ADDR;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear stuff off bus");
        else
            $error("FAIL - Doesn't try to clear stuff off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);

        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");
        
        tb_is_data_ready = 0;
        tb_is_eop_rcvd = 1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);

        assert(tb_send_data == 0)
            $info("PASS - Send Data stayed down when IN addressed to me but Data Not Ready");
        else
            $error("FAIL - Send Data responded even though IN addressed to me and Data Not Ready");

        assert(tb_send_nak == 1)
            $info("PASS - Send Nak responded when IN addressed to me and Data Not Ready");
        else
            $error("FAIL - Send Nak stayed down even though IN addressed to me and Data Not Ready");

// Test 6: Check that device responds to properly addressed MEH packets
        $display("**********************************");
        $display("TEST 6: Check that device responds to properly addressed MEH packets");
        reset_DUT();
        wait_8_cycles();
        tb_rcv_bus = MEH_PID;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear MEH PID off bus");
        else
            $error("FAIL - Doesn't try to clear MEH PID off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");

        wait_8_cycles();
        tb_rcv_bus = DUT_ADDR;
        tb_is_rcv_empty = 0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        assert(tb_read_rcv_fifo == 1)
            $info("PASS - Tries to clear stuff off bus");
        else
            $error("FAIL - Doesn't try to clear stuff off bus");
        
        tb_is_rcv_empty = 1;
        @(posedge tb_clk);

        assert(tb_read_rcv_fifo == 0)
            $info("PASS - Lowers read enable when FIFO empty");
        else
            $error("FAIL - Doesn't lower read enable when FIFO empty");
        
        tb_is_data_ready = 0;
        tb_is_eop_rcvd = 1;
        @(posedge tb_clk);
        @(posedge tb_clk);

        assert(tb_send_data == 0)
            $info("PASS - Send Data stayed down when MEH addressed to me");
        else
            $error("FAIL - Send Data responded even though MEH addressed to me");

        assert(tb_send_nak == 1)
            $info("PASS - Send Nak responded when MEH addressed to me");
        else
            $error("FAIL - Send Nak stayed down even though MEH addressed to me");
    end
endmodule
