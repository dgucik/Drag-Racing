module kb_interface (
    input wire clk, 
    input wire reset,
    input wire ps2_clk,
    input wire ps2_data,
    output wire [3:0] kb_key_pressed
);

    //ps2_rx
    wire rx_done_tick;
    wire [7:0] dout;

    //keyboard
    wire key_pressed;
    wire [7:0] key_code;

    ps2_rx u_ps2_rx (
        .clk(clk),
        .reset(reset),
        .rx_en(1'b1),
        .ps2c(ps2_clk),
        .ps2d(ps2_data),
        .rx_done_tick(rx_done_tick),
        .dout(dout)
    );

    keyboard u_keyboard (
        .clk(clk), 
        .reset(reset),
        .din(dout),
        .scan_done_tick(rx_done_tick),
        .code_new(),
        .key_pressed(key_pressed),
        .key_code(key_code)
    );

    kb_game_code u_kb_game_code(
        .clk(clk),
        .reset(reset),
        .key_pressed(key_pressed),
        .key_code(key_code),
        .kb_key_pressed(kb_key_pressed)
    );

endmodule