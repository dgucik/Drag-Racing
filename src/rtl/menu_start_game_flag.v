`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2021 22:02:33
// Design Name: 
// Module Name: menu_start_game_flag
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


module menu_start_game_flag(
    input wire clk,
    input wire rst,
    input wire [2:0] menu_state,
    output reg start_game
    );
    
    reg start_game_nxt;
    
    always @(posedge clk) begin
        if(rst) begin 
            start_game <= 0;
        end 
        else begin
            start_game <= start_game_nxt;
        end
    end
    
    always @* begin
        if(menu_state == 1) start_game_nxt = 1;
        else start_game_nxt = 0;
    end
    
endmodule
