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
    input wire [1:0] menu_counter,
    input wire [2:0] menu_state,
    input wire keyboard_in,
    output reg start_game
    );
    
    reg start_game_nxt;
    reg keyboard_in_d;
    
    always @(posedge clk) begin
        if(rst) begin
            keyboard_in_d <= 0; 
            start_game <= 0;
        end 
        else begin
            keyboard_in_d <= keyboard_in;
            start_game <= start_game_nxt;
        end
    end
    
    always @* begin
        if( (menu_state == 4) && (menu_counter == 0) && (keyboard_in_d == 1) ) start_game_nxt = 1;
        else start_game_nxt = 0;
    end
    
endmodule
