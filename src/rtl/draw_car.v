//draw_car HORIZONTAL/VERTICAL: 328px/91 px
module draw_car
#(
    parameter   RGB_1 = 12'hF83,
                RGB_2 = 12'hF50,
                RGB_3 = 12'hD10,
                XPOS  = 256,
                YPOS  = 481
)
(
    input wire clk,
    input wire reset,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [11:0] rgb_in,
    input wire mov,
    input wire [31:0] position_p1,
    input wire [31:0] position_p2,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out
);

    reg [11:0] rgb_out_nxt;
    reg [10:0] hcount_out_nxt, vcount_out_nxt;
    reg hsync_out_nxt, hblnk_out_nxt, vsync_out_nxt, vblnk_out_nxt;

    always @(posedge clk)
        if(reset) begin
            hcount_out <= 0;
            hsync_out <= 0;
            hblnk_out <= 0;
            vcount_out <= 0;
            vsync_out <= 0;
            vblnk_out <= 0;
            rgb_out <= 0;
        end
        else begin
            hcount_out <= hcount_out_nxt; 
            hsync_out <= hsync_out_nxt;
            hblnk_out <= hblnk_out_nxt;
            vcount_out <= vcount_out_nxt;
            vsync_out <= vsync_out_nxt;
            vblnk_out <= vblnk_out_nxt;
            rgb_out <= rgb_out_nxt;
        end

        always @* begin
            hcount_out_nxt = hcount_in; 
            hsync_out_nxt = hsync_in;
            hblnk_out_nxt = hblnk_in;
            vcount_out_nxt = vcount_in;
            vsync_out_nxt = vsync_in;
            vblnk_out_nxt = vblnk_in;
            if(hblnk_in || vblnk_in) rgb_out_nxt = 12'h0_0_0;
            else begin
                //---------------------------------------------------------------------------------
                if((mov == 0) && (
                            ((XPOS + 71 <= position_p1 - position_p2 && position_p1 - position_p2 <= 73 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 71)) && (hcount_in <= XPOS - position_p1 + position_p2 + 73) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 71 <= position_p1 - position_p2 && position_p1 - position_p2 <= 73 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 71)) && (hcount_in <= XPOS - position_p1 + position_p2 + 73) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 77 <= position_p1 - position_p2 && position_p1 - position_p2 <= 79 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 77)) && (hcount_in <= XPOS - position_p1 + position_p2 + 79) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 77 <= position_p1 - position_p2 && position_p1 - position_p2 <= 79 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 77)) && (hcount_in <= XPOS - position_p1 + position_p2 + 79) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 254 <= position_p1 - position_p2 && position_p1 - position_p2 <= 256 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 254)) && (hcount_in <= XPOS - position_p1 + position_p2 + 256) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 254 <= position_p1 - position_p2 && position_p1 - position_p2 <= 256 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 254)) && (hcount_in <= XPOS - position_p1 + position_p2 + 256) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 260 <= position_p1 - position_p2 && position_p1 - position_p2 <= 262 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 260)) && (hcount_in <= XPOS - position_p1 + position_p2 + 262) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 260 <= position_p1 - position_p2 && position_p1 - position_p2 <= 262 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 260)) && (hcount_in <= XPOS - position_p1 + position_p2 + 262) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42)
                        )
                )
                rgb_out_nxt = 12'h777;

                else if((mov == 1) && (
                            ((XPOS + 74 <= position_p1 - position_p2 && position_p1 - position_p2 <= 76 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 74)) && (hcount_in <= XPOS - position_p1 + position_p2 + 76) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 74 <= position_p1 - position_p2 && position_p1 - position_p2 <= 76 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 74)) && (hcount_in <= XPOS - position_p1 + position_p2 + 76) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 71 <= position_p1 - position_p2 && position_p1 - position_p2 <= 73 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 71)) && (hcount_in <= XPOS - position_p1 + position_p2 + 73) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39) ||
                            ((XPOS + 77 <= position_p1 - position_p2 && position_p1 - position_p2 <= 79 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 77)) && (hcount_in <= XPOS - position_p1 + position_p2 + 79) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39) ||
                            ((XPOS + 257 <= position_p1 - position_p2 && position_p1 - position_p2 <= 259 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 257)) && (hcount_in <= XPOS - position_p1 + position_p2 + 259) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 257 <= position_p1 - position_p2 && position_p1 - position_p2 <= 259 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 257)) && (hcount_in <= XPOS - position_p1 + position_p2 + 259) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 254 <= position_p1 - position_p2 && position_p1 - position_p2 <= 256 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 254)) && (hcount_in <= XPOS - position_p1 + position_p2 + 256) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39) ||
                            ((XPOS + 260 <= position_p1 - position_p2 && position_p1 - position_p2 <= 262 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 260)) && (hcount_in <= XPOS - position_p1 + position_p2 + 262) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39)
                        )
                )
                rgb_out_nxt = 12'h777;

                else if(
                            ((XPOS + 71 <= position_p1 - position_p2 && position_p1 - position_p2 <= 79 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 71)) && (hcount_in <= XPOS - position_p1 + position_p2 + 79) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 254 <= position_p1 - position_p2 && position_p1 - position_p2 <= 262 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 254)) && (hcount_in <= XPOS - position_p1 + position_p2 + 262) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) 
                )
                rgb_out_nxt = 12'h445;

                else if(
                            ((XPOS + 67 <= position_p1 - position_p2 && position_p1 - position_p2 <= 83 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 67)) && (hcount_in <= XPOS - position_p1 + position_p2 + 83) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) || 
                            ((XPOS + 68 <= position_p1 - position_p2 && position_p1 - position_p2 <= 82 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 68)) && (hcount_in <= XPOS - position_p1 + position_p2 + 82) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 43) || 
                            ((XPOS + 69 <= position_p1 - position_p2 && position_p1 - position_p2 <= 81 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 69)) && (hcount_in <= XPOS - position_p1 + position_p2 + 81) && (vcount_in >= YPOS + 32) && (vcount_in <= YPOS + 44) ||
                            ((XPOS + 70 <= position_p1 - position_p2 && position_p1 - position_p2 <= 80 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 70)) && (hcount_in <= XPOS - position_p1 + position_p2 + 80) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||
                            ((XPOS + 71 <= position_p1 - position_p2 && position_p1 - position_p2 <= 79 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 71)) && (hcount_in <= XPOS - position_p1 + position_p2 + 79) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 46) ||
                            ((XPOS + 250 <= position_p1 - position_p2 && position_p1 - position_p2 <= 266 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 250)) && (hcount_in <= XPOS - position_p1 + position_p2 + 266) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) || 
                            ((XPOS + 251 <= position_p1 - position_p2 && position_p1 - position_p2 <= 265 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 251)) && (hcount_in <= XPOS - position_p1 + position_p2 + 265) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 43) || 
                            ((XPOS + 252 <= position_p1 - position_p2 && position_p1 - position_p2 <= 264 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 252)) && (hcount_in <= XPOS - position_p1 + position_p2 + 264) && (vcount_in >= YPOS + 32) && (vcount_in <= YPOS + 44) ||
                            ((XPOS + 253 <= position_p1 - position_p2 && position_p1 - position_p2 <= 263 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 253)) && (hcount_in <= XPOS - position_p1 + position_p2 + 263) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||
                            ((XPOS + 254 <= position_p1 - position_p2 && position_p1 - position_p2 <= 262 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 254)) && (hcount_in <= XPOS - position_p1 + position_p2 + 262) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 46) 
                )
                rgb_out_nxt = 12'h000;

                else if(
                            ((XPOS + 71 <= position_p1 - position_p2 && position_p1 - position_p2 <= 79 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 71)) && (hcount_in <= XPOS - position_p1 + position_p2 + 79) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 50) || 
                            ((XPOS + 63 <= position_p1 - position_p2 && position_p1 - position_p2 <= 87 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 63)) && (hcount_in <= XPOS - position_p1 + position_p2 + 87) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 64 <= position_p1 - position_p2 && position_p1 - position_p2 <= 86 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 64)) && (hcount_in <= XPOS - position_p1 + position_p2 + 86) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 43) ||
                            ((XPOS + 65 <= position_p1 - position_p2 && position_p1 - position_p2 <= 85 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 65)) && (hcount_in <= XPOS - position_p1 + position_p2 + 85) && (vcount_in >= YPOS + 32) && (vcount_in <= YPOS + 44) ||
                            ((XPOS + 66 <= position_p1 - position_p2 && position_p1 - position_p2 <= 84 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 66)) && (hcount_in <= XPOS - position_p1 + position_p2 + 84) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||   
                            ((XPOS + 67 <= position_p1 - position_p2 && position_p1 - position_p2 <= 83 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 67)) && (hcount_in <= XPOS - position_p1 + position_p2 + 83) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 46) ||
                            ((XPOS + 68 <= position_p1 - position_p2 && position_p1 - position_p2 <= 82 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 68)) && (hcount_in <= XPOS - position_p1 + position_p2 + 82) && (vcount_in >= YPOS + 29) && (vcount_in <= YPOS + 47) ||
                            ((XPOS + 69 <= position_p1 - position_p2 && position_p1 - position_p2 <= 81 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 69)) && (hcount_in <= XPOS - position_p1 + position_p2 + 81) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 48) ||
                            ((XPOS + 70 <= position_p1 - position_p2 && position_p1 - position_p2 <= 80 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 70)) && (hcount_in <= XPOS - position_p1 + position_p2 + 80) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 49) ||
                            ((XPOS + 254 <= position_p1 - position_p2 && position_p1 - position_p2 <= 262 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 254)) && (hcount_in <= XPOS - position_p1 + position_p2 + 262) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 50) || 
                            ((XPOS + 246 <= position_p1 - position_p2 && position_p1 - position_p2 <= 270 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 246)) && (hcount_in <= XPOS - position_p1 + position_p2 + 270) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 247 <= position_p1 - position_p2 && position_p1 - position_p2 <= 269 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 247)) && (hcount_in <= XPOS - position_p1 + position_p2 + 269) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 43) ||
                            ((XPOS + 248 <= position_p1 - position_p2 && position_p1 - position_p2 <= 268 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 248)) && (hcount_in <= XPOS - position_p1 + position_p2 + 268) && (vcount_in >= YPOS + 32) && (vcount_in <= YPOS + 44) ||
                            ((XPOS + 249 <= position_p1 - position_p2 && position_p1 - position_p2 <= 267 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 249)) && (hcount_in <= XPOS - position_p1 + position_p2 + 267) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||   
                            ((XPOS + 250 <= position_p1 - position_p2 && position_p1 - position_p2 <= 266 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 250)) && (hcount_in <= XPOS - position_p1 + position_p2 + 266) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 46) ||
                            ((XPOS + 251 <= position_p1 - position_p2 && position_p1 - position_p2 <= 265 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 251)) && (hcount_in <= XPOS - position_p1 + position_p2 + 265) && (vcount_in >= YPOS + 29) && (vcount_in <= YPOS + 47) ||
                            ((XPOS + 252 <= position_p1 - position_p2 && position_p1 - position_p2 <= 264 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 252)) && (hcount_in <= XPOS - position_p1 + position_p2 + 264) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 48) ||
                            ((XPOS + 253 <= position_p1 - position_p2 && position_p1 - position_p2 <= 263 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 253)) && (hcount_in <= XPOS - position_p1 + position_p2 + 263) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 49)  
                            
                )
                rgb_out_nxt = 12'h222;

                else if(
                            ((XPOS + 68 <= position_p1 - position_p2 && position_p1 - position_p2 <= 82 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 68)) && (hcount_in <= XPOS - position_p1 + position_p2 + 82) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 59) ||
                            ((XPOS + 65 <= position_p1 - position_p2 && position_p1 - position_p2 <= 85 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 65)) && (hcount_in <= XPOS - position_p1 + position_p2 + 85) && (vcount_in >= YPOS + 18) && (vcount_in <= YPOS + 58) ||
                            ((XPOS + 54 <= position_p1 - position_p2 && position_p1 - position_p2 <= 96 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 54)) && (hcount_in <= XPOS - position_p1 + position_p2 + 96) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||
                            ((XPOS + 55 <= position_p1 - position_p2 && position_p1 - position_p2 <= 95 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 55)) && (hcount_in <= XPOS - position_p1 + position_p2 + 95) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 48) ||
                            ((XPOS + 56 <= position_p1 - position_p2 && position_p1 - position_p2 <= 94 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 56)) && (hcount_in <= XPOS - position_p1 + position_p2 + 94) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 49) ||
                            ((XPOS + 57 <= position_p1 - position_p2 && position_p1 - position_p2 <= 93 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 57)) && (hcount_in <= XPOS - position_p1 + position_p2 + 93) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 50) ||
                            ((XPOS + 58 <= position_p1 - position_p2 && position_p1 - position_p2 <= 92 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 58)) && (hcount_in <= XPOS - position_p1 + position_p2 + 92) && (vcount_in >= YPOS + 24) && (vcount_in <= YPOS + 52) ||
                            ((XPOS + 59 <= position_p1 - position_p2 && position_p1 - position_p2 <= 91 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 59)) && (hcount_in <= XPOS - position_p1 + position_p2 + 91) && (vcount_in >= YPOS + 23) && (vcount_in <= YPOS + 53) ||
                            ((XPOS + 60 <= position_p1 - position_p2 && position_p1 - position_p2 <= 90 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 60)) && (hcount_in <= XPOS - position_p1 + position_p2 + 90) && (vcount_in >= YPOS + 22) && (vcount_in <= YPOS + 54) ||
                            ((XPOS + 61 <= position_p1 - position_p2 && position_p1 - position_p2 <= 89 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 61)) && (hcount_in <= XPOS - position_p1 + position_p2 + 89) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 55) ||
                            ((XPOS + 63 <= position_p1 - position_p2 && position_p1 - position_p2 <= 87 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 63)) && (hcount_in <= XPOS - position_p1 + position_p2 + 87) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 56) ||
                            ((XPOS + 63 <= position_p1 - position_p2 && position_p1 - position_p2 <= 87 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 63)) && (hcount_in <= XPOS - position_p1 + position_p2 + 87) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 56) ||
                            ((XPOS + 64 <= position_p1 - position_p2 && position_p1 - position_p2 <= 86 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 64)) && (hcount_in <= XPOS - position_p1 + position_p2 + 86) && (vcount_in >= YPOS + 19) && (vcount_in <= YPOS + 57) ||
                            ((XPOS + 251 <= position_p1 - position_p2 && position_p1 - position_p2 <= 265 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 251)) && (hcount_in <= XPOS - position_p1 + position_p2 + 265) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 59) ||
                            ((XPOS + 248 <= position_p1 - position_p2 && position_p1 - position_p2 <= 268 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 248)) && (hcount_in <= XPOS - position_p1 + position_p2 + 268) && (vcount_in >= YPOS + 18) && (vcount_in <= YPOS + 58) ||
                            ((XPOS + 237 <= position_p1 - position_p2 && position_p1 - position_p2 <= 279 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 237)) && (hcount_in <= XPOS - position_p1 + position_p2 + 279) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||
                            ((XPOS + 238 <= position_p1 - position_p2 && position_p1 - position_p2 <= 278 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 238)) && (hcount_in <= XPOS - position_p1 + position_p2 + 278) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 48) ||
                            ((XPOS + 239 <= position_p1 - position_p2 && position_p1 - position_p2 <= 277 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 239)) && (hcount_in <= XPOS - position_p1 + position_p2 + 277) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 49) ||
                            ((XPOS + 240 <= position_p1 - position_p2 && position_p1 - position_p2 <= 276 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 240)) && (hcount_in <= XPOS - position_p1 + position_p2 + 276) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 50) ||
                            ((XPOS + 241 <= position_p1 - position_p2 && position_p1 - position_p2 <= 275 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 241)) && (hcount_in <= XPOS - position_p1 + position_p2 + 275) && (vcount_in >= YPOS + 24) && (vcount_in <= YPOS + 52) ||
                            ((XPOS + 242 <= position_p1 - position_p2 && position_p1 - position_p2 <= 274 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 242)) && (hcount_in <= XPOS - position_p1 + position_p2 + 274) && (vcount_in >= YPOS + 23) && (vcount_in <= YPOS + 53) ||
                            ((XPOS + 243 <= position_p1 - position_p2 && position_p1 - position_p2 <= 273 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 243)) && (hcount_in <= XPOS - position_p1 + position_p2 + 273) && (vcount_in >= YPOS + 22) && (vcount_in <= YPOS + 54) ||
                            ((XPOS + 244<= position_p1 - position_p2 && position_p1 - position_p2 <= 272 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 244)) && (hcount_in <= XPOS - position_p1 + position_p2 + 272) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 55) ||
                            ((XPOS + 246 <= position_p1 - position_p2 && position_p1 - position_p2 <= 270 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 246)) && (hcount_in <= XPOS - position_p1 + position_p2 + 270) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 56) ||
                            ((XPOS + 246 <= position_p1 - position_p2 && position_p1 - position_p2 <= 270 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 246)) && (hcount_in <= XPOS - position_p1 + position_p2 + 270) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 56) ||
                            ((XPOS + 247 <= position_p1 - position_p2 && position_p1 - position_p2 <= 269 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 247)) && (hcount_in <= XPOS - position_p1 + position_p2 + 269) && (vcount_in >= YPOS + 19) && (vcount_in <= YPOS + 57)
                )
                rgb_out_nxt = 12'h000;

                else if(
                            ((XPOS + 142 <= position_p1 - position_p2 && position_p1 - position_p2 <= 150 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 142)) && (hcount_in <= XPOS - position_p1 + position_p2 + 150) && (vcount_in >= YPOS) && (vcount_in <= YPOS + 2) ||
                            ((XPOS + 142 <= position_p1 - position_p2 && position_p1 - position_p2 <= 144 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 142)) && (hcount_in <= XPOS - position_p1 + position_p2 + 144) && (vcount_in == YPOS + 3) ||
                            ((XPOS + 142 <= position_p1 - position_p2 && position_p1 - position_p2 <= 143 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 142)) && (hcount_in <= XPOS - position_p1 + position_p2 + 143) && (vcount_in >= YPOS + 4) && (vcount_in <= YPOS + 5) ||
                            (hcount_in == XPOS - position_p1 + position_p2 + 51) && (vcount_in == YPOS + 37) ||
                            ((XPOS + 52 <= position_p1 - position_p2 && position_p1 - position_p2 <= 98 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 52)) && (hcount_in <= XPOS - position_p1 + position_p2 + 98) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 37) ||
                            ((XPOS + 97<= position_p1 - position_p2 && position_p1 - position_p2 <= 98 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 97)) && (hcount_in <= XPOS - position_p1 + position_p2 + 98) && (vcount_in >= YPOS + 38) && (vcount_in <= YPOS + 41) ||
                            (hcount_in == XPOS - position_p1 + position_p2 + 99) && (vcount_in == YPOS + 41) ||
                            ((XPOS + 53 <= position_p1 - position_p2 && position_p1 - position_p2 <= 97 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 53)) && (hcount_in <= XPOS - position_p1 + position_p2 + 97) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 29) ||
                            ((XPOS + 53 <= position_p1 - position_p2 && position_p1 - position_p2 <= 97 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 53)) && (hcount_in <= XPOS - position_p1 + position_p2 + 97) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 29) ||
                            ((XPOS + 54 <= position_p1 - position_p2 && position_p1 - position_p2 <= 96 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 54)) && (hcount_in <= XPOS - position_p1 + position_p2 + 96) && (vcount_in == YPOS + 25) ||
                            ((XPOS + 55 <= position_p1 - position_p2 && position_p1 - position_p2 <= 95 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 55)) && (hcount_in <= XPOS - position_p1 + position_p2 + 95) && (vcount_in == YPOS + 24) ||
                            ((XPOS + 56 <= position_p1 - position_p2 && position_p1 - position_p2 <= 94 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 56)) && (hcount_in <= XPOS - position_p1 + position_p2 + 94) && (vcount_in >= YPOS + 22) && (vcount_in <= YPOS + 23) ||
                            ((XPOS + 57 <= position_p1 - position_p2 && position_p1 - position_p2 <= 93 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 57)) && (hcount_in <= XPOS - position_p1 + position_p2 + 93) && (vcount_in == YPOS + 21) ||
                            ((XPOS + 58 <= position_p1 - position_p2 && position_p1 - position_p2 <= 92 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 58)) && (hcount_in <= XPOS - position_p1 + position_p2 + 92) && (vcount_in == YPOS + 20) ||
                            ((XPOS + 59 <= position_p1 - position_p2 && position_p1 - position_p2 <= 91 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 59)) && (hcount_in <= XPOS - position_p1 + position_p2 + 91) && (vcount_in == YPOS + 19) ||
                            ((XPOS + 61 <= position_p1 - position_p2 && position_p1 - position_p2 <= 89 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 61)) && (hcount_in <= XPOS - position_p1 + position_p2 + 89) && (vcount_in == YPOS + 18) ||
                            ((XPOS + 62 <= position_p1 - position_p2 && position_p1 - position_p2 <= 88 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 62)) && (hcount_in <= XPOS - position_p1 + position_p2 + 88) && (vcount_in == YPOS + 17) ||
                            ((XPOS + 63 <= position_p1 - position_p2 && position_p1 - position_p2 <= 87 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 63)) && (hcount_in <= XPOS - position_p1 + position_p2 + 87) && (vcount_in == YPOS + 16) ||
                            ((XPOS + 66 <= position_p1 - position_p2 && position_p1 - position_p2 <= 84 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 66)) && (hcount_in <= XPOS - position_p1 + position_p2 + 84) && (vcount_in == YPOS + 15) ||
                            (hcount_in == XPOS - position_p1 + position_p2 + 282) && (vcount_in == YPOS + 37) ||
                            ((XPOS + 235 <= position_p1 - position_p2 && position_p1 - position_p2 <= 281 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 235)) && (hcount_in <= XPOS - position_p1 + position_p2 + 281) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 37) ||
                            ((XPOS + 236 <= position_p1 - position_p2 && position_p1 - position_p2 <= 280 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 236)) && (hcount_in <= XPOS - position_p1 + position_p2 + 280) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 29) ||
                            ((XPOS + 236 <= position_p1 - position_p2 && position_p1 - position_p2 <= 280 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 236)) && (hcount_in <= XPOS - position_p1 + position_p2 + 280) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 29) ||
                            ((XPOS + 237 <= position_p1 - position_p2 && position_p1 - position_p2 <= 279 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 237)) && (hcount_in <= XPOS - position_p1 + position_p2 + 279) && (vcount_in == YPOS + 25) ||
                            ((XPOS + 238 <= position_p1 - position_p2 && position_p1 - position_p2 <= 278 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 238)) && (hcount_in <= XPOS - position_p1 + position_p2 + 278) && (vcount_in == YPOS + 24) ||
                            ((XPOS + 239 <= position_p1 - position_p2 && position_p1 - position_p2 <= 277 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 239)) && (hcount_in <= XPOS - position_p1 + position_p2 + 277) && (vcount_in >= YPOS + 22) && (vcount_in <= YPOS + 23) ||
                            ((XPOS + 240 <= position_p1 - position_p2 && position_p1 - position_p2 <= 276 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 240)) && (hcount_in <= XPOS - position_p1 + position_p2 + 276) && (vcount_in == YPOS + 21) ||
                            ((XPOS + 241 <= position_p1 - position_p2 && position_p1 - position_p2 <= 275 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 241)) && (hcount_in <= XPOS - position_p1 + position_p2 + 275) && (vcount_in == YPOS + 20) ||
                            ((XPOS + 242 <= position_p1 - position_p2 && position_p1 - position_p2 <= 274 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 242)) && (hcount_in <= XPOS - position_p1 + position_p2 + 274) && (vcount_in == YPOS + 19) ||
                            ((XPOS + 244 <= position_p1 - position_p2 && position_p1 - position_p2 <= 272 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 244)) && (hcount_in <= XPOS - position_p1 + position_p2 + 272) && (vcount_in == YPOS + 18) ||
                            ((XPOS + 245 <= position_p1 - position_p2 && position_p1 - position_p2 <= 271 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 245)) && (hcount_in <= XPOS - position_p1 + position_p2 + 271) && (vcount_in == YPOS + 17) ||
                            ((XPOS + 246 <= position_p1 - position_p2 && position_p1 - position_p2 <= 270 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 246)) && (hcount_in <= XPOS - position_p1 + position_p2 + 270) && (vcount_in == YPOS + 16) ||
                            ((XPOS + 249 <= position_p1 - position_p2 && position_p1 - position_p2 <= 267 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 249)) && (hcount_in <= XPOS - position_p1 + position_p2 + 267) && (vcount_in == YPOS + 15) ||
                            ((XPOS + 235 <= position_p1 - position_p2 && position_p1 - position_p2 <= 236 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 235)) && (hcount_in <= XPOS - position_p1 + position_p2 + 236) && (vcount_in >= YPOS + 38) && (vcount_in <= YPOS + 41) ||
                            (hcount_in == XPOS - position_p1 + position_p2 + 234) && (vcount_in == YPOS + 41)                       
                )
                rgb_out_nxt = 12'h322;

                else if(
                            ((XPOS + 49 <= position_p1 - position_p2 && position_p1 - position_p2 <= 95 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 49)) && (hcount_in <= XPOS - position_p1 + position_p2 + 95) && (vcount_in >= YPOS - 4) && (vcount_in <= YPOS - 1) ||
                            (hcount_in == XPOS - position_p1 + position_p2 + 48) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS - 2) ||
                            ((XPOS + 93 <= position_p1 - position_p2 && position_p1 - position_p2 <= 98 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 93)) && (hcount_in <= XPOS - position_p1 + position_p2 + 98) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 97 <= position_p1 - position_p2 && position_p1 - position_p2 <= 99 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 97)) && (hcount_in <= XPOS - position_p1 + position_p2 + 99) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8)
                )
                rgb_out_nxt = 12'h666;

                else if(
                            ((XPOS + 294 <= position_p1 - position_p2 && position_p1 - position_p2 <= 295 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 294)) && (hcount_in <= XPOS - position_p1 + position_p2 + 295) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 23) ||
                            ((XPOS + 24 <= position_p1 - position_p2 && position_p1 - position_p2 <= 50 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 24)) && (hcount_in <= XPOS - position_p1 + position_p2 + 50) && (vcount_in >= YPOS + 38) && (vcount_in <= YPOS + 40) ||
                            ((XPOS + 100 <= position_p1 - position_p2 && position_p1 - position_p2 <= 233 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 100)) && (hcount_in <= XPOS - position_p1 + position_p2 + 233) && (vcount_in >= YPOS + 42) && (vcount_in <= YPOS + 43) ||
                            ((XPOS + 135 <= position_p1 - position_p2 && position_p1 - position_p2 <= 137 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 135)) && (hcount_in <= XPOS - position_p1 + position_p2 + 137) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS + 41) ||
                            ((XPOS + 135 <= position_p1 - position_p2 && position_p1 - position_p2 <= 137 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 135)) && (hcount_in <= XPOS - position_p1 + position_p2 + 137) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS + 41) || 
                            ((XPOS + 138 <= position_p1 - position_p2 && position_p1 - position_p2 <= 181 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 138)) && (hcount_in <= XPOS - position_p1 + position_p2 + 181) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 180 <= position_p1 - position_p2 && position_p1 - position_p2 <= 216 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 180)) && (hcount_in <= XPOS - position_p1 + position_p2 + 216) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS - 2) ||
                            ((XPOS + 214 <= position_p1 - position_p2 && position_p1 - position_p2 <= 216 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 214)) && (hcount_in <= XPOS - position_p1 + position_p2 + 216) && (vcount_in >= YPOS - 1) && (vcount_in <= YPOS + 41) ||
                            ((XPOS + 283 <= position_p1 - position_p2 && position_p1 - position_p2 <= 316 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 283)) && (hcount_in <= XPOS - position_p1 + position_p2 + 316) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39) ||
                            ((XPOS + 301 <= position_p1 - position_p2 && position_p1 - position_p2 <= 317 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 301)) && (hcount_in <= XPOS - position_p1 + position_p2 + 317) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 307 <= position_p1 - position_p2 && position_p1 - position_p2 <= 320 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 307)) && (hcount_in <= XPOS - position_p1 + position_p2 + 320) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 35) ||
                            ((XPOS + 318 <= position_p1 - position_p2 && position_p1 - position_p2 <= 319 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 318)) && (hcount_in <= XPOS - position_p1 + position_p2 + 319) && (vcount_in >= YPOS + 7) && (vcount_in <= YPOS + 19) || 
                            (hcount_in == XPOS - position_p1 + position_p2 + 320) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 19) ||
                            ((XPOS + 321 <= position_p1 - position_p2 && position_p1 - position_p2 <= 323 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 321)) && (hcount_in <= XPOS - position_p1 + position_p2 + 323) && (vcount_in >= YPOS + 18) && (vcount_in <= YPOS + 33) || 
                            ((XPOS + 100 <= position_p1 - position_p2 && position_p1 - position_p2 <= 134 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 100)) && (hcount_in <= XPOS - position_p1 + position_p2 + 134) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 100 <= position_p1 - position_p2 && position_p1 - position_p2 <= 134 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 100)) && (hcount_in <= XPOS - position_p1 + position_p2 + 134) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||  
                            ((XPOS + 104 <= position_p1 - position_p2 && position_p1 - position_p2 <= 112 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 104)) && (hcount_in <= XPOS - position_p1 + position_p2 + 112) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 104 <= position_p1 - position_p2 && position_p1 - position_p2 <= 112 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 104)) && (hcount_in <= XPOS - position_p1 + position_p2 + 112) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 111 <= position_p1 - position_p2 && position_p1 - position_p2 <= 119 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 111)) && (hcount_in <= XPOS - position_p1 + position_p2 + 119) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 118 <= position_p1 - position_p2 && position_p1 - position_p2 <= 119 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 118)) && (hcount_in <= XPOS - position_p1 + position_p2 + 119) && (vcount_in == YPOS - 18) ||
                            ((XPOS + 118 <= position_p1 - position_p2 && position_p1 - position_p2 <= 126 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 118)) && (hcount_in <= XPOS - position_p1 + position_p2 + 126) && (vcount_in >= YPOS - 20) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 118 <= position_p1 - position_p2 && position_p1 - position_p2 <= 126 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 118)) && (hcount_in <= XPOS - position_p1 + position_p2 + 126) && (vcount_in >= YPOS - 20) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 124 <= position_p1 - position_p2 && position_p1 - position_p2 <= 126 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 124)) && (hcount_in <= XPOS - position_p1 + position_p2 + 126) && (vcount_in >= YPOS - 24) && (vcount_in <= YPOS - 21) || 
                            ((XPOS + 127 <= position_p1 - position_p2 && position_p1 - position_p2 <= 185 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 127)) && (hcount_in <= XPOS - position_p1 + position_p2 + 185) && (vcount_in >= YPOS - 24) && (vcount_in <= YPOS - 22) ||
                            ((XPOS + 180 <= position_p1 - position_p2 && position_p1 - position_p2 <= 185 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 180)) && (hcount_in <= XPOS - position_p1 + position_p2 + 185) && (vcount_in >= YPOS - 21) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 180 <= position_p1 - position_p2 && position_p1 - position_p2 <= 181 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 180)) && (hcount_in <= XPOS - position_p1 + position_p2 + 181) && (vcount_in >= YPOS - 18) && (vcount_in <= YPOS - 8) ||
                            (hcount_in == XPOS - position_p1 + position_p2 + 182) && (vcount_in == YPOS - 18) ||
                            ((XPOS + 180 <= position_p1 - position_p2 && position_p1 - position_p2 <= 181 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 180)) && (hcount_in <= XPOS - position_p1 + position_p2 + 181) && (vcount_in >= YPOS - 18) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 193 <= position_p1 - position_p2 && position_p1 - position_p2 <= 199 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 193)) && (hcount_in <= XPOS - position_p1 + position_p2 + 199) && (vcount_in == YPOS - 4)||
                            ((XPOS + 194 <= position_p1 - position_p2 && position_p1 - position_p2 <= 199 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 194)) && (hcount_in <= XPOS - position_p1 + position_p2 + 199) && (vcount_in >= YPOS - 6) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 180 <= position_p1 - position_p2 && position_p1 - position_p2 <= 182 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 180)) && (hcount_in <= XPOS - position_p1 + position_p2 + 182) && (vcount_in == YPOS - 4) ||
                            ((XPOS + 210 <= position_p1 - position_p2 && position_p1 - position_p2 <= 216 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 210)) && (hcount_in <= XPOS - position_p1 + position_p2 + 216) && (vcount_in == YPOS - 4) ||
                            ((XPOS + 211 <= position_p1 - position_p2 && position_p1 - position_p2 <= 216 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 211)) && (hcount_in <= XPOS - position_p1 + position_p2 + 216) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 214 <= position_p1 - position_p2 && position_p1 - position_p2 <= 216 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 214)) && (hcount_in <= XPOS - position_p1 + position_p2 + 216) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 194 <= position_p1 - position_p2 && position_p1 - position_p2 <= 198 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 194)) && (hcount_in <= XPOS - position_p1 + position_p2 + 198) && (vcount_in == YPOS - 7) ||
                            (hcount_in == XPOS - position_p1 + position_p2 + 213) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 193 <= position_p1 - position_p2 && position_p1 - position_p2 <= 196 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 193)) && (hcount_in <= XPOS - position_p1 + position_p2 + 196) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 193 <= position_p1 - position_p2 && position_p1 - position_p2 <= 196 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 193)) && (hcount_in <= XPOS - position_p1 + position_p2 + 196) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 190 <= position_p1 - position_p2 && position_p1 - position_p2 <= 195 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 190)) && (hcount_in <= XPOS - position_p1 + position_p2 + 195) && (vcount_in >= YPOS - 11) && (vcount_in <= YPOS - 9) ||
                            ((XPOS + 186 <= position_p1 - position_p2 && position_p1 - position_p2 <= 189 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 186)) && (hcount_in <= XPOS - position_p1 + position_p2 + 189) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 189 <= position_p1 - position_p2 && position_p1 - position_p2 <= 192 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 189)) && (hcount_in <= XPOS - position_p1 + position_p2 + 192) && (vcount_in >= YPOS - 13) && (vcount_in <= YPOS - 12) ||
                            ((XPOS + 189 <= position_p1 - position_p2 && position_p1 - position_p2 <= 191 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 189)) && (hcount_in <= XPOS - position_p1 + position_p2 + 191) && (vcount_in == YPOS - 14) ||
                            ((XPOS + 186 <= position_p1 - position_p2 && position_p1 - position_p2 <= 188 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 186)) && (hcount_in <= XPOS - position_p1 + position_p2 + 188) && (vcount_in == YPOS - 18)
                )
                rgb_out_nxt = 12'h000;

                else if(
                            (hcount_in == XPOS - position_p1 + position_p2 + 296) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 23)   
                )
                rgb_out_nxt = 12'h650; 

                else if(
                            ((XPOS + 297 <= position_p1 - position_p2 && position_p1 - position_p2 <= 302 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 297)) && (hcount_in <= XPOS - position_p1 + position_p2 + 302) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 23)   
                )
                rgb_out_nxt = 12'hfd1; 

                else if(
                            ((XPOS - 1 <= position_p1 - position_p2 && position_p1 - position_p2 <= 2 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 - 1)) && (hcount_in <= XPOS - position_p1 + position_p2 + 2) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 23) ||
                            ((XPOS - 4 <= position_p1 - position_p2 && position_p1 - position_p2 <= XPOS - 2) || (hcount_in >= XPOS - position_p1 + position_p2 - 4)) && (hcount_in <= XPOS - position_p1 + position_p2 - 2) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 20) ||
                            ((XPOS + 310 <= position_p1 - position_p2 && position_p1 - position_p2 <= 317 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 310)) && (hcount_in <= XPOS - position_p1 + position_p2 + 317) && (vcount_in >= YPOS + 24) && (vcount_in <= YPOS + 27) || 
                            ((XPOS + 314 <= position_p1 - position_p2 && position_p1 - position_p2 <= 317 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 314)) && (hcount_in <= XPOS - position_p1 + position_p2 + 317) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 30)    
                )
                rgb_out_nxt = 12'hbcc; 

                else if(
                            ((XPOS - 4 <= position_p1 - position_p2 && position_p1 - position_p2 <= 2 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 - 4)) && (hcount_in <= XPOS - position_p1 + position_p2 + 2) && (vcount_in >= YPOS + 14) && (vcount_in <= YPOS + 16) ||
                            ((XPOS + 3 <= position_p1 - position_p2 && position_p1 - position_p2 <= 5 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 3)) && (hcount_in <= XPOS - position_p1 + position_p2 + 5) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 26) ||
                            ((XPOS - 4 <= position_p1 - position_p2 && position_p1 - position_p2 <= 2 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 - 4)) && (hcount_in <= XPOS - position_p1 + position_p2 + 2) && (vcount_in >= YPOS + 24) && (vcount_in <= YPOS + 26) ||
                            ((XPOS - 4 <= position_p1 - position_p2 && position_p1 - position_p2 <= XPOS - 1) || (hcount_in >= XPOS - position_p1 + position_p2 - 4)) && (hcount_in <= XPOS - position_p1 + position_p2 - 1) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 23) || 
                            ((XPOS + 307 <= position_p1 - position_p2 && position_p1 - position_p2 <= 320 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 307)) && (hcount_in <= XPOS - position_p1 + position_p2 + 320) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 33)    
                )
                rgb_out_nxt = 12'h455;

                else if(
                            ((XPOS + 113 <= position_p1 - position_p2 && position_p1 - position_p2 <= 209 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 113)) && (hcount_in <= XPOS - position_p1 + position_p2 + 209) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 138 <= position_p1 - position_p2 && position_p1 - position_p2 <= 212 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 138)) && (hcount_in <= XPOS - position_p1 + position_p2 + 212) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 182 <= position_p1 - position_p2 && position_p1 - position_p2 <= 210 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 182)) && (hcount_in <= XPOS - position_p1 + position_p2 + 210) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 183 <= position_p1 - position_p2 && position_p1 - position_p2 <= 209 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 183)) && (hcount_in <= XPOS - position_p1 + position_p2 + 209) && (vcount_in == YPOS - 4) ||
                            ((XPOS + 120 <= position_p1 - position_p2 && position_p1 - position_p2 <= 206 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 120)) && (hcount_in <= XPOS - position_p1 + position_p2 + 206) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 120 <= position_p1 - position_p2 && position_p1 - position_p2 <= 203 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 120)) && (hcount_in <= XPOS - position_p1 + position_p2 + 203) && (vcount_in == YPOS - 18) ||
                            ((XPOS + 127 <= position_p1 - position_p2 && position_p1 - position_p2 <= 202 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 127)) && (hcount_in <= XPOS - position_p1 + position_p2 + 202) && (vcount_in >= YPOS - 21) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 127 <= position_p1 - position_p2 && position_p1 - position_p2 <= 202 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 127)) && (hcount_in <= XPOS - position_p1 + position_p2 + 202) && (vcount_in >= YPOS - 21) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 186 <= position_p1 - position_p2 && position_p1 - position_p2 <= 199 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 186)) && (hcount_in <= XPOS - position_p1 + position_p2 + 199) && (vcount_in >= YPOS - 24) && (vcount_in <= YPOS - 22) ||
                            (hcount_in == XPOS - position_p1 + position_p2 + 210) && (vcount_in == YPOS - 11)         
                )
                rgb_out_nxt = 12'hddc;   

                else if(
                            ((XPOS + 23 <= position_p1 - position_p2 && position_p1 - position_p2 <= 306 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 23)) && (hcount_in <= XPOS - position_p1 + position_p2 + 306) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 37) ||
                            ((XPOS + 99<= position_p1 - position_p2 && position_p1 - position_p2 <= 234 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 99)) && (hcount_in <= XPOS - position_p1 + position_p2 + 234) && (vcount_in >= YPOS + 38) && (vcount_in <= YPOS + 41) ||
                            ((XPOS + 4 <= position_p1 - position_p2 && position_p1 - position_p2 <= 19 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 4)) && (hcount_in <= XPOS - position_p1 + position_p2 + 19) && (vcount_in >= YPOS + 25) && (vcount_in <= YPOS + 31) ||
                            (hcount_in == XPOS - position_p1 + position_p2 + 3) && (hcount_in == XPOS - position_p1 + position_p2 + 27) ||
                            ((XPOS + 13 <= position_p1 - position_p2 && position_p1 - position_p2 <= 22 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 13)) && (hcount_in <= XPOS - position_p1 + position_p2 + 22) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 34)
                )
                rgb_out_nxt = RGB_3;    

                else if(    
                            ((XPOS <= position_p1 - position_p2 && position_p1 - position_p2 <= 5 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2)) && (hcount_in <= XPOS - position_p1 + position_p2 + 5) && (vcount_in >= YPOS) && (vcount_in <= YPOS + 2) ||
                            ((XPOS + 3 <= position_p1 - position_p2 && position_p1 - position_p2 <= 47 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 3)) && (hcount_in <= XPOS - position_p1 + position_p2 + 47) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS - 1) ||
                            ((XPOS + 28 <= position_p1 - position_p2 && position_p1 - position_p2 <= 47 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 28)) && (hcount_in <= XPOS - position_p1 + position_p2 + 47) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 4) ||
                            ((XPOS + 48 <= position_p1 - position_p2 && position_p1 - position_p2 <= 57 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 48)) && (hcount_in <= XPOS - position_p1 + position_p2 + 57) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) || 
                            ((XPOS + 58 <= position_p1 - position_p2 && position_p1 - position_p2 <= 68 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 58)) && (hcount_in <= XPOS - position_p1 + position_p2 + 68) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 69 <= position_p1 - position_p2 && position_p1 - position_p2 <= 75 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 69)) && (hcount_in <= XPOS - position_p1 + position_p2 + 75) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 76 <= position_p1 - position_p2 && position_p1 - position_p2 <= 85 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 76)) && (hcount_in <= XPOS - position_p1 + position_p2 + 85) && (vcount_in >= YPOS - 20) && (vcount_in <= YPOS - 18) ||
                            ((XPOS + 86 <= position_p1 - position_p2 && position_p1 - position_p2 <= 96 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 86)) && (hcount_in <= XPOS - position_p1 + position_p2 + 96) && (vcount_in >= YPOS - 24) && (vcount_in <= YPOS - 21) ||
                            ((XPOS + 97 <= position_p1 - position_p2 && position_p1 - position_p2 <= 103 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 97)) && (hcount_in <= XPOS - position_p1 + position_p2 + 103) && (vcount_in >= YPOS - 27) && (vcount_in <= YPOS - 25) ||
                            ((XPOS + 104 <= position_p1 - position_p2 && position_p1 - position_p2 <= 188 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 104)) && (hcount_in <= XPOS - position_p1 + position_p2 + 188) && (vcount_in >= YPOS - 31) && (vcount_in <= YPOS - 28) ||
                            ((XPOS + 189 <= position_p1 - position_p2 && position_p1 - position_p2 <= 198 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 189)) && (hcount_in <= XPOS - position_p1 + position_p2 + 198) && (vcount_in >= YPOS - 28) && (vcount_in <= YPOS - 26) ||
                            ((XPOS + 198 <= position_p1 - position_p2 && position_p1 - position_p2 <= 199 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 198)) && (hcount_in <= XPOS - position_p1 + position_p2 + 199) && (vcount_in == YPOS - 25) ||
                            ((XPOS + 217 <= position_p1 - position_p2 && position_p1 - position_p2 <= 261 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 217)) && (hcount_in <= XPOS - position_p1 + position_p2 + 261) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 262 <= position_p1 - position_p2 && position_p1 - position_p2 <= 282 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 262)) && (hcount_in <= XPOS - position_p1 + position_p2 + 282) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 283 <= position_p1 - position_p2 && position_p1 - position_p2 <= 299 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 283)) && (hcount_in <= XPOS - position_p1 + position_p2 + 299) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS - 2) ||
                            ((XPOS + 297 <= position_p1 - position_p2 && position_p1 - position_p2 <= 299 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 297)) && (hcount_in <= XPOS - position_p1 + position_p2 + 299) && (vcount_in >= YPOS - 1) && (vcount_in <= YPOS + 2) ||
                            ((XPOS + 300 <= position_p1 - position_p2 && position_p1 - position_p2 <= 309 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 300)) && (hcount_in <= XPOS - position_p1 + position_p2 + 309) && (vcount_in >= YPOS) && (vcount_in <= YPOS + 2) || 
                            ((XPOS + 307 <= position_p1 - position_p2 && position_p1 - position_p2 <= 309 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 307)) && (hcount_in <= XPOS - position_p1 + position_p2 + 309) && (vcount_in >= YPOS + 3)  && (vcount_in <= YPOS + 5) ||
                            ((XPOS + 310 <= position_p1 - position_p2 && position_p1 - position_p2 <= 313 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 310)) && (hcount_in <= XPOS - position_p1 + position_p2 + 313) && (vcount_in >= YPOS + 4)  && (vcount_in <= YPOS + 6) ||
                            ((XPOS + 311 <= position_p1 - position_p2 && position_p1 - position_p2 <= 317 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 311)) && (hcount_in <= XPOS - position_p1 + position_p2 + 317) && (vcount_in >= YPOS + 7)  && (vcount_in <= YPOS + 9) ||
                            ((XPOS <= position_p1 - position_p2 && position_p1 - position_p2 <= 2 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2)) && (hcount_in <= XPOS - position_p1 + position_p2 + 2) && (vcount_in >= YPOS + 3)  && (vcount_in <= YPOS + 13) ||
                            ((XPOS + 3 <= position_p1 - position_p2 && position_p1 - position_p2 <= 317 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 3)) && (hcount_in <= XPOS - position_p1 + position_p2 + 317) && (vcount_in >= YPOS + 10)  && (vcount_in <= YPOS + 26)       
                )
                rgb_out_nxt = RGB_2;

                else if(
                            ((XPOS + 3 <= position_p1 - position_p2 && position_p1 - position_p2 <= 282 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 3)) && (hcount_in <= XPOS - position_p1 + position_p2 + 282) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS + 9) ||
                            ((XPOS + 48 <= position_p1 - position_p2 && position_p1 - position_p2 <= 282 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 48)) && (hcount_in <= XPOS - position_p1 + position_p2 + 282) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 4) ||
                            ((XPOS + 283 <= position_p1 - position_p2 && position_p1 - position_p2 <= 296 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 283)) && (hcount_in <= XPOS - position_p1 + position_p2 + 296) && (vcount_in >= YPOS - 1) && (vcount_in <= YPOS + 9) ||
                            ((XPOS + 297 <= position_p1 - position_p2 && position_p1 - position_p2 <= 309 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 297)) && (hcount_in <= XPOS - position_p1 + position_p2 + 309) && (vcount_in >= YPOS + 3) && (vcount_in <= YPOS + 9) ||
                            ((XPOS + 310 <= position_p1 - position_p2 && position_p1 - position_p2 <= 310 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 310)) && (hcount_in <= XPOS - position_p1 + position_p2 + 310) && (vcount_in >= YPOS + 7) && (vcount_in <= YPOS + 9) ||
                            ((XPOS + 58 <= position_p1 - position_p2 && position_p1 - position_p2 <= 96 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 58)) && (hcount_in <= XPOS - position_p1 + position_p2 + 96) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 69 <= position_p1 - position_p2 && position_p1 - position_p2 <= 103 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 69)) && (hcount_in <= XPOS - position_p1 + position_p2 + 103) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 76 <= position_p1 - position_p2 && position_p1 - position_p2 <= 110 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 76)) && (hcount_in <= XPOS - position_p1 + position_p2 + 110) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 86 <= position_p1 - position_p2 && position_p1 - position_p2 <= 117 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 86)) && (hcount_in <= XPOS - position_p1 + position_p2 + 117) && (vcount_in >= YPOS - 20) && (vcount_in <= YPOS - 17) ||
                            ((XPOS + 97 <= position_p1 - position_p2 && position_p1 - position_p2 <= 197 + XPOS) || (hcount_in >= XPOS - position_p1 + position_p2 + 97)) && (hcount_in <= XPOS - position_p1 + position_p2 + 197) && (vcount_in >= YPOS - 27) && (vcount_in <= YPOS - 20)
                )
                rgb_out_nxt = RGB_1;
                //---------------------------------------------------------------------------------
                else rgb_out_nxt = rgb_in;
            end
        end
endmodule