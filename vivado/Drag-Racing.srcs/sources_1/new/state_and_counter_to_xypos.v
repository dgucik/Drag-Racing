`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2021 14:16:24
// Design Name: 
// Module Name: state_and_counter_to_xypos
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


module state_and_counter_to_xypos(
    input wire clk,
    input wire rst,
    input wire [2:0] menu_state,
    input wire [1:0] menu_counter,
    output reg [10:0] x_pointer,
    output reg [10:0] y_pointer    
    );                              
    
    localparam Main = 0;
    localparam StartGame = 1;
    localparam Control = 2;
    localparam About = 3;
    localparam Exit = 4;    
    
    reg [10:0] x_pointer_nxt, y_pointer_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            x_pointer <= 0;
            y_pointer <= 0;
        end
        else begin
            x_pointer <= x_pointer_nxt;
            y_pointer <= y_pointer_nxt;
        end
    end
    
    always@* begin
        case(menu_state)
            Main: begin
                if(menu_counter == 0) begin
                    x_pointer_nxt = 451;
                    y_pointer_nxt = 228; 
                end
                else if(menu_counter == 1) begin
                    x_pointer_nxt = 451;
                    y_pointer_nxt = 260;
                end
                else if(menu_counter == 2) begin
                    x_pointer_nxt = 451;
                    y_pointer_nxt = 292;
                end
                else if(menu_counter == 3) begin
                    x_pointer_nxt = 451;
                    y_pointer_nxt = 324;
                end
                else begin 
                    x_pointer_nxt = 1024;
                    y_pointer_nxt = 0;
                end
            end
            
            StartGame: begin
                x_pointer_nxt = 1024;
                y_pointer_nxt = 0;
            end
            
            Control: begin
                x_pointer_nxt = 515;
                y_pointer_nxt = 340;
            end
            
            About: begin
                x_pointer_nxt = 515;
                y_pointer_nxt = 340;
            end
            
            Exit: begin
                if(menu_counter == 0) begin
                    x_pointer_nxt = 427;
                    y_pointer_nxt = 244;
                end
                else if(menu_counter == 1) begin
                    x_pointer_nxt = 427;
                    y_pointer_nxt = 276;
                end
                else begin 
                    x_pointer_nxt = 1024;
                    y_pointer_nxt = 0;
                end
            end
        endcase
    end    
endmodule
