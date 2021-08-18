module scoreboard(
    input wire clk,
    input wire reset,
    input wire end_game_status,
    input wire keyboard_in,
    input wire [21:0] time_p1,
    input wire [21:0] time_p2,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [11:0] rgb_in,
    input wire [1:0] pixel_bit_caption,
    output reg key_press_status,
    output reg hsync_out,
    output reg vsync_out,
    output reg [11:0] rgb_out,
    output wire [14:0] pixel_addr 
); 

    wire hsync_del, hblnk_del, vsync_del, vblnk_del;
    wire [10:0] hcount_del, vcount_del;
    wire [11:0] rgb_del;

    delay #(.WIDTH(38)) u_delay(
        .clk(clk),
        .rst(reset),
        .din({rgb_in, hcount_in, hsync_in, hblnk_in, vcount_in, vsync_in, vblnk_in}),
        .dout({rgb_del, hcount_del, hsync_del, hblnk_del, vcount_del, vsync_del, vblnk_del})
    );

    localparam  RESULT_CAP_HOR_POS = 330,
                RESULT_CAP_VER_POS = 200;

    wire [8:0] addrx;
    wire [5:0] addry;

    reg hsync_out_nxt, vsync_out_nxt, key_press_status_nxt;
    reg [11:0] rgb_out_nxt;

    always @(posedge clk) begin
        if(reset) begin
            hsync_out <= 0;
            vsync_out <= 0;
            rgb_out <= 0;
            key_press_status <= 0;
        end
        else begin
            hsync_out <= hsync_out_nxt;
            vsync_out <= vsync_out_nxt;
            rgb_out <= rgb_out_nxt;
            key_press_status <= key_press_status_nxt;
        end
    end

    always @* begin
        hsync_out_nxt = hsync_del;
        vsync_out_nxt = vsync_del;
        rgb_out_nxt = rgb_del;
        key_press_status_nxt = 0;
        if(end_game_status) begin
            key_press_status_nxt = key_press_status;
            if(keyboard_in)
                key_press_status_nxt = 1;
            if(hblnk_del || vblnk_del) rgb_out_nxt = 12'h0_0_0;
            else if((time_p1 < time_p2) && (hcount_del >= RESULT_CAP_HOR_POS) && (hcount_del < RESULT_CAP_HOR_POS + 512) && (vcount_del >= RESULT_CAP_VER_POS) && (vcount_del < RESULT_CAP_VER_POS + 43) && (pixel_bit_caption[0]))
                rgb_out_nxt = 12'hfd0;
            else if((time_p1 >= time_p2) && (hcount_del >= RESULT_CAP_HOR_POS) && (hcount_del < RESULT_CAP_HOR_POS + 512) && (vcount_del >= RESULT_CAP_VER_POS) && (vcount_del < RESULT_CAP_VER_POS + 43) && (pixel_bit_caption[1]))
                rgb_out_nxt = 12'hfd0;
        end
    end

    assign addrx = hcount_in - RESULT_CAP_HOR_POS;
    assign addry = vcount_in - RESULT_CAP_VER_POS;
    assign pixel_addr = {addry[5:0], addrx[8:0]};
endmodule