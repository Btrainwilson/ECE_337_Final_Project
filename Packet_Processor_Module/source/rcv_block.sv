// $Id: $
// File name:   rcv_block.sv
// Created:     2/5/2018
// Author:      Blake Wilson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: RCV Block


module rcv_block (input wire clk,
 			n_rst,
 			serial_in,
			data_read, 
			output reg [7:0] rx_data, 
			output reg data_ready,
			overrun_error,
			framing_error);


	//Architecture Assignment Blocks

	//Start bit detector
	wire Start_Bit_Bus;

	start_bit_det start_bit_detect(.clk(clk),.n_rst(n_rst),.serial_in(serial_in),.start_bit_detected(Start_Bit_Bus));

	//9 Bit Shift Register
	wire [7:0] Packet_Data_Bus;

	wire Stop_Bit_Bus;

	wire Shift_Strobe_Bus;

	sr_9bit bit9 (.clk(clk),.n_rst(n_rst),.serial_in(serial_in),.stop_bit(Stop_Bit_Bus),.shift_strobe(Shift_Strobe_Bus),.packet_data(Packet_Data_Bus));

	
	//Stop Bit checker

	reg SBC_Clear_Bus;

	reg SBC_Enable_Bus;

	reg Framing_Error_Bus;

	stop_bit_chk stop_bit_checker (.clk(clk),.n_rst(n_rst),.sbc_clear(SBC_Clear_Bus),.sbc_enable(SBC_Enable_Bus),.stop_bit(Stop_Bit_Bus),.framing_error(Framing_Error_Bus));

	//RX Data Buffer

	reg Load_Buffer_Bus;
	
	rx_data_buff RX_DATA (.clk(clk),.n_rst(n_rst),.load_buffer(Load_Buffer_Bus),.packet_data(Packet_Data_Bus),.data_read(data_read),.rx_data(rx_data),.data_ready(data_ready),.overrun_error(overrun_error));

	//RCU Block
	reg Packet_Done_Bus;
	reg Enable_Timer_Bus;
	
	rcu RCU_BLOCK (.clk(clk),.n_rst(n_rst),.start_bit_detected(Start_Bit_Bus),.packet_done(Packet_Done_Bus),.framing_error(Framing_Error_Bus),.sbc_clear(SBC_Clear_Bus),.sbc_enable(SBC_Enable_Bus),.load_buffer(Load_Buffer_Bus),.enable_timer(Enable_Timer_Bus));

	//Timing Controller 
	

	timer Tim_Block(.clk(clk),.n_rst(n_rst),.enable_timer(Enable_Timer_Bus),.shift_strobe(Shift_Strobe_Bus),.packet_done(Packet_Done_Bus));

	assign framing_error = Framing_Error_Bus;


endmodule
