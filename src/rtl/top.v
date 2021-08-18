//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik, Patryk Koci?ski
// 
// Create Date: 20.07.2021 21:23:01
// Design Name: -
// Module Name: top
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is top module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
    input wire clk,
    input wire rst,
    input wire ps2_clk,
    input wire ps2_data,
    output wire [3:0] r,
    output wire [3:0] g,
    output wire [3:0] b,
    output wire vs,
    output wire hs
    );
    
    //clk_gen
    wire locked;
    wire clk100MHz, clk65MHz;
    
    //reset
    wire rst_ext;
    
    //vga_timing
    wire [10:0] vga_vcount, vga_hcount;
    wire vga_vsync, vga_vblnk, vga_hsync, vga_hblnk;

    wire [11:0] start_rgb;

    clk_gen u_clk_gen (
        .clk100MHz(clk100MHz),
        .clk65MHz(clk65MHz),
        .reset(rst),
        .locked(locked),
        .clk(clk)
    );
     
    reset u_reset (
        .rst(rst_ext),
        .locked(locked),
        .clk(clk65MHz)
    );
    
    vga_timing u_vga_timing (
        .vga_vcount(vga_vcount),
        .vga_vsync(vga_vsync),
        .vga_vblnk(vga_vblnk),
        .vga_hcount(vga_hcount),
        .vga_hsync(vga_hsync),
        .vga_hblnk(vga_hblnk),
        .clk(clk65MHz)    
    );
    
    wire scoreboard_hsync, scoreboard_vsync;
    wire [11:0] scoreboard_rgb;
    wire [1:0] image_pixel;
    wire [14:0] scoreboard_pixel_addr;

  scoreboard u_scoreboard (
    .clk(clk65MHz),
    .reset(rst_ext),
    .end_game_status(1),
    .keyboard_in(0),
    .time_p1(30),
    .time_p2(40),
    .hcount_in(vga_hcount),
    .hsync_in(vga_hsync),
    .hblnk_in(vga_hblnk),
    .vcount_in(vga_vcount),
    .vsync_in(vga_vsync),
    .vblnk_in(vga_vblnk),
    .rgb_in(12'hfff),
    .pixel_bit_caption(image_pixel),
    .key_press_status(),
    .hsync_out(scoreboard_hsync),
    .vsync_out(scoreboard_vsync),
    .rgb_out(scoreboard_rgb),
    .pixel_addr(scoreboard_pixel_addr) 
  );
    
    caption_rom u_caption_rom(
        .clk(clk65MHz),
        .address(scoreboard_pixel_addr),
        .pixel_bit(image_pixel) 
    );

    assign vs = scoreboard_vsync;
    assign hs = scoreboard_hsync;
    assign {r,g,b} = scoreboard_rgb;  
endmodule