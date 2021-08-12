`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2021 22:50:14
// Design Name: 
// Module Name: flag_try
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


module flag_try(
    input wire clk,
    input wire rst,
    input wire start_game_flag,
    input wire [11:0] rgb_in,
    output reg [11:0] rgb_out
    );
    
    always @* begin
        if(start_game_flag) rgb_out = 12'hc_1_8;
        else rgb_out = rgb_in;
    end
    
endmodule
