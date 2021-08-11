`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2021 01:32:40
// Design Name: 
// Module Name: menu_napisy
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


module menu_napisy(
    output wire [10:0] hcount_out,
    output wire [10:0] vcount_out,
    output wire hblnk_out,
    output wire vblnk_out,
    output wire hsync_out,
    output wire vsync_out,
    output wire [11:0] rgb_out,
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hblnk_in,
    input wire vblnk_in,
    input wire hsync_in,
    input wire vsync_in,
    input wire [11:0] rgb_in,
    input wire [2:0] menu_state,
    input wire clk,
    input wire rst
    );
    
    //menu_rect_char
    wire [10:0] menu_rect_char_hcount, menu_rect_char_vcount;
    wire menu_rect_char_hsync, menu_rect_char_hblnk, menu_rect_char_vsync, menu_rect_char_vblnk;
    wire [11:0] menu_rect_char_rgb;
    wire [8:0] menu_rect_char_char_xy;
    wire [3:0] menu_rect_char_char_line;
    wire [7:0] menu_rect_char_char_pixels;
    wire [6:0] char_code;    
    
    draw_rect_char draw_rect_char_menu(
    .clk(clk),
    .rst(rst),
    .hcount_in(hcount_in),
    .vcount_in(vcount_in),
    .hsync_in(hsync_in),
    .vsync_in(vsync_in),
    .hblnk_in(hblnk_in),
    .vblnk_in(vblnk_in),
    .rgb_in(rgb_in),
    .char_xy(menu_rect_char_char_xy),
    .char_pixels(menu_rect_char_char_pixels),
    .char_line(menu_rect_char_char_line),
    .hsync_out(hsync_out),
    .vsync_out(vsync_out),
    .hblnk_out(hblnk_out),
    .vblnk_out(vblnk_out),
    .hcount_out(hcount_out),
    .vcount_out(vcount_out),
    .rgb_out(rgb_out)
    );
    
    char_rom_20x16 char_rom_20x16(
    .char_xy(menu_rect_char_char_xy),
    .char_code(char_code),
    .menu_state(menu_state)
    );
    
     font_rom font_rom(
    .clk(clk),
    .addr({char_code,menu_rect_char_char_line}),
    .char_line_pixels(menu_rect_char_char_pixels)
    );       
    
endmodule
