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

    localparam  F_BARRIER_HOR_POS = 600,
                F_BARRIER_VER_POS = 395;

    localparam  B_BARRIER_HOR_POS = 600,
                B_BARRIER_VER_POS = 378;

    localparam  LIGHTS_HOR_POS = 785,
                LIGHTS_VER_POS = 135,
                LIGHTS_SPACING = 48; 

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

    always @* begin
        hcount_out_nxt = hcount_in; 
        hsync_out_nxt = hsync_in;
        hblnk_out_nxt = hblnk_in;
        vcount_out_nxt = vcount_in;
        vsync_out_nxt = vsync_in;
        vblnk_out_nxt = vblnk_in;
        if(hblnk_in||vblnk_in) rgb_out_nxt = 12'h0_0_0;
        else begin

            //FRONT BARRIER
            if(         ((F_BARRIER_HOR_POS + 10 <= position && position <= F_BARRIER_HOR_POS + 15) || hcount_in >= F_BARRIER_HOR_POS + 10 - position) && (hcount_in <= F_BARRIER_HOR_POS + 15 - position) && (vcount_in >= F_BARRIER_VER_POS + 10) && (vcount_in <= F_BARRIER_VER_POS + 11) ||
                        ((F_BARRIER_HOR_POS + 12 <= position && position <= F_BARRIER_HOR_POS + 13) || hcount_in >= F_BARRIER_HOR_POS + 12 - position) && (hcount_in <= F_BARRIER_HOR_POS + 13 - position) && (vcount_in >= F_BARRIER_VER_POS + 8) && (vcount_in <= F_BARRIER_VER_POS + 13) ||

                        ((F_BARRIER_HOR_POS + 86 <= position && position <= F_BARRIER_HOR_POS + 91) || hcount_in >= F_BARRIER_HOR_POS + 86 - position) && (hcount_in <= F_BARRIER_HOR_POS + 91 - position) && (vcount_in >= F_BARRIER_VER_POS + 10) && (vcount_in <= F_BARRIER_VER_POS + 11) ||
                        ((F_BARRIER_HOR_POS + 88 <= position && position <= F_BARRIER_HOR_POS + 89) || hcount_in >= F_BARRIER_HOR_POS + 88 - position) && (hcount_in <= F_BARRIER_HOR_POS + 89 - position) && (vcount_in >= F_BARRIER_VER_POS + 8) && (vcount_in <= F_BARRIER_VER_POS + 13) ||

                        ((F_BARRIER_HOR_POS + 186 <= position && position <= F_BARRIER_HOR_POS + 191) || hcount_in >= F_BARRIER_HOR_POS + 186 - position) && (hcount_in <= F_BARRIER_HOR_POS + 191 - position) && (vcount_in >= F_BARRIER_VER_POS + 10) && (vcount_in <= F_BARRIER_VER_POS + 11) ||
                        ((F_BARRIER_HOR_POS + 188 <= position && position <= F_BARRIER_HOR_POS + 189) || hcount_in >= F_BARRIER_HOR_POS + 188 - position) && (hcount_in <= F_BARRIER_HOR_POS + 189 - position) && (vcount_in >= F_BARRIER_VER_POS + 8) && (vcount_in <= F_BARRIER_VER_POS + 13)
                )
                rgb_out_nxt = 12'h333;

            else if(    ((F_BARRIER_HOR_POS <= position && position <= F_BARRIER_HOR_POS + 215) || hcount_in >= F_BARRIER_HOR_POS - position) && (hcount_in <= F_BARRIER_HOR_POS + 215 - position) && (vcount_in >= F_BARRIER_VER_POS + 8) && (vcount_in <= F_BARRIER_VER_POS + 14)
                )
                rgb_out_nxt = 12'h444;

            else if(    ((F_BARRIER_HOR_POS + 8 <= position && position <= F_BARRIER_HOR_POS + 18) || hcount_in >= F_BARRIER_HOR_POS + 8 - position) && (hcount_in <= F_BARRIER_HOR_POS + 18 - position) && (vcount_in >= F_BARRIER_VER_POS + 22) && (vcount_in <= F_BARRIER_VER_POS + 39) ||
                        ((F_BARRIER_HOR_POS + 84 <= position && position <= F_BARRIER_HOR_POS + 94) || hcount_in >= F_BARRIER_HOR_POS + 84 - position) && (hcount_in <= F_BARRIER_HOR_POS + 94 - position) && (vcount_in >= F_BARRIER_VER_POS + 22) && (vcount_in <= F_BARRIER_VER_POS + 39) ||
                        ((F_BARRIER_HOR_POS + 184 <= position && position <= F_BARRIER_HOR_POS + 194) || hcount_in >= F_BARRIER_HOR_POS + 184 - position) && (hcount_in <= F_BARRIER_HOR_POS + 194 - position) && (vcount_in >= F_BARRIER_VER_POS + 22) && (vcount_in <= F_BARRIER_VER_POS + 39)
                )
                rgb_out_nxt = 12'h777;

            else if(    ((F_BARRIER_HOR_POS <= position && position <= F_BARRIER_HOR_POS + 215) || hcount_in >= F_BARRIER_HOR_POS - position) && (hcount_in <= F_BARRIER_HOR_POS + 215 - position) && (vcount_in >= F_BARRIER_VER_POS + 2) && (vcount_in <= F_BARRIER_VER_POS + 20)
                )
                rgb_out_nxt = 12'hbbb;

            else if(    ((F_BARRIER_HOR_POS <= position && position <= F_BARRIER_HOR_POS + 215) || hcount_in >= F_BARRIER_HOR_POS - position) && (hcount_in <= F_BARRIER_HOR_POS + 215 - position) && (vcount_in >= F_BARRIER_VER_POS + 0) && (vcount_in <= F_BARRIER_VER_POS + 22) ||
                        ((F_BARRIER_HOR_POS + 7 <= position && position <= F_BARRIER_HOR_POS + 19) || hcount_in >= F_BARRIER_HOR_POS + 7 - position) && (hcount_in <= F_BARRIER_HOR_POS + 19 - position) && (vcount_in >= F_BARRIER_VER_POS + 23) && (vcount_in <= F_BARRIER_VER_POS + 39) ||
                        ((F_BARRIER_HOR_POS + 83 <= position && position <= F_BARRIER_HOR_POS + 95) || hcount_in >= F_BARRIER_HOR_POS + 83 - position) && (hcount_in <= F_BARRIER_HOR_POS + 95 - position) && (vcount_in >= F_BARRIER_VER_POS + 23) && (vcount_in <= F_BARRIER_VER_POS + 39) ||
                        ((F_BARRIER_HOR_POS + 183 <= position && position <= F_BARRIER_HOR_POS + 195) || hcount_in >= F_BARRIER_HOR_POS + 183 - position) && (hcount_in <= F_BARRIER_HOR_POS + 195 - position) && (vcount_in >= F_BARRIER_VER_POS + 23) && (vcount_in <= F_BARRIER_VER_POS + 39)
                )
                rgb_out_nxt = 12'h000;

            //LIGHTS
            //------------------------------------------------------------------
            else if(    ((LIGHTS_HOR_POS + 12 <= position && position <= LIGHTS_HOR_POS + 18) || hcount_in >= LIGHTS_HOR_POS + 12 - position) && (hcount_in <= LIGHTS_HOR_POS + 18 - position) && (vcount_in >= LIGHTS_VER_POS + 10) && (vcount_in <= LIGHTS_VER_POS + 31) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 24) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + 17) && (vcount_in <= LIGHTS_VER_POS + 26) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in >= LIGHTS_VER_POS + 13) && (vcount_in <= LIGHTS_VER_POS + 29) ||

                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 20) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + 12) ||
                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + 30) ||

                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + 12) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + 30)
                )
                rgb_out_nxt = 12'h441;

            else if(    ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + 16) && (vcount_in <= LIGHTS_VER_POS + 27) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 22) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 22 - position) && (vcount_in >= LIGHTS_VER_POS + 12) && (vcount_in <= LIGHTS_VER_POS + 30) ||
                        ((LIGHTS_HOR_POS + 11 <= position && position <= LIGHTS_HOR_POS + 19) || hcount_in >= LIGHTS_HOR_POS + 11 - position) && (hcount_in <= LIGHTS_HOR_POS + 19 - position) && (vcount_in >= LIGHTS_VER_POS + 9) && (vcount_in <= LIGHTS_VER_POS + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 10 - position) && (vcount_in >= LIGHTS_VER_POS + 11) && (vcount_in <= LIGHTS_VER_POS + 31) ||

                        (hcount_in == LIGHTS_HOR_POS + 8 - position) && (vcount_in == LIGHTS_VER_POS + 15) ||
                        (hcount_in == LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + 12) ||
                        ((LIGHTS_HOR_POS + 20 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 20 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + 31)

                )
                rgb_out_nxt = 12'h000;

            else if(    ((LIGHTS_HOR_POS <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + 17) && (vcount_in <= LIGHTS_VER_POS + 22) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + 8) && (vcount_in <= LIGHTS_VER_POS + 30) ||
                        ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + 9) && (vcount_in <= LIGHTS_VER_POS + 30) ||

                        ((LIGHTS_HOR_POS + 5 <= position && position <= LIGHTS_HOR_POS + 6) || hcount_in >= LIGHTS_HOR_POS + 5 - position) && (hcount_in <= LIGHTS_HOR_POS + 6 - position) && (vcount_in >= LIGHTS_VER_POS + 10) && (vcount_in <= LIGHTS_VER_POS + 29) ||
                        ((LIGHTS_HOR_POS + 3 <= position && position <= LIGHTS_HOR_POS + 4) || hcount_in >= LIGHTS_HOR_POS + 3 - position) && (hcount_in <= LIGHTS_HOR_POS + 4 - position) && (vcount_in >= LIGHTS_VER_POS + 12) && (vcount_in <= LIGHTS_VER_POS + 27) ||
                        (hcount_in == LIGHTS_HOR_POS + 2 - position) && (vcount_in >= LIGHTS_VER_POS + 13) && (vcount_in <= LIGHTS_VER_POS + 26) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + 23) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + 28) ||
                        (hcount_in == LIGHTS_HOR_POS + 6 - position) && (vcount_in == LIGHTS_VER_POS + 30) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 23) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 23 - position) && (vcount_in >= LIGHTS_VER_POS + 31) && (vcount_in <= LIGHTS_VER_POS + 34) ||

                        (hcount_in == LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + 31) && (vcount_in <= LIGHTS_VER_POS + 32) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 9) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 9 - position) && (vcount_in >= LIGHTS_VER_POS + 31) && (vcount_in <= LIGHTS_VER_POS + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 7 - position) && (vcount_in == LIGHTS_VER_POS + 31) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + 33) ||
                        (hcount_in == LIGHTS_HOR_POS + 25 - position) && (vcount_in == LIGHTS_VER_POS + 31)
                )
                rgb_out_nxt = 12'h111;
            //------------------------------------------------------------------
            else if(    ((LIGHTS_HOR_POS + 12 <= position && position <= LIGHTS_HOR_POS + 18) || hcount_in >= LIGHTS_HOR_POS + 12 - position) && (hcount_in <= LIGHTS_HOR_POS + 18 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 10) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 31) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 24) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 17) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 26) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 13) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 29) ||

                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 20) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 12) ||
                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 30) ||

                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 12) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 30)
                )
                rgb_out_nxt = 12'h441;

            else if(    ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 16) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 27) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 22) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 22 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 12) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 11 <= position && position <= LIGHTS_HOR_POS + 19) || hcount_in >= LIGHTS_HOR_POS + 11 - position) && (hcount_in <= LIGHTS_HOR_POS + 19 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 9) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 10 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 11) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 31) ||

                        (hcount_in == LIGHTS_HOR_POS + 8 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 15) ||
                        (hcount_in == LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 12) ||
                        ((LIGHTS_HOR_POS + 20 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 20 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 31)

                )
                rgb_out_nxt = 12'h000;

            else if(    ((LIGHTS_HOR_POS <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 17) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 22) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 8) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 9) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 30) ||

                        ((LIGHTS_HOR_POS + 5 <= position && position <= LIGHTS_HOR_POS + 6) || hcount_in >= LIGHTS_HOR_POS + 5 - position) && (hcount_in <= LIGHTS_HOR_POS + 6 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 10) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 29) ||
                        ((LIGHTS_HOR_POS + 3 <= position && position <= LIGHTS_HOR_POS + 4) || hcount_in >= LIGHTS_HOR_POS + 3 - position) && (hcount_in <= LIGHTS_HOR_POS + 4 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 12) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 27) ||
                        (hcount_in == LIGHTS_HOR_POS + 2 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 13) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 26) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 23) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 28) ||
                        (hcount_in == LIGHTS_HOR_POS + 6 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 23) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 23 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 34) ||

                        (hcount_in == LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 32) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 9) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 9 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 7 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 31) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 33) ||
                        (hcount_in == LIGHTS_HOR_POS + 25 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + 31)
                )
                rgb_out_nxt = 12'h111;
            //------------------------------------------------------------------
            else if(    ((LIGHTS_HOR_POS + 12 <= position && position <= LIGHTS_HOR_POS + 18) || hcount_in >= LIGHTS_HOR_POS + 12 - position) && (hcount_in <= LIGHTS_HOR_POS + 18 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 10) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 31) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 24) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 17) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 26) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 13) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 29) ||

                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 20) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 12) ||
                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||

                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 12) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 30)
                )
                rgb_out_nxt = 12'h441;

            else if(    ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 16) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 27) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 22) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 22 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 12) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 11 <= position && position <= LIGHTS_HOR_POS + 19) || hcount_in >= LIGHTS_HOR_POS + 11 - position) && (hcount_in <= LIGHTS_HOR_POS + 19 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 9) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 10 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 11) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 31) ||

                        (hcount_in == LIGHTS_HOR_POS + 8 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 15) ||
                        (hcount_in == LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 12) ||
                        ((LIGHTS_HOR_POS + 20 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 20 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 31)

                )
                rgb_out_nxt = 12'h000;

            else if(    ((LIGHTS_HOR_POS <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 17) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 22) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 8) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 9) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||

                        ((LIGHTS_HOR_POS + 5 <= position && position <= LIGHTS_HOR_POS + 6) || hcount_in >= LIGHTS_HOR_POS + 5 - position) && (hcount_in <= LIGHTS_HOR_POS + 6 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 10) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 29) ||
                        ((LIGHTS_HOR_POS + 3 <= position && position <= LIGHTS_HOR_POS + 4) || hcount_in >= LIGHTS_HOR_POS + 3 - position) && (hcount_in <= LIGHTS_HOR_POS + 4 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 12) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 27) ||
                        (hcount_in == LIGHTS_HOR_POS + 2 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 13) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 26) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 23) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 28) ||
                        (hcount_in == LIGHTS_HOR_POS + 6 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 23) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 23 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 34) ||

                        (hcount_in == LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 32) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 9) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 9 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 7 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 31) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 33) ||
                        (hcount_in == LIGHTS_HOR_POS + 25 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + 31)
                )
                rgb_out_nxt = 12'h111;
            //------------------------------------------------------------------
            else if(    ((LIGHTS_HOR_POS + 12 <= position && position <= LIGHTS_HOR_POS + 18) || hcount_in >= LIGHTS_HOR_POS + 12 - position) && (hcount_in <= LIGHTS_HOR_POS + 18 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 10) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 24) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 17) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 26) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 13) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 29) ||

                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 20) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) ||
                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||

                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30)
                )
                rgb_out_nxt = 12'h041;

            else if(    ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 16) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 27) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 22) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 22 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 11 <= position && position <= LIGHTS_HOR_POS + 19) || hcount_in >= LIGHTS_HOR_POS + 11 - position) && (hcount_in <= LIGHTS_HOR_POS + 19 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 9) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 10 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 11) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) ||

                        (hcount_in == LIGHTS_HOR_POS + 8 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 15) ||
                        (hcount_in == LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) ||
                        ((LIGHTS_HOR_POS + 20 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 20 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31)

                )
                rgb_out_nxt = 12'h000;

            else if(    ((LIGHTS_HOR_POS <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 17) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 22) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 8) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 9) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||

                        ((LIGHTS_HOR_POS + 5 <= position && position <= LIGHTS_HOR_POS + 6) || hcount_in >= LIGHTS_HOR_POS + 5 - position) && (hcount_in <= LIGHTS_HOR_POS + 6 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 10) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 29) ||
                        ((LIGHTS_HOR_POS + 3 <= position && position <= LIGHTS_HOR_POS + 4) || hcount_in >= LIGHTS_HOR_POS + 3 - position) && (hcount_in <= LIGHTS_HOR_POS + 4 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 27) ||
                        (hcount_in == LIGHTS_HOR_POS + 2 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 13) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 26) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 23) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 28) ||
                        (hcount_in == LIGHTS_HOR_POS + 6 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 23) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 23 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 34) ||

                        (hcount_in == LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 32) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 9) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 9 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 7 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 33) ||
                        (hcount_in == LIGHTS_HOR_POS + 25 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31)
                )
                rgb_out_nxt = 12'h111;
            //------------------------------------------------------------------
            else if(    ((LIGHTS_HOR_POS + 12 <= position && position <= LIGHTS_HOR_POS + 18) || hcount_in >= LIGHTS_HOR_POS + 12 - position) && (hcount_in <= LIGHTS_HOR_POS + 18 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 10) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 24) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 17) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 26) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 13) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 29) ||

                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 20) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) ||
                        ((LIGHTS_HOR_POS + 19 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 19 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||

                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 11 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30)
                )
                rgb_out_nxt = 12'h600; 

            else if(    ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 16) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 27) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 22) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 22 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 11 <= position && position <= LIGHTS_HOR_POS + 19) || hcount_in >= LIGHTS_HOR_POS + 11 - position) && (hcount_in <= LIGHTS_HOR_POS + 19 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 9) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 10 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 11) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) ||

                        (hcount_in == LIGHTS_HOR_POS + 8 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 15) ||
                        (hcount_in == LIGHTS_HOR_POS + 20 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) ||
                        ((LIGHTS_HOR_POS + 20 <= position && position <= LIGHTS_HOR_POS + 21) || hcount_in >= LIGHTS_HOR_POS + 20 - position) && (hcount_in <= LIGHTS_HOR_POS + 21 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31)

                )
                rgb_out_nxt = 12'h000;

            else if(    ((LIGHTS_HOR_POS <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 17) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 22) ||
                        ((LIGHTS_HOR_POS + 9 <= position && position <= LIGHTS_HOR_POS + 25) || hcount_in >= LIGHTS_HOR_POS + 9 - position) && (hcount_in <= LIGHTS_HOR_POS + 25 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 8) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 7 <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS + 7 - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 9) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||

                        ((LIGHTS_HOR_POS + 5 <= position && position <= LIGHTS_HOR_POS + 6) || hcount_in >= LIGHTS_HOR_POS + 5 - position) && (hcount_in <= LIGHTS_HOR_POS + 6 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 10) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 29) ||
                        ((LIGHTS_HOR_POS + 3 <= position && position <= LIGHTS_HOR_POS + 4) || hcount_in >= LIGHTS_HOR_POS + 3 - position) && (hcount_in <= LIGHTS_HOR_POS + 4 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 12) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 27) ||
                        (hcount_in == LIGHTS_HOR_POS + 2 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 13) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 26) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 11) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 16) ||
                        (hcount_in == LIGHTS_HOR_POS + 1 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 23) ||

                        (hcount_in == LIGHTS_HOR_POS + 4 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 28) ||
                        (hcount_in == LIGHTS_HOR_POS + 6 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 30) ||
                        ((LIGHTS_HOR_POS + 10 <= position && position <= LIGHTS_HOR_POS + 23) || hcount_in >= LIGHTS_HOR_POS + 10 - position) && (hcount_in <= LIGHTS_HOR_POS + 23 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 34) ||

                        (hcount_in == LIGHTS_HOR_POS + 24 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 32) ||
                        ((LIGHTS_HOR_POS + 8 <= position && position <= LIGHTS_HOR_POS + 9) || hcount_in >= LIGHTS_HOR_POS + 8 - position) && (hcount_in <= LIGHTS_HOR_POS + 9 - position) && (vcount_in >= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) && (vcount_in <= LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 32) ||
                        (hcount_in == LIGHTS_HOR_POS + 7 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31) ||
                        (hcount_in == LIGHTS_HOR_POS + 9 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 33) ||
                        (hcount_in == LIGHTS_HOR_POS + 25 - position) && (vcount_in == LIGHTS_VER_POS + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + LIGHTS_SPACING + 31)
                )
                rgb_out_nxt = 12'h111;

            //LIGHTS PILLAR
            else if(    ((LIGHTS_HOR_POS + 18 <= position && position <= LIGHTS_HOR_POS + 27) || hcount_in >= LIGHTS_HOR_POS + 18 - position) && (hcount_in <= LIGHTS_HOR_POS + 27 - position) && (vcount_in >= LIGHTS_VER_POS + 235) && (vcount_in <= LIGHTS_VER_POS + 285)
                )
                rgb_out_nxt = 12'ha9a;
            
            else if(    ((LIGHTS_HOR_POS + 17 <= position && position <= LIGHTS_HOR_POS + 28) || hcount_in >= LIGHTS_HOR_POS + 17 - position) && (hcount_in <= LIGHTS_HOR_POS + 28 - position) && (vcount_in >= LIGHTS_VER_POS + 235) && (vcount_in <= LIGHTS_VER_POS + 285)
                )
                rgb_out_nxt = 12'h000;
                
            else if(    ((LIGHTS_HOR_POS + 12 <= position && position <= LIGHTS_HOR_POS + 26) || hcount_in >= LIGHTS_HOR_POS + 12 - position) && (hcount_in <= LIGHTS_HOR_POS + 26 - position) && (vcount_in >= LIGHTS_VER_POS) && (vcount_in <= LIGHTS_VER_POS + 234)
                )
                rgb_out_nxt = 12'h122;

            else if(    ((LIGHTS_HOR_POS + 27 <= position && position <= LIGHTS_HOR_POS + 33) || hcount_in >= LIGHTS_HOR_POS + 27 - position) && (hcount_in <= LIGHTS_HOR_POS + 33 - position) && (vcount_in >= LIGHTS_VER_POS) && (vcount_in <= LIGHTS_VER_POS + 234)
                )
                rgb_out_nxt = 12'h010; 

            //WALL
            else if(    (hcount_in == WALL_HOR_POS + 9 - position) && (vcount_in >= WALL_VER_POS + 31) && (vcount_in <= WALL_VER_POS + 44) ||
                        ((WALL_HOR_POS + 1 <= position && position <= WALL_HOR_POS + 2) || hcount_in >= WALL_HOR_POS + 1 - position) && (hcount_in <= WALL_HOR_POS + 2 - position) && (vcount_in == WALL_VER_POS + 26) ||
                        (hcount_in == WALL_HOR_POS + 2 - position) && (vcount_in >= WALL_VER_POS + 13) && (vcount_in <= WALL_VER_POS + 25) ||
                        (hcount_in == WALL_HOR_POS + 3 - position) && (vcount_in >= WALL_VER_POS + 2) && (vcount_in <= WALL_VER_POS + 13) ||
                        ((WALL_HOR_POS + 4 <= position && position <= WALL_HOR_POS + 6) || hcount_in >= WALL_HOR_POS + 4 - position) && (hcount_in <= WALL_HOR_POS + 6 - position) && (vcount_in == WALL_VER_POS + 1) ||
                        (hcount_in == WALL_HOR_POS + 6 - position) && (vcount_in >= WALL_VER_POS + 2) && (vcount_in <= WALL_VER_POS + 15) ||

                        ((WALL_HOR_POS + 7 <= position && position <= WALL_HOR_POS + 8) || hcount_in >= WALL_HOR_POS + 7 - position) && (hcount_in <= WALL_HOR_POS + 8 - position) && (vcount_in == WALL_VER_POS + 15) ||
                        (hcount_in == WALL_HOR_POS + 8 - position) && (vcount_in >= WALL_VER_POS + 16) && (vcount_in <= WALL_VER_POS + 31) ||
                        ((WALL_HOR_POS + 5 <= position && position <= WALL_HOR_POS + 499) || hcount_in >= WALL_HOR_POS + 5 - position) && (hcount_in <= WALL_HOR_POS + 499 - position) && (vcount_in == WALL_VER_POS + 0) ||
                        (hcount_in == WALL_HOR_POS + 499 - position) && (vcount_in >= WALL_VER_POS + 1) && (vcount_in <= WALL_VER_POS + 14) ||
                        ((WALL_HOR_POS + 500 <= position && position <= WALL_HOR_POS + 502) || hcount_in >= WALL_HOR_POS + 500 - position) && (hcount_in <= WALL_HOR_POS + 502 - position) && (vcount_in == WALL_VER_POS + 14) ||
                        (hcount_in == WALL_HOR_POS + 502 - position) && (vcount_in >= WALL_VER_POS + 15) && (vcount_in <= WALL_VER_POS + 23) ||

                        (hcount_in == WALL_HOR_POS + 503 - position) && (vcount_in >= WALL_VER_POS + 24) && (vcount_in <= WALL_VER_POS + 44) ||
                        ((WALL_HOR_POS + 6 <= position && position <= WALL_HOR_POS + 503) || hcount_in >= WALL_HOR_POS + 6 - position) && (hcount_in <= WALL_HOR_POS + 503 - position) && (vcount_in == WALL_VER_POS + 45) ||
                        (hcount_in == WALL_HOR_POS + 0 - position) && (vcount_in >= WALL_VER_POS + 26) && (vcount_in <= WALL_VER_POS + 41) ||
                        (hcount_in == WALL_HOR_POS + 1 - position) && (vcount_in == WALL_VER_POS + 42) ||
                        (hcount_in == WALL_HOR_POS + 2 - position) && (vcount_in == WALL_VER_POS + 43) ||
                        ((WALL_HOR_POS + 3 <= position && position <= WALL_HOR_POS + 5) || hcount_in >= WALL_HOR_POS + 3 - position) && (hcount_in <= WALL_HOR_POS + 5 - position) && (vcount_in == WALL_VER_POS + 44)
                )
                rgb_out_nxt = 12'h000;

            else if(    ((WALL_HOR_POS + 3 <= position && position <= WALL_HOR_POS + 8) || hcount_in >= WALL_HOR_POS + 3 - position) && (hcount_in <= WALL_HOR_POS + 8 - position) && (vcount_in >= WALL_VER_POS + 16) && (vcount_in <= WALL_VER_POS + 43) ||
                        ((WALL_HOR_POS + 1 <= position && position <= WALL_HOR_POS + 2) || hcount_in >= WALL_HOR_POS + 1 - position) && (hcount_in <= WALL_HOR_POS + 2 - position) && (vcount_in >= WALL_VER_POS + 27) && (vcount_in <= WALL_VER_POS + 41) ||
                        (hcount_in == WALL_HOR_POS + 2 - position) && (vcount_in == WALL_VER_POS + 42) ||
                        ((WALL_HOR_POS + 6 <= position && position <= WALL_HOR_POS + 8) || hcount_in >= WALL_HOR_POS + 6 - position) && (hcount_in <= WALL_HOR_POS + 8 - position) && (vcount_in == WALL_VER_POS + 44) ||
                        (hcount_in == WALL_HOR_POS + 3 - position) && (vcount_in >= WALL_VER_POS + 14) && (vcount_in <= WALL_VER_POS + 15) ||
                        ((WALL_HOR_POS + 4 <= position && position <= WALL_HOR_POS + 5) || hcount_in >= WALL_HOR_POS + 4 - position) && (hcount_in <= WALL_HOR_POS + 5 - position) && (vcount_in >= WALL_VER_POS + 2) && (vcount_in <= WALL_VER_POS + 15)
                )
                rgb_out_nxt = 12'h444;

            else if(    ((WALL_HOR_POS + 7 <= position && position <= WALL_HOR_POS + 498) || hcount_in >= WALL_HOR_POS + 7 - position) && (hcount_in <= WALL_HOR_POS + 498 - position) && (vcount_in >= WALL_VER_POS + 1) && (vcount_in <= WALL_VER_POS + 44) ||
                        ((WALL_HOR_POS + 499 <= position && position <= WALL_HOR_POS + 501) || hcount_in >= WALL_HOR_POS + 499 - position) && (hcount_in <= WALL_HOR_POS + 501 - position) && (vcount_in >= WALL_VER_POS + 15) && (vcount_in <= WALL_VER_POS + 44) ||
                        (hcount_in == WALL_HOR_POS + 502 - position) && (vcount_in >= WALL_VER_POS + 24) && (vcount_in <= WALL_VER_POS + 44)
                )
                rgb_out_nxt = 12'h888;
            
            //BACK BARRIER
            else if(    ((B_BARRIER_HOR_POS <= position && position <= B_BARRIER_HOR_POS + 215) || hcount_in >= B_BARRIER_HOR_POS - position) && (hcount_in <= B_BARRIER_HOR_POS + 215 - position) && (vcount_in >= B_BARRIER_VER_POS + 8) && (vcount_in <= B_BARRIER_VER_POS + 14)
                )
                rgb_out_nxt = 12'haaa;

            else if(    ((B_BARRIER_HOR_POS + 8 <= position && position <= B_BARRIER_HOR_POS + 18) || hcount_in >= B_BARRIER_HOR_POS + 8 - position) && (hcount_in <= B_BARRIER_HOR_POS + 18 - position) && (vcount_in >= B_BARRIER_VER_POS + 22) && (vcount_in <= B_BARRIER_VER_POS + 39) ||
                        ((B_BARRIER_HOR_POS + 84 <= position && position <= B_BARRIER_HOR_POS + 94) || hcount_in >= B_BARRIER_HOR_POS + 84 - position) && (hcount_in <= B_BARRIER_HOR_POS + 94 - position) && (vcount_in >= B_BARRIER_VER_POS + 22) && (vcount_in <= B_BARRIER_VER_POS + 39) ||
                        ((B_BARRIER_HOR_POS + 184 <= position && position <= B_BARRIER_HOR_POS + 194) || hcount_in >= B_BARRIER_HOR_POS + 184 - position) && (hcount_in <= B_BARRIER_HOR_POS + 194 - position) && (vcount_in >= B_BARRIER_VER_POS + 22) && (vcount_in <= B_BARRIER_VER_POS + 39)
                )
                rgb_out_nxt = 12'h666;

            else if(    ((B_BARRIER_HOR_POS <= position && position <= B_BARRIER_HOR_POS + 215) || hcount_in >= B_BARRIER_HOR_POS - position) && (hcount_in <= B_BARRIER_HOR_POS + 215 - position) && (vcount_in >= B_BARRIER_VER_POS + 2) && (vcount_in <= B_BARRIER_VER_POS + 20)
                )
                rgb_out_nxt = 12'h444;

            else if(    ((B_BARRIER_HOR_POS <= position && position <= B_BARRIER_HOR_POS + 215) || hcount_in >= B_BARRIER_HOR_POS - position) && (hcount_in <= B_BARRIER_HOR_POS + 215 - position) && (vcount_in >= B_BARRIER_VER_POS + 0) && (vcount_in <= B_BARRIER_VER_POS + 22) ||
                        ((B_BARRIER_HOR_POS + 7 <= position && position <= B_BARRIER_HOR_POS + 19) || hcount_in >= B_BARRIER_HOR_POS + 7 - position) && (hcount_in <= B_BARRIER_HOR_POS + 19 - position) && (vcount_in >= B_BARRIER_VER_POS + 23) && (vcount_in <= B_BARRIER_VER_POS + 39) ||
                        ((B_BARRIER_HOR_POS + 83 <= position && position <= B_BARRIER_HOR_POS + 95) || hcount_in >= B_BARRIER_HOR_POS + 83 - position) && (hcount_in <= B_BARRIER_HOR_POS + 95 - position) && (vcount_in >= B_BARRIER_VER_POS + 23) && (vcount_in <= B_BARRIER_VER_POS + 39) ||
                        ((B_BARRIER_HOR_POS + 183 <= position && position <= B_BARRIER_HOR_POS + 195) || hcount_in >= B_BARRIER_HOR_POS + 183 - position) && (hcount_in <= B_BARRIER_HOR_POS + 195 - position) && (vcount_in >= B_BARRIER_VER_POS + 23) && (vcount_in <= B_BARRIER_VER_POS + 39)
                )
                rgb_out_nxt = 12'h000;

            else rgb_out_nxt = rgb_in;
        end
    end

endmodule