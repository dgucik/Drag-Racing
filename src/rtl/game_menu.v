`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2021 18:08:57
// Design Name: 
// Module Name: game_menu
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


module game_menu(
    input wire clk,
    input wire rst,
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire vsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    input wire [3:0] keyboard_in,
    input wire back_to_main_menu_flag,
    output wire hsync_out,
    output wire vsync_out,
    output wire [11:0] rgb_out,
    output wire start_game_flag
    );
    
    //menu_background
    wire [10:0] menu_hcount, menu_vcount, menu_hcount_2, menu_vcount_2;
    wire menu_hsync, menu_hblnk, menu_vsync, menu_vblnk, menu_hsync_2, menu_hblnk_2, menu_vsync_2, menu_vblnk_2;
    wire [11:0] menu_rgb, menu_rgb_2;
    wire [2:0] menu_state;
    wire [1:0] menu_counter;
    
    //menu_pointer
    wire menu_pointer_hsync, menu_pointer_vsync;
    wire [11:0] menu_pointer_rgb;
    wire [10:0] x_pointer, y_pointer;
    
    //delay_for_xypos_pointer
    wire [10:0] x_pointer_delay, y_pointer_delay;
    
    //delay_for_start_game
    wire start_game, start_game_delay;

    menu_background menu_background(
    .clk(clk),
    .rst(rst),
    .hcount_in(hcount_in),
    .vcount_in(vcount_in),
    .hsync_in(hsync_in),
    .vsync_in(vsync_in),
    .hblnk_in(hblnk_in),
    .vblnk_in(vblnk_in),
    .hcount_out(menu_hcount),
    .vcount_out(menu_vcount),
    .hsync_out(menu_hsync),
    .vsync_out(menu_vsync),
    .hblnk_out(menu_hblnk),
    .vblnk_out(menu_vblnk),
    .rgb_out(menu_rgb)
    );
    
    menu_page_of menu_page(
    .clk(clk),
    .rst(rst),
    .keyboard_in(keyboard_in),
    .menu_state(menu_state),
    .menu_counter(menu_counter),
    .back_to_main_menu_flag(back_to_main_menu_flag)
    );
    
    menu_napisy menu_napisy(
    .clk(clk),
    .rst(rst),
    .hcount_in(menu_hcount),
    .vcount_in(menu_vcount),
    .hsync_in(menu_hsync),
    .vsync_in(menu_vsync),
    .hblnk_in(menu_hblnk),
    .vblnk_in(menu_vblnk),
    .rgb_in(menu_rgb),
    .hsync_out(menu_hsync_2),
    .vsync_out(menu_vsync_2),
    .hcount_out(menu_hcount_2),
    .vcount_out(menu_vcount_2),
    .hblnk_out(menu_hblnk_2),
    .vblnk_out(menu_vblnk_2),
    .rgb_out(menu_rgb_2),
    .menu_state(menu_state)
    );
    
    state_and_counter_to_xypos xypos_pointer(
    .menu_state(menu_state),
    .menu_counter(menu_counter),
    .x_pointer(x_pointer),
    .y_pointer(y_pointer),
    .clk(clk),
    .rst(rst)
    );
    
    delay_for_xypointer delay_for_xypointer(
    .clk(clk),
    .rst(rst),
    .x_pointer(x_pointer),
    .y_pointer(y_pointer),
    .x_pointer_out_d(x_pointer_delay),
    .y_pointer_out_d(y_pointer_delay)
    );
    
    rect menu_pointer(
    .clk(clk),
    .rst(rst),
    .hcount_in(menu_hcount_2),
    .vcount_in(menu_vcount_2),
    .hsync_in(menu_hsync_2),
    .vsync_in(menu_vsync_2),
    .hblnk_in(menu_hblnk_2),
    .vblnk_in(menu_vblnk_2),
    .rgb_in(menu_rgb_2),
    .x_pointer(x_pointer_delay),
    .y_pointer(y_pointer_delay),
    .hsync_out(menu_pointer_hsync),
    .vsync_out(menu_pointer_vsync),
    .rgb_out(menu_pointer_rgb)
    );
    
    menu_start_game_flag menu_start_game_flag(
    .clk(clk),
    .rst(rst),
    .menu_state(menu_state),
    .start_game(start_game)
    );
    
    delay_for_start_game_flag delay_for_start_game_flag(
    .clk(clk),
    .rst(rst),
    .start_game(start_game),
    .start_game_out_d(start_game_delay)
    ); 
       
    assign vsync_out = menu_pointer_vsync;
    assign hsync_out = menu_pointer_hsync;
    assign rgb_out = menu_pointer_rgb;
    
    assign start_game_flag = start_game_delay;
    
endmodule
