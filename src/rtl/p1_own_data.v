`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2021 00:04:17
// Design Name: 
// Module Name: p1_own_data
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module p1_own_data(
    input wire clk,
    input wire rst,
    input wire tx_full,
    input wire [7:0] p1_in_data,
    output reg [7:0] p1_out_data,
    output reg wr_uart
    );
    
    reg [7:0] p1_out_data_nxt = 0;
    reg wr_uart_nxt = 0;
    
    always @(posedge clk) begin
        if(rst) begin
            p1_out_data <= 0;
            wr_uart <= 0;
        end
        else begin
            p1_out_data <= p1_out_data_nxt;
            wr_uart <= wr_uart_nxt;
        end
    end
    
    always @* begin
        p1_out_data_nxt = p1_in_data;
        
        if(~tx_full) wr_uart_nxt = 1'b1;
        else wr_uart_nxt = 1'b0;
        
        
    end
    
endmodule
