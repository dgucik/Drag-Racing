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

    localparam  WALL_HOR_POS = 200,
                WALL_VER_POS = 375;

    localparam  BARRIER_HOR_POS = 600,
                BARRIER_VER_POS = 395;

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

            //START BARRIER
            if(         (hcount_in >= BARRIER_HOR_POS + 10) && (hcount_in <= BARRIER_HOR_POS + 15) && (vcount_in >= BARRIER_VER_POS + 10) && (vcount_in <= BARRIER_VER_POS + 11) ||
                        (hcount_in >= BARRIER_HOR_POS + 12) && (hcount_in <= BARRIER_HOR_POS + 13) && (vcount_in >= BARRIER_VER_POS + 8) && (vcount_in <= BARRIER_VER_POS + 13) ||

                        (hcount_in >= BARRIER_HOR_POS + 86) && (hcount_in <= BARRIER_HOR_POS + 91) && (vcount_in >= BARRIER_VER_POS + 10) && (vcount_in <= BARRIER_VER_POS + 11) ||
                        (hcount_in >= BARRIER_HOR_POS + 88) && (hcount_in <= BARRIER_HOR_POS + 89) && (vcount_in >= BARRIER_VER_POS + 8) && (vcount_in <= BARRIER_VER_POS + 13) ||

                        (hcount_in >= BARRIER_HOR_POS + 186) && (hcount_in <= BARRIER_HOR_POS + 191) && (vcount_in >= BARRIER_VER_POS + 10) && (vcount_in <= BARRIER_VER_POS + 11) ||
                        (hcount_in >= BARRIER_HOR_POS + 188) && (hcount_in <= BARRIER_HOR_POS + 189) && (vcount_in >= BARRIER_VER_POS + 8) && (vcount_in <= BARRIER_VER_POS + 13)
                )
                rgb_out_nxt = 12'h333;

            else if(    (hcount_in >= BARRIER_HOR_POS + 0) && (hcount_in <= BARRIER_HOR_POS + 215) && (vcount_in >= BARRIER_VER_POS + 8) && (vcount_in <= BARRIER_VER_POS + 14)
                )
                rgb_out_nxt = 12'h444;

            else if(    (hcount_in >= BARRIER_HOR_POS + 8) && (hcount_in <= BARRIER_HOR_POS + 18) && (vcount_in >= BARRIER_VER_POS + 22) && (vcount_in <= BARRIER_VER_POS + 39) ||
                        (hcount_in >= BARRIER_HOR_POS + 84) && (hcount_in <= BARRIER_HOR_POS + 94) && (vcount_in >= BARRIER_VER_POS + 22) && (vcount_in <= BARRIER_VER_POS + 39) ||
                        (hcount_in >= BARRIER_HOR_POS + 184) && (hcount_in <= BARRIER_HOR_POS + 194) && (vcount_in >= BARRIER_VER_POS + 22) && (vcount_in <= BARRIER_VER_POS + 39)
                )
                rgb_out_nxt = 12'h777;

            else if(    (hcount_in >= BARRIER_HOR_POS + 0) && (hcount_in <= BARRIER_HOR_POS + 215) && (vcount_in >= BARRIER_VER_POS + 2) && (vcount_in <= BARRIER_VER_POS + 20)
                )
                rgb_out_nxt = 12'hbbb;

            else if(    (hcount_in >= BARRIER_HOR_POS + 0) && (hcount_in <= BARRIER_HOR_POS + 215) && (vcount_in >= BARRIER_VER_POS + 0) && (vcount_in <= BARRIER_VER_POS + 22) ||
                        (hcount_in >= BARRIER_HOR_POS + 7) && (hcount_in <= BARRIER_HOR_POS + 19) && (vcount_in >= BARRIER_VER_POS + 23) && (vcount_in <= BARRIER_VER_POS + 39) ||
                        (hcount_in >= BARRIER_HOR_POS + 83) && (hcount_in <= BARRIER_HOR_POS + 95) && (vcount_in >= BARRIER_VER_POS + 23) && (vcount_in <= BARRIER_VER_POS + 39) ||
                        (hcount_in >= BARRIER_HOR_POS + 183) && (hcount_in <= BARRIER_HOR_POS + 195) && (vcount_in >= BARRIER_VER_POS + 23) && (vcount_in <= BARRIER_VER_POS + 39)
                )
                rgb_out_nxt = 12'h000;
            //END BARRIER

            //START WALL
            else if(    (hcount_in == WALL_HOR_POS + 9) && (vcount_in >= WALL_VER_POS + 31) && (vcount_in <= WALL_VER_POS + 44) ||
                        (hcount_in >= WALL_HOR_POS + 1) && (hcount_in <= WALL_HOR_POS + 2) && (vcount_in == WALL_VER_POS + 26) ||
                        (hcount_in == WALL_HOR_POS + 2) && (vcount_in >= WALL_VER_POS + 13) && (vcount_in <= WALL_VER_POS + 25) ||
                        (hcount_in == WALL_HOR_POS + 3) && (vcount_in >= WALL_VER_POS + 2) && (vcount_in <= WALL_VER_POS + 13) ||
                        (hcount_in >= WALL_HOR_POS + 4) && (hcount_in <= WALL_HOR_POS + 6) && (vcount_in == WALL_VER_POS + 1) ||
                        (hcount_in == WALL_HOR_POS + 6) && (vcount_in >= WALL_VER_POS + 2) && (vcount_in <= WALL_VER_POS + 15) ||

                        (hcount_in >= WALL_HOR_POS + 7) && (hcount_in <= WALL_HOR_POS + 8) && (vcount_in == WALL_VER_POS + 15) ||
                        (hcount_in == WALL_HOR_POS + 8) && (vcount_in >= WALL_VER_POS + 16) && (vcount_in <= WALL_VER_POS + 31) ||
                        (hcount_in >= WALL_HOR_POS + 5) && (hcount_in <= WALL_HOR_POS + 499) && (vcount_in == WALL_VER_POS + 0) ||
                        (hcount_in == WALL_HOR_POS + 499) && (vcount_in >= WALL_VER_POS + 1) && (vcount_in <= WALL_VER_POS + 14) ||
                        (hcount_in >= WALL_HOR_POS + 500) && (hcount_in <= WALL_HOR_POS + 502) && (vcount_in == WALL_VER_POS + 14) ||
                        (hcount_in == WALL_HOR_POS + 502) && (vcount_in >= WALL_VER_POS + 15) && (vcount_in <= WALL_VER_POS + 23) ||

                        (hcount_in == WALL_HOR_POS + 503) && (vcount_in >= WALL_VER_POS + 24) && (vcount_in <= WALL_VER_POS + 44) ||
                        (hcount_in >= WALL_HOR_POS + 6) && (hcount_in <= WALL_HOR_POS + 503) && (vcount_in == WALL_VER_POS + 45) ||
                        (hcount_in == WALL_HOR_POS + 0) && (vcount_in >= WALL_VER_POS + 26) && (vcount_in <= WALL_VER_POS + 41) ||
                        (hcount_in == WALL_HOR_POS + 1) && (vcount_in == WALL_VER_POS + 42) ||
                        (hcount_in == WALL_HOR_POS + 2) && (vcount_in == WALL_VER_POS + 43) ||
                        (hcount_in >= WALL_HOR_POS + 3) && (hcount_in <= WALL_HOR_POS + 5) && (vcount_in == WALL_VER_POS + 44)
                )
                rgb_out_nxt = 12'h000;

            else if(    (hcount_in >= WALL_HOR_POS + 3) && (hcount_in <= WALL_HOR_POS + 8) && (vcount_in >= WALL_VER_POS + 16) && (vcount_in <= WALL_VER_POS + 43) ||
                        (hcount_in >= WALL_HOR_POS + 1) && (hcount_in <= WALL_HOR_POS + 2) && (vcount_in >= WALL_VER_POS + 27) && (vcount_in <= WALL_VER_POS + 41) ||
                        (hcount_in == WALL_HOR_POS + 2) && (vcount_in == WALL_VER_POS + 42) ||
                        (hcount_in >= WALL_HOR_POS + 6) && (hcount_in <= WALL_HOR_POS + 8) && (vcount_in == WALL_VER_POS + 44) ||
                        (hcount_in == WALL_HOR_POS + 3) && (vcount_in >= WALL_VER_POS + 14) && (vcount_in <= WALL_VER_POS + 15) ||
                        (hcount_in >= WALL_HOR_POS + 4) && (hcount_in <= WALL_HOR_POS + 5) && (vcount_in >= WALL_VER_POS + 2) && (vcount_in <= WALL_VER_POS + 15)
                )
                rgb_out_nxt = 12'h444;
            else if(    (hcount_in >= WALL_HOR_POS + 7) && (hcount_in <= WALL_HOR_POS + 498) && (vcount_in >= WALL_VER_POS + 1) && (vcount_in <= WALL_VER_POS + 44) ||
                        (hcount_in >= WALL_HOR_POS + 499) && (hcount_in <= WALL_HOR_POS + 501) && (vcount_in >= WALL_VER_POS + 15) && (vcount_in <= WALL_VER_POS + 44) ||
                        (hcount_in == WALL_HOR_POS + 502) && (vcount_in >= WALL_VER_POS + 24) && (vcount_in <= WALL_VER_POS + 44)
                )
                rgb_out_nxt = 12'h888;
            //END WALL

            //START WHITE LINE
            else if( (hcount_in >= 595) && (hcount_in <= 603) && (vcount_in >= 275) && (vcount_in <= 560) )
                rgb_out_nxt = 12'hfff;
            //END WHITE LINE

            else rgb_out_nxt = rgb_in;
        end
    end

endmodule