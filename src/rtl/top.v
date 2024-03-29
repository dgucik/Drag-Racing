//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik
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
    input wire rx,
    output wire tx,
    output wire [3:0] r,
    output wire [3:0] g,
    output wire [3:0] b,
    output wire vs,
    output wire hs
    );
    
    localparam FINISH_LINE_POS = 25000;

    //***status-flags***//
    wire light_signals_status;
    wire player1_finish_status, player2_finish_status;
    wire start_game_status;
    wire key_press_status;

    //clk_gen
    wire locked;
    wire clk100MHz, clk65MHz;
    
    //reset
    wire rst_ext;

    //reset_clk
    wire clk_reset;
    
    //vga_timing
    wire [10:0] vga_vcount, vga_hcount;
    wire vga_vsync, vga_vblnk, vga_hsync, vga_hblnk;

    //kb_interface  
    wire kb_W_key, kb_S_key, kb_K_key, kb_Shift_key, kb_Enter_key;
    wire kb_W_key_tick, kb_S_key_tick, kb_K_key_tick, kb_Shift_key_tick, kb_Enter_key_tick;

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
    wire [11:0] timer_seconds_light;

    //player1_timer
    wire [21:0] timer_seconds_miliseconds_p1;

    //player2_timer
    wire [21:0] timer_seconds_miliseconds_p2;

    //game_menu
    wire menu_hsync, menu_vsync;
    wire [11:0] menu_rgb;
    wire start_game_status_p1;

    //scoreboard
    wire scoreboard_hsync, scoreboard_vsync;
    wire [11:0] scoreboard_rgb;
    wire [14:0] scoreboard_pixel_addr;
    wire key_press_status_p1; 
    
    //flag_status
    wire fs_key_press_status_tick_p1;

    //caption_rom
    wire [1:0] caption_pixel;

    //gear_and_velocity_p1
    wire [1:0] gv_current_gear; 
    wire gv_next_gear_status;
    wire [31:0] gv_position_p1;
    wire [4:0] gv_d_position_p1;

    //wheel_movement_p1
    wire wheel_mov_p1; 
    
    //wheel_movement_p2
    wire wheel_mov_p2;

    //draw_cockpit
    wire [10:0] cockpit_hcount, cockpit_vcount;
    wire cockpit_hsync, cockpit_hblnk, cockpit_vsync, cockpit_vblnk;
    wire [11:0] cockpit_rgb;

    //uart_ff_buff
    wire [7:0] uart_r_data;
    wire uart_tx_full, uart_rx_empty;
    
    //p1_and_p2_data
    wire [7:0] data_p1_out_data;
    wire data_wr_uart, data_rd_uart;
    wire [31:0] data_position_p2;
    wire data_start_game_status_p2;
    wire data_key_press_status_p2;
    wire data_key_press_status_tick_p2;
    wire [4:0] data_d_position_p2;

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
        .clk(clk_reset)
    );

    clk_divide #(.DIVISOR(6500000)) u_reset_clk(
        .clk_in(clk65MHz),
        .clk_out(clk_reset)
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
        .kb_key_pressed_tick(kb_Shift_key_tick),
        .kb_key_pressed(kb_K_key),
        .reset_status(fs_key_press_status_tick_p1 || data_key_press_status_tick_p2),
        .enable_controller_status((light_signals_status) && !(player1_finish_status)),
        .d_position_out(gv_d_position_p1),
        .position(gv_position_p1),
        .flag_for_readline_diode_in_cockpit(gv_next_gear_status),
        .current_gear(gv_current_gear)
    );

    kb_interface #(.WIDTH(5)) u_kb_interface(
        .clk(clk65MHz),
        .reset(rst_ext),
        .kb_key_pressed({kb_W_key, kb_S_key, kb_K_key, kb_Shift_key, kb_Enter_key}),
        .kb_key_pressed_tick({kb_W_key_tick, kb_S_key_tick, kb_K_key_tick, kb_Shift_key_tick, kb_Enter_key_tick}),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data)
    );

    game_menu u_game_menu(
        .clk(clk65MHz),
        .rst(rst_ext),
        .hcount_in(vga_hcount),
        .vcount_in(vga_vcount),
        .hsync_in(vga_hsync),
        .vsync_in(vga_vsync),
        .hblnk_in(vga_hblnk),
        .vblnk_in(vga_vblnk),
        .keyboard_in({kb_W_key_tick, kb_S_key_tick, kb_Enter_key_tick}),
        .back_to_main_menu_flag(fs_key_press_status_tick_p1 || data_key_press_status_tick_p2), 
        .hsync_out(menu_hsync),
        .vsync_out(menu_vsync),
        .rgb_out(menu_rgb),
        .start_game_flag(start_game_status_p1)
    );
    
    draw_background #(.FINISH_LINE_POS(FINISH_LINE_POS)) u_draw_backgroud(
        .hcount_in(vga_hcount),
        .vcount_in(vga_vcount),
        .hsync_in(vga_hsync),
        .vsync_in(vga_vsync),
        .hblnk_in(vga_hblnk),
        .vblnk_in(vga_vblnk),
        .position(gv_position_p1),
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
        .position(data_position_p2),
        .mov(wheel_mov_p2)
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
        .p1_position(gv_position_p1),
        .p2_position(data_position_p2),
        .mov(wheel_mov_p2),   
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
        .start((start_game_status) && !(light_signals_status)),
        .restart(fs_key_press_status_tick_p1 || data_key_press_status_tick_p2),
        .seconds(timer_seconds_light),
        .miliseconds()
    );

    timer u_player1_timer(
        .clk1KHz(clk_timer),
        .reset(rst_ext),
        .start((light_signals_status) && !(player1_finish_status)),
        .restart(fs_key_press_status_tick_p1 || data_key_press_status_tick_p2),
        .seconds({timer_seconds_miliseconds_p1[21:10]}),
        .miliseconds({timer_seconds_miliseconds_p1[9:0]})
    );

    timer u_player2_timer(
        .clk1KHz(clk_timer),
        .reset(rst_ext),
        .start((light_signals_status) && !(player2_finish_status)),
        .restart(fs_key_press_status_tick_p1 || data_key_press_status_tick_p2),
        .seconds({timer_seconds_miliseconds_p2[21:10]}),
        .miliseconds({timer_seconds_miliseconds_p2[9:0]})
    );

    draw_start u_draw_start(
        .hcount_in(car_hcount_p2),
        .vcount_in(car_vcount_p2),
        .hsync_in(car_hsync_p2),
        .vsync_in(car_vsync_p2),
        .hblnk_in(car_hblnk_p2),
        .vblnk_in(car_vblnk_p2),
        .rgb_in(car_rgb_p2),
        .position(gv_position_p1),
        .seconds(timer_seconds_light),
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
        .position(gv_position_p1),
        .mov(wheel_mov_p1)
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
        .mov(wheel_mov_p1),    
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
        .current_gear(gv_current_gear),
        .gear_change_status(gv_next_gear_status),
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
        .keyboard_in(kb_Enter_key_tick),
        .time_p1(timer_seconds_miliseconds_p1),
        .time_p2(timer_seconds_miliseconds_p2),
        .hcount_in(cockpit_hcount),
        .hsync_in(cockpit_hsync),
        .hblnk_in(cockpit_hblnk),
        .vcount_in(cockpit_vcount),
        .vsync_in(cockpit_vsync),
        .vblnk_in(cockpit_vblnk),
        .rgb_in(cockpit_rgb),
        .pixel_bit_caption(caption_pixel),
        .key_press_status(key_press_status_p1),
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

    flag_status u_flag_status(
        .clk(clk65MHz),
        .reset(rst_ext),
        .clear((!key_press_status_p1) && (!data_key_press_status_p2) && (!start_game_status_p1) && (!data_start_game_status_p2)),
        .set(key_press_status),
        .status(fs_key_press_status_tick_p1)
    );

    p1_and_p2_data u_p1_and_p2_data(
        .clk(clk65MHz),
        .rst(rst_ext),
        .p1_in_data({fs_key_press_status_tick_p1, key_press_status_p1, start_game_status_p1, gv_d_position_p1}),
        .wr_uart(data_wr_uart),
        .p1_out_data(data_p1_out_data),
        .tx_full(uart_tx_full),
        .p2_in_data(uart_r_data),
        .rd_uart(data_rd_uart),
        .p2_out_data({data_key_press_status_tick_p2, data_key_press_status_p2, data_start_game_status_p2, data_d_position_p2}),
        .rx_empty(uart_rx_empty)
    );

    uart_ff_buf u_uart_ff_buf(
        .clk(clk65MHz),
        .reset(rst_ext),
        .w_data(data_p1_out_data),
        .r_data(uart_r_data),
        .wr_uart(data_wr_uart),
        .rd_uart(data_rd_uart),
        .tx_full(uart_tx_full),
        .rx_empty(uart_rx_empty),
        .rx(rx),
        .tx(tx)
    );

    player2_position u_player2_position(
        .clk(clk65MHz),
        .rst(rst_ext),
        .reset_status(fs_key_press_status_tick_p1 || data_key_press_status_tick_p2),
        .d_position(data_d_position_p2),
        .position(data_position_p2)
    );

    //status wires
    assign light_signals_status = (timer_seconds_light == 5);
    assign player1_finish_status = (gv_position_p1 >= FINISH_LINE_POS);
    assign player2_finish_status = (data_position_p2 >= FINISH_LINE_POS);
    assign start_game_status = (start_game_status_p1 && data_start_game_status_p2);
    assign key_press_status = (key_press_status_p1 && data_key_press_status_p2);
    
    //output wires
    assign vs = (start_game_status)? scoreboard_vsync:menu_vsync;
    assign hs = (start_game_status)? scoreboard_hsync:menu_hsync;
    assign {r,g,b} = (start_game_status)? scoreboard_rgb:menu_rgb;  
     
endmodule