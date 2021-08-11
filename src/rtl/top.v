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
    
    //menu
    wire [10:0] menu_hcount, menu_vcount, menu_hcount_2, menu_vcount_2;
    wire menu_hsync, menu_hblnk, menu_vsync, menu_vblnk, menu_hsync_2, menu_hblnk_2, menu_vsync_2, menu_vblnk_2;
    wire [11:0] menu_rgb, menu_rgb_2;
    wire [2:0] menu_state;
    wire [1:0] menu_counter;
    
    //menu_pointer
    wire menu_pointer_hsync, menu_pointer_vsync;
    wire [11:0] menu_pointer_rgb;
    wire [10:0] x_pointer, y_pointer;
    
    
    //font_room
    wire [10:0] addr;

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
/*    
    draw_background u_draw_backgroud(
        .hcount_in(vga_hcount),
        .vcount_in(vga_vcount),
        .hsync_in(vga_hsync),
        .vsync_in(vga_vsync),
        .hblnk_in(vga_hblnk),
        .vblnk_in(vga_vblnk),
        .hcount_out(background_hcount),
        .vcount_out(background_vcount),
        .hsync_out(background_hsync),
        .vsync_out(background_vsync),
        .hblnk_out(background_hblnk),
        .vblnk_out(background_vblnk),
        .rgb_out(background_rgb),
        .clk(clk65MHz),
        .rst(rst_ext)
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
        .ypos(345),
        .mov(1),        
        .hcount_out(car_hcount_p2),
        .hsync_out(car_hsync_p2),
        .hblnk_out(car_hblnk_p2),
        .vcount_out(car_vcount_p2),
        .vsync_out(car_vsync_p2),
        .vblnk_out(car_vblnk_p2),
        .rgb_out(car_rgb_p2)
    );

    draw_car u_draw_car_p1(
        .clk(clk65MHz),
        .reset(rst_ext),
        .hcount_in(car_hcount_p2),
        .hsync_in(car_hsync_p2),
        .hblnk_in(car_hblnk_p2),
        .vcount_in(car_vcount_p2),
        .vsync_in(car_vsync_p2),
        .vblnk_in(car_vblnk_p2),
        .rgb_in(car_rgb_p2),
        .xpos(256),
        .ypos(531),
        .mov(1),        
        .hcount_out(car_hcount_p1),
        .hsync_out(car_hsync_p1),
        .hblnk_out(car_hblnk_p1),
        .vcount_out(car_vcount_p1),
        .vsync_out(car_vsync_p1),
        .vblnk_out(car_vblnk_p1),
        .rgb_out(car_rgb_p1)
    );
*/

    menu menu(
    .clk(clk65MHz),
    .rst(rst_ext),
    .hcount_in(vga_hcount),
    .vcount_in(vga_vcount),
    .hsync_in(vga_hsync),
    .vsync_in(vga_vsync),
    .hblnk_in(vga_hblnk),
    .vblnk_in(vga_vblnk),
    .hcount_out(menu_hcount),
    .vcount_out(menu_vcount),
    .hsync_out(menu_hsync),
    .vsync_out(menu_vsync),
    .hblnk_out(menu_hblnk),
    .vblnk_out(menu_vblnk),
    .rgb_out(menu_rgb)
    );

    menu_napisy menu_napisy(
       .clk(clk65MHz),
       .rst(rst_ext),
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
    
    
//for_keyboard_working
wire [3:0] key_pressed, key_pressed_2;

    kb_interface kb_interface(
    .clk(clk65MHz),
    .reset(rst_ext),
    .kb_key_pressed(key_pressed),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data)
    );

    keyboard_button_rising_edge keyboard_button_rising_edge(
    .clk(clk65MHz),
    .key_pressed(key_pressed),
    .key_pressed_posedge(key_pressed_2)
    );
    
    menu_page_of menu_page(
    .clk(clk65MHz),
    .rst(rst_ext),
    .keyboard_in(key_pressed_2),
    .menu_state(menu_state),
    .menu_counter(menu_counter)
    );
    
    rect menu_pointer(
    .clk(clk65MHz),
    .rst(rst_ext),
    .hcount_in(menu_hcount_2),
    .vcount_in(menu_vcount_2),
    .hsync_in(menu_hsync_2),
    .vsync_in(menu_vsync_2),
    .hblnk_in(menu_hblnk_2),
    .vblnk_in(menu_vblnk_2),
    .rgb_in(menu_rgb_2),
    .hsync_out(menu_pointer_hsync),
    .vsync_out(menu_pointer_vsync),
    .rgb_out(menu_pointer_rgb),
    //.menu_state(menu_state),
    //.menu_counter(menu_counter)
    .x_pointer(x_pointer),
    .y_pointer(y_pointer)
    );
    
    state_and_counter_to_xypos xypos_pointer(
        .menu_state(menu_state),
        .menu_counter(menu_counter),
        .x_pointer(x_pointer),
        .y_pointer(y_pointer),
        .clk(clk65MHz),
        .rst(rst_ext)
    );

//    assign vs = car_vsync_p1;
//    assign hs = car_hsync_p1;
//    assign {r,g,b} = car_rgb_p1;
    
    //assign vs = menu_rect_char_vsync;
    //assign hs = menu_rect_char_hsync;
    //assign {r,g,b} = menu_rect_char_rgb;
    
    //assign vs = menu_vsync_2;
    //assign hs = menu_hsync_2;
    //assign {r,g,b} = menu_rgb_2;
    
    assign vs = menu_pointer_vsync;
    assign hs = menu_pointer_hsync;
    assign {r,g,b} = menu_pointer_rgb;
endmodule
