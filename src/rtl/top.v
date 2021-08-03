//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik, Patryk Koci�ski
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

    //draw_car
    wire [10:0] car_hcount_out, car_vcount_out;
    wire car_hsync_out, car_hblnk_out, car_vsync_out, car_vblnk_out;
    wire [18:0] pixel_addr;
    wire [11:0] car_rgb_out;

    //image_rom
    wire [11:0] rom_rgb;

    draw_car u_draw_car(
        .clk(clk65MHz),
        .reset(rst),
        .car_hcount_in(vga_hcount),
        .car_hsync_in(vga_hsync),
        .car_hblnk_in(vga_hblnk),
        .car_vcount_in(vga_vcount),
        .car_vsync_in(vga_vsync),
        .car_vblnk_in(vga_vblnk),
        .car_rgb_in(12'h0_0_0),
        .car_xpos(200),
        .car_ypos(200),
        .car_rgb_pixel(rom_rgb),

        .car_hcount_out(car_hcount_out),
        .car_hsync_out(car_hsync_out),
        .car_hblnk_out(car_hblnk_out),
        .car_vcount_out(car_vcount_out),
        .car_vsync_out(car_vsync_out),
        .car_vblnk_out(car_vblnk_out),
        .car_rgb_out(car_rgb_out),
        .pixel_addr(pixel_addr)
    );

    image_rom u_image_rom(
        .address(pixel_addr),
        .rgb(rom_rgb),
        .clk(clk65MHz)
    );
    
    assign vs = car_vsync_out;
    assign hs = car_hsync_out;
    assign {r,g,b} = car_rgb_out;  
endmodule
