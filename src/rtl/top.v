//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik, Patryk Kocinski
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
    
    localparam FINISH_LINE_POS = 25000;

    //status
    wire light_signals_status;
    wire player1_finish_status, player2_finish_status;

    //clk_gen
    wire locked;
    wire clk100MHz, clk65MHz;
    
    //reset
    wire rst_ext;
    
    //vga_timing
    wire [10:0] vga_vcount, vga_hcount;
    wire vga_vsync, vga_vblnk, vga_hsync, vga_hblnk;

    //kb_interface  
    wire W_key, S_key, K_key, Shift_key, Enter_key;
    wire W_key_tick, S_key_tick, K_key_tick, Shift_key_tick, Enter_key_tick;

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

    //timer_clk
    wire clk_timer;

    //light_signals_timer
    wire [11:0] light_timer_seconds;

    //player_timer
    wire [21:0] player1_timer_seconds_miliseconds, player2_timer_seconds_miliseconds;

    //game_menu
    wire menu_hsync, menu_vsync;
    wire [11:0] menu_rgb;
    wire menu_start_game_status;

    //scoreboard also caption_rom
    wire clk_controller;
    wire scoreboard_hsync, scoreboard_vsync;
    wire [11:0] scoreboard_rgb;
    wire [14:0] scoreboard_pixel_addr;
    wire [1:0] caption_pixel;
    wire scoreboard_key_press_status, scoreboard_key_press_status_tick;

    //gear_and_velocity_p1 && p2
    wire [1:0] controller_current_gear; 
    wire controller_next_gear_status;
    wire [31:0] p1_position;
    wire [31:0] p2_position;

    //wheel_movement_p1 && p2
    wire p2_mov, p1_mov;

    //draw_cockpit
    wire [10:0] cockpit_hcount, cockpit_vcount;
    wire cockpit_hsync, cockpit_hblnk, cockpit_vsync, cockpit_vblnk;
    wire [11:0] cockpit_rgb;

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
        .clk(clk_controller)
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

    gear_and_velocity  u_gear_and_velocity_p1(
        .clk(clk65MHz),
        .rst(rst_ext),
        .kb_key_pressed_tick(Shift_key_tick),
        .kb_key_pressed(K_key),
        .reset_status(scoreboard_key_press_status_tick),
        .enable_controller_status((light_signals_status) && !(player1_finish_status)),
        .position(p1_position),
        .flag_for_readline_diode_in_cockpit(controller_next_gear_status),
        .current_gear(controller_current_gear),
        .slow_clk_out(clk_controller)
    );

    //------TEST for second player---------------------
    gear_and_velocity  u_gear_and_velocity_p2(
        .clk(clk65MHz),
        .rst(rst_ext),
        .kb_key_pressed_tick(S_key_tick),
        .kb_key_pressed(W_key),
        .reset_status(scoreboard_key_press_status_tick),
        .enable_controller_status((light_signals_status) && !(player2_finish_status)),
        .position(p2_position),
        .flag_for_readline_diode_in_cockpit(),
        .current_gear(),
        .slow_clk_out()
    );
    //--------------------------------------------------

    kb_interface #(.WIDTH(5)) kb_interface(
        .clk(clk65MHz),
        .reset(rst_ext),
        .kb_key_pressed({W_key, S_key, K_key, Shift_key, Enter_key}),
        .kb_key_pressed_tick({W_key_tick, S_key_tick, K_key_tick, Shift_key_tick, Enter_key_tick}),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data)
    );

    game_menu game_menu(
        .clk(clk65MHz),
        .rst(rst_ext),
        .hcount_in(vga_hcount),
        .vcount_in(vga_vcount),
        .hsync_in(vga_hsync),
        .vsync_in(vga_vsync),
        .hblnk_in(vga_hblnk),
        .vblnk_in(vga_vblnk),
        .keyboard_in({W_key_tick, S_key_tick, Enter_key_tick}),
        .back_to_main_menu_flag(scoreboard_key_press_status_tick), 
        .hsync_out(menu_hsync),
        .vsync_out(menu_vsync),
        .rgb_out(menu_rgb),
        .start_game_flag(menu_start_game_status)
    );
    
    draw_background #(.FINISH_LINE_POS(FINISH_LINE_POS)) u_draw_backgroud(
        .hcount_in(vga_hcount),
        .vcount_in(vga_vcount),
        .hsync_in(vga_hsync),
        .vsync_in(vga_vsync),
        .hblnk_in(vga_hblnk),
        .vblnk_in(vga_vblnk),
        .position(p1_position),
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

    wheel_movement u_wheel_movement_p2(
        .clk(clk65MHz),
        .reset(rst_ext),
        .position(p2_position),
        .mov(p2_mov)
    );

    draw_car #(.RGB_1(12'h09E), .RGB_2(12'h07B), .RGB_3(12'h069), .XPOS(256), .YPOS(335)) u_draw_car_p2(
        .clk(clk65MHz),
        .reset(rst_ext),
        .hcount_in(background_hcount),
        .hsync_in(background_hsync),
        .hblnk_in(background_hblnk),
        .vcount_in(background_vcount),
        .vsync_in(background_vsync),
        .vblnk_in(background_vblnk),
        .rgb_in(background_rgb),
        .p1_position(p1_position),
        .p2_position(p2_position),
        .mov(p2_mov),   
        .hcount_out(car_hcount_p2),
        .hsync_out(car_hsync_p2),
        .hblnk_out(car_hblnk_p2),
        .vcount_out(car_vcount_p2),
        .vsync_out(car_vsync_p2),
        .vblnk_out(car_vblnk_p2),
        .rgb_out(car_rgb_p2)
    );

    clk_divide #(.DIVISOR(65000)) u_timer_clk(
        .clk_in(clk65MHz),
        .clk_out(clk_timer)
    );

    timer u_light_signals_timer(
        .clk1KHz(clk_timer),
        .reset(rst_ext),
        .start((menu_start_game_status) && !(light_signals_status)),
        .restart(scoreboard_key_press_status_tick),
        .seconds(light_timer_seconds),
        .miliseconds()
    );

    timer u_player1_timer(
        .clk1KHz(clk_timer),
        .reset(rst_ext),
        .start((light_signals_status) && !(player1_finish_status)),
        .restart(scoreboard_key_press_status_tick),
        .seconds({player1_timer_seconds_miliseconds[21:10]}),
        .miliseconds({player1_timer_seconds_miliseconds[9:0]})
    );

    timer u_player2_timer(
        .clk1KHz(clk_timer),
        .reset(rst_ext),
        .start((light_signals_status) && !(player2_finish_status)),
        .restart(scoreboard_key_press_status_tick),
        .seconds({player2_timer_seconds_miliseconds[21:10]}),
        .miliseconds({player2_timer_seconds_miliseconds[9:0]})
    );

    draw_start u_draw_start(
        .hcount_in(car_hcount_p2),
        .vcount_in(car_vcount_p2),
        .hsync_in(car_hsync_p2),
        .vsync_in(car_vsync_p2),
        .hblnk_in(car_hblnk_p2),
        .vblnk_in(car_vblnk_p2),
        .rgb_in(car_rgb_p2),
        .position(p1_position),
        .seconds(light_timer_seconds),
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

    wheel_movement u_wheel_movement_p1(
        .clk(clk65MHz),
        .reset(rst_ext),
        .position(p1_position),
        .mov(p1_mov)
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
        .p1_position(0),
        .p2_position(0),
        .mov(p1_mov),    
        .hcount_out(car_hcount_p1),
        .hsync_out(car_hsync_p1),
        .hblnk_out(car_hblnk_p1),
        .vcount_out(car_vcount_p1),
        .vsync_out(car_vsync_p1),
        .vblnk_out(car_vblnk_p1),
        .rgb_out(car_rgb_p1)
    );

    draw_cockpit u_draw_cockpit(
        .clk(clk65MHz),
        .reset(rst_ext),
        .hcount_in(car_hcount_p1),
        .hsync_in(car_hsync_p1),
        .hblnk_in(car_hblnk_p1),
        .vcount_in(car_vcount_p1),
        .vsync_in(car_vsync_p1),
        .vblnk_in(car_vblnk_p1),
        .rgb_in(car_rgb_p1),
        .current_gear(controller_current_gear),
        .gear_change_status(controller_next_gear_status),
        .hcount_out(cockpit_hcount),
        .hsync_out(cockpit_hsync),
        .hblnk_out(cockpit_hblnk),
        .vcount_out(cockpit_vcount),
        .vsync_out(cockpit_vsync),
        .vblnk_out(cockpit_vblnk),
        .rgb_out(cockpit_rgb)
    );

    scoreboard u_scoreboard(
        .clk(clk65MHz),
        .reset(rst_ext),
        .end_game_status((player1_finish_status) && (player2_finish_status)),
        .keyboard_in(Enter_key_tick),
        .time_p1(player1_timer_seconds_miliseconds),
        .time_p2(player2_timer_seconds_miliseconds),
        .hcount_in(cockpit_hcount),
        .hsync_in(cockpit_hsync),
        .hblnk_in(cockpit_hblnk),
        .vcount_in(cockpit_vcount),
        .vsync_in(cockpit_vsync),
        .vblnk_in(cockpit_vblnk),
        .rgb_in(cockpit_rgb),
        .pixel_bit_caption(caption_pixel),
        .key_press_status(scoreboard_key_press_status),
        .hsync_out(scoreboard_hsync),
        .vsync_out(scoreboard_vsync),
        .rgb_out(scoreboard_rgb),
        .pixel_addr(scoreboard_pixel_addr) 
    );

    caption_rom u_caption_rom(
        .clk(clk65MHz),
        .address(scoreboard_pixel_addr),
        .pixel_bit(caption_pixel) 
    );

    rising_edge_detector u_scoreboard_key_press_status_rising_edge(
        .clk(clk_controller),
        .sig_in(scoreboard_key_press_status),
        .sig_out(scoreboard_key_press_status_tick)
    );

    //status wires
    assign light_signals_status = (light_timer_seconds == 5);
    assign player1_finish_status = (p1_position >= FINISH_LINE_POS);
    assign player2_finish_status = (p2_position >= FINISH_LINE_POS);
    
    //output wires
    assign vs = (menu_start_game_status)? scoreboard_vsync:menu_vsync;
    assign hs = (menu_start_game_status)? scoreboard_hsync:menu_hsync;
    assign {r,g,b} = (menu_start_game_status)? scoreboard_rgb:menu_rgb;  
endmodule