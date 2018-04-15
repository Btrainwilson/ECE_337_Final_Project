// $Id: $
// File name:   sync_low.sv
// Created:     1/19/2018
// Author:      Luke Upton
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Lab 2 Postlab: Reset to Logic Low Synchronizer

module sync_low
    (
    input wire clk, n_rst, async_in,
    output reg sync_out
    );

    reg intermediate;

    always_ff @ (posedge clk, negedge n_rst)
    begin : flop1
        if(1'b0 == n_rst)
        begin
            intermediate <= 1'b0;
        end
        else
        begin
            intermediate <= async_in;
        end
    end


    always_ff @ (posedge clk, negedge n_rst)
    begin : flop2
        if(1'b0 == n_rst)
        begin
            sync_out <= 1'b0;
        end
        else
        begin
            sync_out <= intermediate;
        end
    end




endmodule
