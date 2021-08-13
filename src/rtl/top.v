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
    
    wire clk_10Hz; //TEST
    
    //clk_gen
    wire locked;
    wire clk100MHz, clk65MHz;
    
    //reset
    wire rst_ext;
    
    //vga_timing
    wire [10:0] vga_vcount, vga_hcount;
    wire vga_vsync, vga_vblnk, vga_hsync, vga_hblnk;

    //draw_car_p2
    wire [10:0] car_hcount_p2, car_vcount_p2;
    wire car_hsync_p2, car_hblnk_p2, car_vsync_p2, car_vblnk_p2;
    wire [11:0] car_rgb_p2;

    //draw_car_p1
    wire [10:0] car_hcount_p1, car_vcount_p1;
    wire car_hsync_p1, car_hblnk_p1, car_vsync_p1, car_vblnk_p1;
    wire [11:0] car_rgb_p1;

    //draw_backgorund
    wire [10:0] background_hcount, background_vcount;
    wire background_hsync, background_hblnk, background_vsync, background_vblnk;
    wire [11:0] background_rgb;

    //draw_start
    wire [10:0] start_hcount, start_vcount;
    wire start_hsync, start_hblnk, start_vsync, start_vblnk;
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
        .clk(clk_10Hz) //TEST
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

    //TEST: ANIMACJA RUCHU
    
    wire [31:0] position;
    wire [3:0] kb_key_pressed;

    kb_interface u_kb_interface(
        .clk(clk100MHz),
        .reset(rst_ext),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .kb_key_pressed(kb_key_pressed)
    );

    clk_divide #(.DIVISOR(1000000)) u_clk_divide(
        .clk_in(clk65MHz),
        .clk_out(clk_10Hz)
    );

    MOV_TEST u_MOV_TEST(
        .clk(clk_10Hz),
        .rst(rst_ext),
        .key(kb_key_pressed[0]),
        .pos(position)
    );

    //KONIEC TESTU: ANIMACJA RUCHU
    
    draw_background u_draw_backgroud(
        .hcount_in(vga_hcount),
        .vcount_in(vga_vcount),
        .hsync_in(vga_hsync),
        .vsync_in(vga_vsync),
        .hblnk_in(vga_hblnk),
        .vblnk_in(vga_vblnk),
        .position(position), //TEST
        .hcount_out(background_hcount),
        .vcount_out(background_vcount),
        .hsync_out(background_hsync),
        .vsync_out(background_vsync),
        .hblnk_out(background_hblnk),
        .vblnk_out(background_vblnk),
        .rgb_out(background_rgb),
        .clk(clk65MHz),
        .reset(rst_ext)
    );

    draw_car #(.RGB_1(12'h09E), .RGB_2(12'h07B), .RGB_3(12'h069)) u_draw_car_p2(
        .clk(clk65MHz),
        .reset(rst_ext),
        .hcount_in(background_hcount),
        .hsync_in(background_hsync),
        .hblnk_in(background_hblnk),
        .vcount_in(background_vcount),
        .vsync_in(background_vsync),
        .vblnk_in(background_vblnk),
        .rgb_in(background_rgb),
        .xpos(256),
        .ypos(335),
        .mov(clk_10Hz),  //TEST   
        .hcount_out(car_hcount_p2),
        .hsync_out(car_hsync_p2),
        .hblnk_out(car_hblnk_p2),
        .vcount_out(car_vcount_p2),
        .vsync_out(car_vsync_p2),
        .vblnk_out(car_vblnk_p2),
        .rgb_out(car_rgb_p2)
    );

    draw_start u_draw_start(
        .hcount_in(car_hcount_p2),
        .vcount_in(car_vcount_p2),
        .hsync_in(car_hsync_p2),
        .vsync_in(car_vsync_p2),
        .hblnk_in(car_hblnk_p2),
        .vblnk_in(car_vblnk_p2),
        .rgb_in(car_rgb_p2),
        .position(position), //TEST
        .hcount_out(start_hcount),
        .vcount_out(start_vcount),
        .hsync_out(start_hsync),
        .vsync_out(start_vsync),
        .hblnk_out(start_hblnk),
        .vblnk_out(start_vblnk),
        .rgb_out(start_rgb),
        .clk(clk65MHz),
        .reset(rst_ext)       
    );

    draw_car u_draw_car_p1(
        .clk(clk65MHz),
        .reset(rst_ext),
        .hcount_in(start_hcount),
        .hsync_in(start_hsync),
        .hblnk_in(start_hblnk),
        .vcount_in(start_vcount),
        .vsync_in(start_vsync),
        .vblnk_in(start_vblnk),
        .rgb_in(start_rgb),
        .xpos(256),
        .ypos(481),
        .mov(clk_10Hz),  //TEST     
        .hcount_out(car_hcount_p1),
        .hsync_out(car_hsync_p1),
        .hblnk_out(car_hblnk_p1),
        .vcount_out(car_vcount_p1),
        .vsync_out(car_vsync_p1),
        .vblnk_out(car_vblnk_p1),
        .rgb_out(car_rgb_p1)
    );
    

    assign vs = car_vsync_p1;
    assign hs = car_hsync_p1;
    assign {r,g,b} = car_rgb_p1;  
endmodule
