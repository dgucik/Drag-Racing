`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2021 21:59:51
// Design Name: 
// Module Name: delay_for_start_game_flag
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


module delay_for_start_game_flag(
    input wire clk,
    input wire rst,
    input wire start_game,
    output reg start_game_out_d
    );
    
    reg start_game_d;
    
    always @(posedge clk) begin
        if(rst) begin
            start_game_d <= 0;
            start_game_out_d <= 0;
        end
        else begin
            start_game_d <= start_game;
            start_game_out_d <= start_game_d;
        end
    end
endmodule
