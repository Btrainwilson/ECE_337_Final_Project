// Id:         mg43
// File name:   txpu.sv
// Created:     4/17/2018
// Author:      The Tragedy of Darth Plagueis the Wise
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: The TXPU!!!! *cross-arms*

module txpu
(
    input wire clk,
    input wire n_rst,
    input wire Load_Byte, // From byte transmitter, signals 1 byte sent
    input wire send_nak, // From RXPU, signals need to send NAK
    input wire send_data, // From RXPU, signals need to send data
    input wire EOD, // From Byte transmitter, signals 64 bytes are sent
    input reg send_crc, // Tells CRC module to transmit its calculated CRC through the bitstuffer
    
    output reg [7:0] FSM_byte, // TXPU ready-to-go bytes
    output reg load_en, // Load enable for the byte transmitter
    output reg [1:0]select, // Mux selector for the byte transmitter chooses whether to send FIFO or TXPU byte
    output reg Tim_rst, // Resets timer's internal 64-byte counter
    output reg Tim_en, // Enables the timer to transmit
    output reg eop, // This Signal...
    output reg eop_new_bit, // ...and this one need to be asserted to send EOP
    output reg fifo_r_enable, // Tells Jackson's FIFO to place the next bte on the lines
    output reg is_txing, // Connects to RXPU (keeps it idle)
    output reg calc_crc, // Tells CRC module to calculate CRC on current data streaming over USB TX
    output reg crc_reset // reset for CRC calculator
   
);
    
    localparam SYNC_BYTE = 8'b10000000; // SYNC Byte
    localparam NAK_PID = 8'b01011010; // NAK PID is 1010
    localparam DATA1_PID = 8'b01001011; // DATA1 PID is 1011
    localparam SEL_FSM_BYTE = 2'b01; // Select FSM
    localparam SEL_FIFO_BYTE = 2'b00; // Select FIFO 
    localparam SEL_CRC_HIGH = 2'b10; // Select CRC 15:8
    localparam SEL_CRC_LOW = 2'b11; // Select CRC 7:0
    localparam IDLE_BYTE = 8'b11111111; // Placeholder IDLE bytes between data completion and CRC calculation completion. 

    typedef enum reg [3:0] {
        IDLE,
        SEND_NAK_PID,
        WAIT_NAK_FIN,
        SEND_DATA_SYNC,
        WAIT_DATA_SYNC_FIN,
        WAIT_DATA_PID_FIN,
        QUEUE_DATA_BYTE,
        WAIT_DATA_FIN,
	SEND_CRC_IDLE,
        SEND_CRC_BYTE_1,
        SEND_CRC_BYTE_2,
        SEND_EOP_BIT_1,
        SEND_EOP_BIT_2,
        SEND_IDLE,
	WAIT_FOR_CRC_BYTE_2_SEND  
    } TX_States;

    TX_States state, next_state;
    
    // State Machine
    always_ff @ (posedge clk, negedge n_rst)
    begin: TXPU_STATE_REG
        if (0 == n_rst)
        begin
            state <= IDLE;
        end
        else
        begin
            state <= next_state;
        end
    end
    
    // Next State + Output Logic
    always_comb
    begin: TXPU_NXTST_LOGIC
        case (state)
            IDLE:
            begin
                FSM_byte = SYNC_BYTE;
                load_en = 0;
                select = SEL_FSM_BYTE;
                Tim_rst = 1; // Keep timer clear active until needed                
                Tim_en = 0;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0;
                is_txing = 0;
                calc_crc = 0;
		crc_reset = 1;
                
                if (1 == send_nak)
                begin
                    next_state = SEND_NAK_PID; // Send a NAK (single byte)
                    Tim_en = 1; // Enable the timer early
                    Tim_rst = 0; // and lower the reset!
                end
                else if (1 == send_data)
                begin
                    next_state = SEND_DATA_SYNC; // Send the SYNC packet!
                    Tim_en = 1; // Enable the timer early
                    Tim_rst = 0; // and lower the reset!
                end
                else
                begin
                    next_state = IDLE;
                end
            end
            
            SEND_NAK_PID: // Places the NAK byte onto the transmitter
            begin
                FSM_byte = NAK_PID; // Ready the NAK byte
                load_en = 1; // Trigger the loading of NAK byte
                select = SEL_FSM_BYTE; // Send from TXPU
                Tim_rst = 0;              
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0;
                is_txing = 1; // Now transmitting
                calc_crc = 0;
		crc_reset = 1;                

                next_state = WAIT_NAK_FIN;
            end
            
            WAIT_NAK_FIN: // Waits for NAK byte to finish transmitting
            begin
                FSM_byte = NAK_PID; // Might as well keep NAK on the lines
                load_en = 0; // Lower Load_en signal
                select = SEL_FSM_BYTE;
                Tim_rst = 0;              
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0;
                is_txing = 1;
                calc_crc = 0;
		crc_reset = 1;  

                if (1 == Load_Byte) // NAK sent!
                begin
                    next_state = IDLE;
                end
                else
                begin
                    next_state = WAIT_NAK_FIN; // Stay in this state until it's done
                end
            end

            SEND_DATA_SYNC: // Send the SYNC byte to the transmitter
            begin
                FSM_byte = SYNC_BYTE; // Ready the SYNC byte
                load_en = 1; // Trigger Load up of the SYNC byte
                select = SEL_FSM_BYTE; // Send from TXPU
                Tim_rst = 0;              
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0;
                is_txing = 1;
                calc_crc = 0;
		crc_reset = 1;  

                next_state = WAIT_DATA_SYNC_FIN;
            end
            
            WAIT_DATA_SYNC_FIN: // Waits for SYNC to finish transmitting
            begin
                FSM_byte = DATA1_PID; // Put the PID on the bus in advance
                load_en = 0; // Lower the load enable 
                select = SEL_FSM_BYTE; // Send from TXPU
                Tim_rst = 0;              
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0;
                is_txing = 1;
                calc_crc = 0;
		crc_reset = 1;
                
                if (1 == Load_Byte) // Sync byte sent!  System now sending PID
                begin
                    next_state = WAIT_DATA_PID_FIN; // Go wait for the PID to finish up
                end
                else
                begin
                    next_state = WAIT_DATA_SYNC_FIN; // Stay in this state to wait for SYNC byte to finish
                end 
            end

            WAIT_DATA_PID_FIN: // Waits for PID to finish transmitting
            begin
                FSM_byte = DATA1_PID;
                load_en = 0;
                select = SEL_FIFO_BYTE; // Switch over to Jackson's FIFO - a byte awaits!
                Tim_rst = 0;              
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0; // No need to enable FIFO because byte is ready and waiting
                is_txing = 1;
                calc_crc = 0;
		crc_reset = 1;
                
                if (1 == Load_Byte) // PID byte sent!  System now starting to send data byte
                begin
                    next_state = QUEUE_DATA_BYTE; // Queue up the next byte!
                    Tim_rst = 1; // Reset the internal counter so we know when 64 bytes have been fired out
                    calc_crc = 0; // Wait until data sent to activate CRC calc
		    crc_reset = 0;
                end
                else
                begin
                    next_state = WAIT_DATA_PID_FIN; // Stay in this state to wait for PID to finish
                end
            end

            QUEUE_DATA_BYTE: // This state occurs WHILE a byte is being transmitted, queueing a fresh databyte
            begin
                FSM_byte = DATA1_PID;
                load_en = 0;
                select = SEL_FIFO_BYTE;
                Tim_rst = 0; // Put reset back down              
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 1; // Slap the next byte from Jackson's FIFO on the bus so it'll be ready
                is_txing = 1;
                calc_crc = 0; // Wait until all data is sent to do CRC
		crc_reset = 0;

                next_state = WAIT_DATA_FIN; // Go wait for the byte currently being transmitted to finish up
            end
            
            // Waits for byte currently being sent to finish (another one is already ready to go).
            // As soon as it's done, the transmitter starts on the next byte and it'll be time to prepare another one
            WAIT_DATA_FIN: 
            begin
                FSM_byte = DATA1_PID;
                load_en = 0;
                select = SEL_FIFO_BYTE;
                Tim_rst = 0;            
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0; // Lower FIFO read again
                is_txing = 1;
                calc_crc = 0; // wait for it
		crc_reset = 0;

                if (1 == EOD) // 64 bytes away! Go into idle and wait for CRC to complete
                begin
                    next_state = SEND_CRC_IDLE;
		    FSM_byte = IDLE_BYTE;
		    select = SEL_FSM_BYTE; // Go into idle in a cheesy manner
                    // Start CRC calculations in next state
                end
                else if (1 == Load_Byte) // Byte sent!  System now starting on next byte
                begin
                    next_state = QUEUE_DATA_BYTE; // Move to queue the next byte while this one transmits
                end
                else
                begin
                    next_state = WAIT_DATA_FIN; // Stay here and wait for byte to finish
                end
            end


	// Wait for crc calculation to complete
	    SEND_CRC_IDLE:
	    begin
		FSM_byte = IDLE_BYTE;
                load_en = 0;
                select = SEL_FSM_BYTE;
                Tim_rst = 0;            
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0; // Lower FIFO read again
                is_txing = 1;
                calc_crc = 1; // Keep CRC calculations enabled
		crc_reset = 0;
		
		if (send_crc == 1)
		begin
			next_state = SEND_CRC_BYTE_1;
			calc_crc = 1;
			
		end
		else
		begin
			next_state = SEND_CRC_IDLE;
		end
	    end
		

            SEND_CRC_BYTE_1:
            begin
                FSM_byte = DATA1_PID;
                load_en = 0;
                select = SEL_CRC_LOW;
                Tim_rst = 0;          
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0;
                is_txing = 1;
                calc_crc = 1;
		crc_reset = 0;

                if (1 == Load_Byte) // CRC byte 1 sent!  System now sending CRC byte 2
                begin
                    next_state = SEND_CRC_BYTE_2;
                end
                else
                begin
                    next_state = SEND_CRC_BYTE_1; // Stay and wait for CRC byte 1 to be sent
                end
            end
            
            SEND_CRC_BYTE_2:
            begin
                FSM_byte = DATA1_PID;
                load_en = 0;
                select = SEL_CRC_HIGH;
                Tim_rst = 0;          
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0;
                is_txing = 1;
                calc_crc = 1;
		crc_reset = 0;

                if (1 == Load_Byte) // CRC byte 2 sent!  Send the EOP
                begin
                    next_state = WAIT_FOR_CRC_BYTE_2_SEND;
                   	 // Stop sending CRC
                end
                else
                begin
                    next_state = SEND_CRC_BYTE_2; // Stay and wait for CRC byte 2 to be sent
                end
            end

	    WAIT_FOR_CRC_BYTE_2_SEND:
            begin
	    	FSM_byte = DATA1_PID;
                load_en = 0;
                select = SEL_CRC_HIGH;
                Tim_rst = 0;          
                Tim_en = 1;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0;
                is_txing = 1;
                calc_crc = 1;
		crc_reset = 0;

		if (1 == Load_Byte) // CRC byte 2 sent!  Send the EOP
                begin
                    next_state = SEND_EOP_BIT_1;
                   	 // Stop sending CRC
                end
                else
                begin
                    next_state = WAIT_FOR_CRC_BYTE_2_SEND; // Stay and wait for CRC byte 2 to be sent
                end
            end
            
            SEND_EOP_BIT_1:
            begin
                FSM_byte = DATA1_PID;
                load_en = 0;
                select = SEL_FIFO_BYTE;
                Tim_rst = 0;          
                Tim_en = 1;
                eop = 1; // Transmitting EOP!
                eop_new_bit = 1; // Transmitting EOP!
                fifo_r_enable = 0;
                is_txing = 1;
                calc_crc = 0;
		crc_reset = 1;
                 

                next_state = SEND_EOP_BIT_2;
            end

            SEND_EOP_BIT_2:
            begin
                FSM_byte = DATA1_PID;
                load_en = 0;
                select = SEL_FIFO_BYTE;
                Tim_rst = 0;          
                Tim_en = 1;
                eop = 1; // Transmitting EOP!
                eop_new_bit = 1; // Transmitting EOP!
                fifo_r_enable = 0;
                is_txing = 1;
                calc_crc = 0;
		crc_reset = 0;
                 

                next_state = SEND_IDLE;
            end

            SEND_IDLE:
            begin
                FSM_byte = DATA1_PID;
                load_en = 0;
                select = SEL_FIFO_BYTE;
                Tim_rst = 0;          
                Tim_en = 1;
                eop = 0; // No more EOP!
                eop_new_bit = 0; // No more EOP!
                fifo_r_enable = 0;
                is_txing = 1; // Still counts as transmitting
                calc_crc = 0;
		crc_reset = 0;
                 

                next_state = IDLE;
            end

            default:
            begin
                FSM_byte = SYNC_BYTE;
                load_en = 0;
                select = SEL_FSM_BYTE;
                Tim_rst = 1; // Keep timer clear active until needed                
                Tim_en = 0;
                eop = 0;
                eop_new_bit = 0;
                fifo_r_enable = 0;
                is_txing = 0;
                calc_crc = 0;
		crc_reset = 0;
                
                
                next_state = IDLE;
            end
        endcase
    end
endmodule
