// Id:         mg43
// File name:   rxpu.sv
// Created:     4/15/2018
// Author:      Caleb Tung
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: The RXPU!!!! *cross-arms*

module rxpu
(
    input wire clk,
    input wire n_rst,
    input wire is_tx_active, // asserted when TXPU is transmitting
    input wire is_rcv_empty, // asserted when packet FIFO is empty
    input wire is_eop_rcvd, // asserted when receiver sees the EOP
    input wire is_data_ready, // asserted when data FIFO is ready to transmit
    input wire [7:0] rcv_bus, // 1 byte from the USB data lines
    
    output reg read_rcv_fifo,
    output reg send_data,
    output reg send_nak
);
    
    localparam IN_PID = 8'b01101001; // PID is 1001 (LSb) and the inverted PID is 0110
    localparam MY_ADDR = 6'b001100; // Hardcode the device address


    typedef enum reg [3:0] {
        IDLE,
        WAIT_FOR_PID,
        CHECK_PID,
        WAIT_FOR_ADDR_IN_RCVD,
        WAIT_FOR_ADDR_MEH_RCVD,
        CHECK_ADDR_IN_RCVD,
        CHECK_ADDR_MEH_RCVD,
        WAIT_EOP_SEND_DATA,
        WAIT_EOP_SEND_NAK,
        WAIT_EOP_IDLE,
        TX_DATA,
        TX_NAK
    } RX_States;

    RX_States state, next_state;
    
    // State Register
    always_ff @ (posedge clk, negedge n_rst)
    begin: RXPU_STATE_REG
        if (0 == n_rst)
        begin
            state <= IDLE;
        end
        else
        begin
            state <= next_state;
        end
    end
    
    // RXPU Next State Logic
    always_comb
    begin: RXPU_NXTST_LOGIC
        case (state)
            IDLE:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;

                if (1 == is_tx_active) // if transmitting, RXPU does nothing but clear the rcv buffer
                begin
                    if (0 == is_rcv_empty) // Stuff is in the rcv buffer, clear it
                    begin
                        read_rcv_fifo = 1;
                    end
                    next_state = IDLE;
                end
                else
                begin
                    next_state = WAIT_FOR_PID;
                end
            end

            WAIT_FOR_PID:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;

                if (0 == is_rcv_empty) // empty flag dropped, PID byte is ready
                begin
                    next_state = CHECK_PID;
                end
                else
                begin
                    next_state = WAIT_FOR_PID;
                end
            end
            
            CHECK_PID:
            begin
                send_data = 0;
                send_nak = 0;

                if (IN_PID == rcv_bus)
                begin
                    next_state = WAIT_FOR_ADDR_IN_RCVD;
                end
                else
                begin
                    next_state = WAIT_FOR_ADDR_MEH_RCVD;
                end

                read_rcv_fifo = 1; // Advance read pointer to get PID off bus                                
            end

            WAIT_FOR_ADDR_IN_RCVD:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;     
                if (1 == is_rcv_empty) // Addr byte hasn't arrived yet, so wait around
                begin
                    next_state = WAIT_FOR_ADDR_IN_RCVD;
                end
                else
                begin
                    next_state = CHECK_ADDR_IN_RCVD;
                end
            end

            WAIT_FOR_ADDR_MEH_RCVD:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;     
                if (1 == is_rcv_empty) // Addr byte hasn't arrived yet, so wait around
                begin
                    next_state = WAIT_FOR_ADDR_MEH_RCVD;
                end
                else
                begin
                    next_state = CHECK_ADDR_MEH_RCVD;
                end
            end


            CHECK_ADDR_IN_RCVD:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;
                
                // 6-bit Address should be on the read bus
                if (MY_ADDR == rcv_bus[5:0])
                begin
                    next_state = WAIT_EOP_SEND_DATA;
                end
                else // Not addressed to me
                begin
                    next_state = WAIT_EOP_IDLE;
                end
            end

            CHECK_ADDR_MEH_RCVD:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;
                
                // 6-bit Address should be on the read bus
                if (MY_ADDR == rcv_bus[5:0])
                begin
                    next_state = WAIT_EOP_SEND_NAK;
                end
                else // Not addressed to me
                begin
                    next_state = WAIT_EOP_IDLE;
                end
            end

            WAIT_EOP_SEND_DATA:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;                

                if (0 == is_rcv_empty) // Stuff in the rcv buffer, clear it
                begin
                    read_rcv_fifo = 1;
                    next_state = WAIT_EOP_SEND_DATA;
                end
                else // Rcv buffer empty.  Don't advance read pointer
                begin
                    read_rcv_fifo = 0;
                    next_state = WAIT_EOP_SEND_DATA;
                end

                if (1 == is_eop_rcvd) // EOP received, let the TXPU know to send data
                begin
                    next_state = TX_DATA;
                end
            end

            WAIT_EOP_SEND_NAK:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;                

                if (0 == is_rcv_empty) // Stuff in the rcv buffer, clear it
                begin
                    read_rcv_fifo = 1;
                    next_state = WAIT_EOP_SEND_NAK;
                end
                else // Rcv buffer empty.  Don't advance read pointer
                begin
                    read_rcv_fifo = 0;
                    next_state = WAIT_EOP_SEND_NAK;
                end

                if (1 == is_eop_rcvd) // EOP received, let the TXPU know to send NAK
                begin
                    next_state = TX_NAK;
                end
            end
            
            WAIT_EOP_IDLE:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;

                if (0 == is_rcv_empty) // Stuff in the rcv buffer, clear it
                begin
                    read_rcv_fifo = 1;
                    next_state = WAIT_EOP_IDLE;
                end
                else // Rcv buffer empty.  Don't advance read pointer
                begin
                    read_rcv_fifo = 0;
                    next_state = WAIT_EOP_IDLE;
                end
                if (1 == is_eop_rcvd) // EOP received, prepare to go idle
                begin
                    next_state = IDLE;
                end
            end

            TX_DATA:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;

                if (0 == is_data_ready) // Data isn't ready, tell TXPU to send NAK instead
                begin
                    next_state = TX_NAK;
                end
                else
                begin
                    send_data = 1;
                    next_state = IDLE;
                end
            end
            
            TX_NAK:
            begin
                send_data = 0;
                read_rcv_fifo = 0;
                send_nak = 1;
                next_state = IDLE;
            end

            default:
            begin
                send_data = 0;
                send_nak = 0;
                read_rcv_fifo = 0;
                next_state = IDLE;
            end
                
        endcase
    end

endmodule
