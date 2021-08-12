module draw_start(
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire vsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    input wire [11:0] rgb_in, 
    input wire clk,
    input wire reset,
    input wire [31:0] position,
    output reg [10:0] hcount_out,
    output reg [10:0] vcount_out,
    output reg hsync_out,
    output reg vsync_out,
    output reg hblnk_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out
    );

    localparam  WALL_HOR_OFF = 200,
                WALL_VER_OFF = 375;

    reg [11:0] rgb_out_nxt;
    reg [10:0] hcount_out_nxt, vcount_out_nxt;
    reg hsync_out_nxt, hblnk_out_nxt, vsync_out_nxt, vblnk_out_nxt;

    always @(posedge clk) begin
        if(reset) begin
            hcount_out <= 0;
            vcount_out <= 0;
            hblnk_out <= 0;
            vblnk_out <= 0;
            hsync_out <= 0;
            vsync_out <= 0;
            rgb_out <= 0;
        end 
        else begin
            hcount_out <= hcount_out_nxt;
            vcount_out <= vcount_out_nxt;
            hblnk_out <= hblnk_out_nxt;
            vblnk_out <= vblnk_out_nxt;
            hsync_out <= hsync_out_nxt;
            vsync_out <= vsync_out_nxt;
            rgb_out <= rgb_out_nxt;
        end
    end

// 200 - 703, 375 - 420

    always @* begin
        hcount_out_nxt = hcount_in; 
        hsync_out_nxt = hsync_in;
        hblnk_out_nxt = hblnk_in;
        vcount_out_nxt = vcount_in;
        vsync_out_nxt = vsync_in;
        vblnk_out_nxt = vblnk_in;
        // During blanking, make it it black.
        if(hblnk_in||vblnk_in) rgb_out_nxt = 12'h0_0_0;
        else begin
            if(         (hcount_in == WALL_HOR_OFF + 9) && (vcount_in >= WALL_VER_OFF + 31) && (vcount_in <= WALL_VER_OFF + 44) ||
                        (hcount_in >= WALL_HOR_OFF + 1) && (hcount_in <= WALL_HOR_OFF + 2) && (vcount_in == WALL_VER_OFF + 26) ||
                        (hcount_in == WALL_HOR_OFF + 2) && (vcount_in >= WALL_VER_OFF + 13) && (vcount_in <= WALL_VER_OFF + 25) ||
                        (hcount_in == WALL_HOR_OFF + 3) && (vcount_in >= WALL_VER_OFF + 2) && (vcount_in <= WALL_VER_OFF + 13) ||
                        (hcount_in >= WALL_HOR_OFF + 4) && (hcount_in <= WALL_HOR_OFF + 6) && (vcount_in == WALL_VER_OFF + 1) ||
                        (hcount_in == WALL_HOR_OFF + 6) && (vcount_in >= WALL_VER_OFF + 2) && (vcount_in <= WALL_VER_OFF + 15) ||

                        (hcount_in >= WALL_HOR_OFF + 7) && (hcount_in <= WALL_HOR_OFF + 8) && (vcount_in == WALL_VER_OFF + 15) ||
                        (hcount_in == WALL_HOR_OFF + 8) && (vcount_in >= WALL_VER_OFF + 16) && (vcount_in <= WALL_VER_OFF + 31) ||
                        (hcount_in >= WALL_HOR_OFF + 5) && (hcount_in <= WALL_HOR_OFF + 499) && (vcount_in == WALL_VER_OFF + 0) ||
                        (hcount_in == WALL_HOR_OFF + 499) && (vcount_in >= WALL_VER_OFF + 1) && (vcount_in <= WALL_VER_OFF + 14) ||
                        (hcount_in >= WALL_HOR_OFF + 500) && (hcount_in <= WALL_HOR_OFF + 502) && (vcount_in == WALL_VER_OFF + 14) ||
                        (hcount_in == WALL_HOR_OFF + 502) && (vcount_in >= WALL_VER_OFF + 15) && (vcount_in <= WALL_VER_OFF + 23) ||

                        (hcount_in == WALL_HOR_OFF + 503) && (vcount_in >= WALL_VER_OFF + 24) && (vcount_in <= WALL_VER_OFF + 44) ||
                        (hcount_in >= WALL_HOR_OFF + 6) && (hcount_in <= WALL_HOR_OFF + 503) && (vcount_in == WALL_VER_OFF + 45) ||
                        (hcount_in == WALL_HOR_OFF + 0) && (vcount_in >= WALL_VER_OFF + 26) && (vcount_in <= WALL_VER_OFF + 41) ||
                        (hcount_in == WALL_HOR_OFF + 1) && (vcount_in == WALL_VER_OFF + 42) ||
                        (hcount_in == WALL_HOR_OFF + 2) && (vcount_in == WALL_VER_OFF + 43) ||
                        (hcount_in >= WALL_HOR_OFF + 3) && (hcount_in <= WALL_HOR_OFF + 5) && (vcount_in == WALL_VER_OFF + 44)
                )
                rgb_out_nxt = 12'h000;

            else if(    (hcount_in >= WALL_HOR_OFF + 3) && (hcount_in <= WALL_HOR_OFF + 8) && (vcount_in >= WALL_VER_OFF + 16) && (vcount_in <= WALL_VER_OFF + 43) ||
                        (hcount_in >= WALL_HOR_OFF + 1) && (hcount_in <= WALL_HOR_OFF + 2) && (vcount_in >= WALL_VER_OFF + 27) && (vcount_in <= WALL_VER_OFF + 41) ||
                        (hcount_in == WALL_HOR_OFF + 2) && (vcount_in == WALL_VER_OFF + 42) ||
                        (hcount_in >= WALL_HOR_OFF + 6) && (hcount_in <= WALL_HOR_OFF + 8) && (vcount_in == WALL_VER_OFF + 44) ||
                        (hcount_in == WALL_HOR_OFF + 3) && (vcount_in >= WALL_VER_OFF + 14) && (vcount_in <= WALL_VER_OFF + 15) ||
                        (hcount_in >= WALL_HOR_OFF + 4) && (hcount_in <= WALL_HOR_OFF + 5) && (vcount_in >= WALL_VER_OFF + 2) && (vcount_in <= WALL_VER_OFF + 15)
                )
                rgb_out_nxt = 12'h444;
            else if(    (hcount_in >= WALL_HOR_OFF + 7) && (hcount_in <= WALL_HOR_OFF + 498) && (vcount_in >= WALL_VER_OFF + 1) && (vcount_in <= WALL_VER_OFF + 44) ||
                        (hcount_in >= WALL_HOR_OFF + 499) && (hcount_in <= WALL_HOR_OFF + 501) && (vcount_in >= WALL_VER_OFF + 15) && (vcount_in <= WALL_VER_OFF + 44) ||
                        (hcount_in == WALL_HOR_OFF + 502) && (vcount_in >= WALL_VER_OFF + 24) && (vcount_in <= WALL_VER_OFF + 44)
                )
                rgb_out_nxt = 12'h888;

            else rgb_out_nxt = rgb_in;
        end
    end

endmodule