module kb_interface (
    input wire clk, 
    input wire rst,
    input wire ps2_clk,
    input wire ps2_data,
    output reg kb_key_pressed
);

    //ps2_rx
    wire rx_done_tick;
    wire [7:0] dout;

    //keyboard
    wire code_new, key_pressed;
    wire [7:0] key_code;

    ps2_rx u_ps2_rx (
        .clk(clk),
        .reset(rst),
        .rx_en(1'b1),
        .ps2c(ps2_clk),
        .ps2d(ps2_data),
        .rx_done_tick(rx_done_tick),
        .dout(dout)
    );

    keyboard u_keyboard (
        .clk(clk), 
        .reset(rst),
        .din(dout),
        .scan_done_tick(scan_done_tick),
        .code_new(code_new),
        .key_pressed(key_pressed),
        .key_code(key_code)
    );

endmodule