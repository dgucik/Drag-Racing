`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2021 20:30:25
// Design Name: 
// Module Name: delay_for_menu_napisy
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


module delay_for_menu_napisy(
    input wire clk,
    input wire rst,
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire vsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    output reg [10:0] hcount_out_d,
    output reg [10:0] vcount_out_d,
    output reg hsync_out_d,
    output reg vsync_out_d,
    output reg hblnk_out_d,
    output reg vblnk_out_d
    );
    
    reg [10:0] hcount_d, vcount_d;
    reg hsync_d, vsync_d, hblnk_d, vblnk_d;
    
    always @(posedge clk) begin
        if(rst) begin
            hcount_d <= 0;
            vcount_d <= 0;
            hsync_d <= 0;
            vsync_d <= 0;
            hblnk_d <= 0;
            vblnk_d <= 0;   
            
            hcount_out_d <= 0;
            vcount_out_d <= 0;
            hsync_out_d <= 0;
            vsync_out_d <= 0;
            hblnk_out_d <= 0;
            vblnk_out_d <= 0;            
        end
        else begin
            hcount_d <= hcount_in;
            vcount_d <= vcount_in;
            hsync_d <= hsync_in;
            vsync_d <= vsync_in;
            hblnk_d <= hblnk_in;
            vblnk_d <= vblnk_in;
            
            hcount_out_d <= hcount_d;
            vcount_out_d <= vcount_d;
            hsync_out_d <= hsync_d;
            vsync_out_d <= vsync_d;
            hblnk_out_d <= hblnk_d;
            vblnk_out_d <= vblnk_d;
        end
    end
    
    
endmodule
