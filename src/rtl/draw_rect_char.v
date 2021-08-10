`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2021 13:46:07
// Design Name: 
// Module Name: draw_rect
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


module draw_rect_char(
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out,
    //output reg [10:0] addr,
    //output wire [7:0] char_xy,
    output wire [8:0] char_xy,
    output wire [3:0] char_line,
    
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [11:0] rgb_in,
    input wire [7:0] char_pixels,
    
    input wire clk,
    input wire rst
    );    
    
    reg [11:0] rgb_out_nxt;
    wire [10:0] hcount_x;
    wire [10:0] vcount_y;
    
    localparam X_CHAR_RECT = 427;
    localparam Y_CHAR_RECT = 100;
    localparam X_WIDTH = 168;
    localparam Y_WIDTH = 256;
    
    always@(posedge clk) begin
        if(rst) begin
            hcount_out <= 0;
            vcount_out <= 0;
            hsync_out <= 0;
            hblnk_out <= 0;
            vsync_out <= 0;
            vblnk_out <= 0;
            rgb_out <= 0;
        end
        else begin
            hcount_out <= hcount_in;
            vcount_out <= vcount_in;
            hsync_out <= hsync_in;
            hblnk_out <= hblnk_in;
            vsync_out <= vsync_in;
            vblnk_out <= vblnk_in;
            rgb_out <= rgb_out_nxt;
        end
    end
    
    always@* begin            
        if((hblnk_in || vblnk_in) == 0) begin
            if((hcount_in > X_CHAR_RECT)&&(hcount_in < X_CHAR_RECT + X_WIDTH)&&(vcount_in > Y_CHAR_RECT)&&(vcount_in < Y_CHAR_RECT + Y_WIDTH)) begin
                if(char_pixels[4'b1000 - hcount_x[2:0]]) rgb_out_nxt = 12'hf_f_f;
                else rgb_out_nxt = rgb_in;    //rgb_out_nxt = 12'h0_f_0;
            end
            else rgb_out_nxt = rgb_in;    
        end
        else rgb_out_nxt = 12'h0_0_0;
    end
    
    assign char_xy = {vcount_y[7:4],hcount_x[7:3]};
    assign char_line = vcount_y[3:0];
    
    assign hcount_x = hcount_in - X_CHAR_RECT;
    assign vcount_y = vcount_in - Y_CHAR_RECT;
    
endmodule
