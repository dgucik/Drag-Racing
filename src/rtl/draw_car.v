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
    input wire [31:0] p1_position,
    input wire [31:0] p2_position,
    input wire mov,
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
                            ((XPOS + 71 <= p1_position - p2_position && p1_position - p2_position <= 73 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 71)) && (hcount_in <= XPOS - p1_position + p2_position + 73) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 71 <= p1_position - p2_position && p1_position - p2_position <= 73 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 71)) && (hcount_in <= XPOS - p1_position + p2_position + 73) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 77 <= p1_position - p2_position && p1_position - p2_position <= 79 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 77)) && (hcount_in <= XPOS - p1_position + p2_position + 79) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 77 <= p1_position - p2_position && p1_position - p2_position <= 79 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 77)) && (hcount_in <= XPOS - p1_position + p2_position + 79) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 254 <= p1_position - p2_position && p1_position - p2_position <= 256 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 254)) && (hcount_in <= XPOS - p1_position + p2_position + 256) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 254 <= p1_position - p2_position && p1_position - p2_position <= 256 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 254)) && (hcount_in <= XPOS - p1_position + p2_position + 256) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 260 <= p1_position - p2_position && p1_position - p2_position <= 262 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 260)) && (hcount_in <= XPOS - p1_position + p2_position + 262) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 260 <= p1_position - p2_position && p1_position - p2_position <= 262 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 260)) && (hcount_in <= XPOS - p1_position + p2_position + 262) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42)
                        )
                )
                rgb_out_nxt = 12'h777;

                else if((mov == 1) && (
                            ((XPOS + 74 <= p1_position - p2_position && p1_position - p2_position <= 76 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 74)) && (hcount_in <= XPOS - p1_position + p2_position + 76) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 74 <= p1_position - p2_position && p1_position - p2_position <= 76 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 74)) && (hcount_in <= XPOS - p1_position + p2_position + 76) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 71 <= p1_position - p2_position && p1_position - p2_position <= 73 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 71)) && (hcount_in <= XPOS - p1_position + p2_position + 73) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39) ||
                            ((XPOS + 77 <= p1_position - p2_position && p1_position - p2_position <= 79 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 77)) && (hcount_in <= XPOS - p1_position + p2_position + 79) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39) ||
                            ((XPOS + 257 <= p1_position - p2_position && p1_position - p2_position <= 259 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 257)) && (hcount_in <= XPOS - p1_position + p2_position + 259) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 257 <= p1_position - p2_position && p1_position - p2_position <= 259 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 257)) && (hcount_in <= XPOS - p1_position + p2_position + 259) && (vcount_in >= YPOS + 40) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 254 <= p1_position - p2_position && p1_position - p2_position <= 256 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 254)) && (hcount_in <= XPOS - p1_position + p2_position + 256) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39) ||
                            ((XPOS + 260 <= p1_position - p2_position && p1_position - p2_position <= 262 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 260)) && (hcount_in <= XPOS - p1_position + p2_position + 262) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39)
                        )
                )
                rgb_out_nxt = 12'h777;

                else if(
                            ((XPOS + 71 <= p1_position - p2_position && p1_position - p2_position <= 79 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 71)) && (hcount_in <= XPOS - p1_position + p2_position + 79) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 254 <= p1_position - p2_position && p1_position - p2_position <= 262 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 254)) && (hcount_in <= XPOS - p1_position + p2_position + 262) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) 
                )
                rgb_out_nxt = 12'h445;

                else if(
                            ((XPOS + 67 <= p1_position - p2_position && p1_position - p2_position <= 83 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 67)) && (hcount_in <= XPOS - p1_position + p2_position + 83) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) || 
                            ((XPOS + 68 <= p1_position - p2_position && p1_position - p2_position <= 82 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 68)) && (hcount_in <= XPOS - p1_position + p2_position + 82) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 43) || 
                            ((XPOS + 69 <= p1_position - p2_position && p1_position - p2_position <= 81 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 69)) && (hcount_in <= XPOS - p1_position + p2_position + 81) && (vcount_in >= YPOS + 32) && (vcount_in <= YPOS + 44) ||
                            ((XPOS + 70 <= p1_position - p2_position && p1_position - p2_position <= 80 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 70)) && (hcount_in <= XPOS - p1_position + p2_position + 80) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||
                            ((XPOS + 71 <= p1_position - p2_position && p1_position - p2_position <= 79 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 71)) && (hcount_in <= XPOS - p1_position + p2_position + 79) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 46) ||
                            ((XPOS + 250 <= p1_position - p2_position && p1_position - p2_position <= 266 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 250)) && (hcount_in <= XPOS - p1_position + p2_position + 266) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) || 
                            ((XPOS + 251 <= p1_position - p2_position && p1_position - p2_position <= 265 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 251)) && (hcount_in <= XPOS - p1_position + p2_position + 265) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 43) || 
                            ((XPOS + 252 <= p1_position - p2_position && p1_position - p2_position <= 264 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 252)) && (hcount_in <= XPOS - p1_position + p2_position + 264) && (vcount_in >= YPOS + 32) && (vcount_in <= YPOS + 44) ||
                            ((XPOS + 253 <= p1_position - p2_position && p1_position - p2_position <= 263 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 253)) && (hcount_in <= XPOS - p1_position + p2_position + 263) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||
                            ((XPOS + 254 <= p1_position - p2_position && p1_position - p2_position <= 262 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 254)) && (hcount_in <= XPOS - p1_position + p2_position + 262) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 46) 
                )
                rgb_out_nxt = 12'h000;

                else if(
                            ((XPOS + 71 <= p1_position - p2_position && p1_position - p2_position <= 79 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 71)) && (hcount_in <= XPOS - p1_position + p2_position + 79) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 50) || 
                            ((XPOS + 63 <= p1_position - p2_position && p1_position - p2_position <= 87 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 63)) && (hcount_in <= XPOS - p1_position + p2_position + 87) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 64 <= p1_position - p2_position && p1_position - p2_position <= 86 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 64)) && (hcount_in <= XPOS - p1_position + p2_position + 86) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 43) ||
                            ((XPOS + 65 <= p1_position - p2_position && p1_position - p2_position <= 85 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 65)) && (hcount_in <= XPOS - p1_position + p2_position + 85) && (vcount_in >= YPOS + 32) && (vcount_in <= YPOS + 44) ||
                            ((XPOS + 66 <= p1_position - p2_position && p1_position - p2_position <= 84 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 66)) && (hcount_in <= XPOS - p1_position + p2_position + 84) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||   
                            ((XPOS + 67 <= p1_position - p2_position && p1_position - p2_position <= 83 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 67)) && (hcount_in <= XPOS - p1_position + p2_position + 83) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 46) ||
                            ((XPOS + 68 <= p1_position - p2_position && p1_position - p2_position <= 82 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 68)) && (hcount_in <= XPOS - p1_position + p2_position + 82) && (vcount_in >= YPOS + 29) && (vcount_in <= YPOS + 47) ||
                            ((XPOS + 69 <= p1_position - p2_position && p1_position - p2_position <= 81 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 69)) && (hcount_in <= XPOS - p1_position + p2_position + 81) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 48) ||
                            ((XPOS + 70 <= p1_position - p2_position && p1_position - p2_position <= 80 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 70)) && (hcount_in <= XPOS - p1_position + p2_position + 80) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 49) ||
                            ((XPOS + 254 <= p1_position - p2_position && p1_position - p2_position <= 262 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 254)) && (hcount_in <= XPOS - p1_position + p2_position + 262) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 50) || 
                            ((XPOS + 246 <= p1_position - p2_position && p1_position - p2_position <= 270 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 246)) && (hcount_in <= XPOS - p1_position + p2_position + 270) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 42) ||
                            ((XPOS + 247 <= p1_position - p2_position && p1_position - p2_position <= 269 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 247)) && (hcount_in <= XPOS - p1_position + p2_position + 269) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 43) ||
                            ((XPOS + 248 <= p1_position - p2_position && p1_position - p2_position <= 268 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 248)) && (hcount_in <= XPOS - p1_position + p2_position + 268) && (vcount_in >= YPOS + 32) && (vcount_in <= YPOS + 44) ||
                            ((XPOS + 249 <= p1_position - p2_position && p1_position - p2_position <= 267 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 249)) && (hcount_in <= XPOS - p1_position + p2_position + 267) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||   
                            ((XPOS + 250 <= p1_position - p2_position && p1_position - p2_position <= 266 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 250)) && (hcount_in <= XPOS - p1_position + p2_position + 266) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 46) ||
                            ((XPOS + 251 <= p1_position - p2_position && p1_position - p2_position <= 265 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 251)) && (hcount_in <= XPOS - p1_position + p2_position + 265) && (vcount_in >= YPOS + 29) && (vcount_in <= YPOS + 47) ||
                            ((XPOS + 252 <= p1_position - p2_position && p1_position - p2_position <= 264 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 252)) && (hcount_in <= XPOS - p1_position + p2_position + 264) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 48) ||
                            ((XPOS + 253 <= p1_position - p2_position && p1_position - p2_position <= 263 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 253)) && (hcount_in <= XPOS - p1_position + p2_position + 263) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 49)  
                            
                )
                rgb_out_nxt = 12'h222;

                else if(
                            ((XPOS + 68 <= p1_position - p2_position && p1_position - p2_position <= 82 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 68)) && (hcount_in <= XPOS - p1_position + p2_position + 82) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 59) ||
                            ((XPOS + 65 <= p1_position - p2_position && p1_position - p2_position <= 85 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 65)) && (hcount_in <= XPOS - p1_position + p2_position + 85) && (vcount_in >= YPOS + 18) && (vcount_in <= YPOS + 58) ||
                            ((XPOS + 54 <= p1_position - p2_position && p1_position - p2_position <= 96 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 54)) && (hcount_in <= XPOS - p1_position + p2_position + 96) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||
                            ((XPOS + 55 <= p1_position - p2_position && p1_position - p2_position <= 95 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 55)) && (hcount_in <= XPOS - p1_position + p2_position + 95) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 48) ||
                            ((XPOS + 56 <= p1_position - p2_position && p1_position - p2_position <= 94 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 56)) && (hcount_in <= XPOS - p1_position + p2_position + 94) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 49) ||
                            ((XPOS + 57 <= p1_position - p2_position && p1_position - p2_position <= 93 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 57)) && (hcount_in <= XPOS - p1_position + p2_position + 93) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 50) ||
                            ((XPOS + 58 <= p1_position - p2_position && p1_position - p2_position <= 92 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 58)) && (hcount_in <= XPOS - p1_position + p2_position + 92) && (vcount_in >= YPOS + 24) && (vcount_in <= YPOS + 52) ||
                            ((XPOS + 59 <= p1_position - p2_position && p1_position - p2_position <= 91 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 59)) && (hcount_in <= XPOS - p1_position + p2_position + 91) && (vcount_in >= YPOS + 23) && (vcount_in <= YPOS + 53) ||
                            ((XPOS + 60 <= p1_position - p2_position && p1_position - p2_position <= 90 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 60)) && (hcount_in <= XPOS - p1_position + p2_position + 90) && (vcount_in >= YPOS + 22) && (vcount_in <= YPOS + 54) ||
                            ((XPOS + 61 <= p1_position - p2_position && p1_position - p2_position <= 89 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 61)) && (hcount_in <= XPOS - p1_position + p2_position + 89) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 55) ||
                            ((XPOS + 63 <= p1_position - p2_position && p1_position - p2_position <= 87 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 63)) && (hcount_in <= XPOS - p1_position + p2_position + 87) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 56) ||
                            ((XPOS + 63 <= p1_position - p2_position && p1_position - p2_position <= 87 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 63)) && (hcount_in <= XPOS - p1_position + p2_position + 87) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 56) ||
                            ((XPOS + 64 <= p1_position - p2_position && p1_position - p2_position <= 86 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 64)) && (hcount_in <= XPOS - p1_position + p2_position + 86) && (vcount_in >= YPOS + 19) && (vcount_in <= YPOS + 57) ||
                            ((XPOS + 251 <= p1_position - p2_position && p1_position - p2_position <= 265 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 251)) && (hcount_in <= XPOS - p1_position + p2_position + 265) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 59) ||
                            ((XPOS + 248 <= p1_position - p2_position && p1_position - p2_position <= 268 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 248)) && (hcount_in <= XPOS - p1_position + p2_position + 268) && (vcount_in >= YPOS + 18) && (vcount_in <= YPOS + 58) ||
                            ((XPOS + 237 <= p1_position - p2_position && p1_position - p2_position <= 279 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 237)) && (hcount_in <= XPOS - p1_position + p2_position + 279) && (vcount_in >= YPOS + 31) && (vcount_in <= YPOS + 45) ||
                            ((XPOS + 238 <= p1_position - p2_position && p1_position - p2_position <= 278 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 238)) && (hcount_in <= XPOS - p1_position + p2_position + 278) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 48) ||
                            ((XPOS + 239 <= p1_position - p2_position && p1_position - p2_position <= 277 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 239)) && (hcount_in <= XPOS - p1_position + p2_position + 277) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 49) ||
                            ((XPOS + 240 <= p1_position - p2_position && p1_position - p2_position <= 276 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 240)) && (hcount_in <= XPOS - p1_position + p2_position + 276) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 50) ||
                            ((XPOS + 241 <= p1_position - p2_position && p1_position - p2_position <= 275 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 241)) && (hcount_in <= XPOS - p1_position + p2_position + 275) && (vcount_in >= YPOS + 24) && (vcount_in <= YPOS + 52) ||
                            ((XPOS + 242 <= p1_position - p2_position && p1_position - p2_position <= 274 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 242)) && (hcount_in <= XPOS - p1_position + p2_position + 274) && (vcount_in >= YPOS + 23) && (vcount_in <= YPOS + 53) ||
                            ((XPOS + 243 <= p1_position - p2_position && p1_position - p2_position <= 273 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 243)) && (hcount_in <= XPOS - p1_position + p2_position + 273) && (vcount_in >= YPOS + 22) && (vcount_in <= YPOS + 54) ||
                            ((XPOS + 244<= p1_position - p2_position && p1_position - p2_position <= 272 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 244)) && (hcount_in <= XPOS - p1_position + p2_position + 272) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 55) ||
                            ((XPOS + 246 <= p1_position - p2_position && p1_position - p2_position <= 270 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 246)) && (hcount_in <= XPOS - p1_position + p2_position + 270) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 56) ||
                            ((XPOS + 246 <= p1_position - p2_position && p1_position - p2_position <= 270 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 246)) && (hcount_in <= XPOS - p1_position + p2_position + 270) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 56) ||
                            ((XPOS + 247 <= p1_position - p2_position && p1_position - p2_position <= 269 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 247)) && (hcount_in <= XPOS - p1_position + p2_position + 269) && (vcount_in >= YPOS + 19) && (vcount_in <= YPOS + 57)
                )
                rgb_out_nxt = 12'h000;

                else if(
                            ((XPOS + 142 <= p1_position - p2_position && p1_position - p2_position <= 150 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 142)) && (hcount_in <= XPOS - p1_position + p2_position + 150) && (vcount_in >= YPOS) && (vcount_in <= YPOS + 2) ||
                            ((XPOS + 142 <= p1_position - p2_position && p1_position - p2_position <= 144 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 142)) && (hcount_in <= XPOS - p1_position + p2_position + 144) && (vcount_in == YPOS + 3) ||
                            ((XPOS + 142 <= p1_position - p2_position && p1_position - p2_position <= 143 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 142)) && (hcount_in <= XPOS - p1_position + p2_position + 143) && (vcount_in >= YPOS + 4) && (vcount_in <= YPOS + 5) ||
                            (hcount_in == XPOS - p1_position + p2_position + 51) && (vcount_in == YPOS + 37) ||
                            ((XPOS + 52 <= p1_position - p2_position && p1_position - p2_position <= 98 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 52)) && (hcount_in <= XPOS - p1_position + p2_position + 98) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 37) ||
                            ((XPOS + 97<= p1_position - p2_position && p1_position - p2_position <= 98 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 97)) && (hcount_in <= XPOS - p1_position + p2_position + 98) && (vcount_in >= YPOS + 38) && (vcount_in <= YPOS + 41) ||
                            (hcount_in == XPOS - p1_position + p2_position + 99) && (vcount_in == YPOS + 41) ||
                            ((XPOS + 53 <= p1_position - p2_position && p1_position - p2_position <= 97 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 53)) && (hcount_in <= XPOS - p1_position + p2_position + 97) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 29) ||
                            ((XPOS + 53 <= p1_position - p2_position && p1_position - p2_position <= 97 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 53)) && (hcount_in <= XPOS - p1_position + p2_position + 97) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 29) ||
                            ((XPOS + 54 <= p1_position - p2_position && p1_position - p2_position <= 96 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 54)) && (hcount_in <= XPOS - p1_position + p2_position + 96) && (vcount_in == YPOS + 25) ||
                            ((XPOS + 55 <= p1_position - p2_position && p1_position - p2_position <= 95 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 55)) && (hcount_in <= XPOS - p1_position + p2_position + 95) && (vcount_in == YPOS + 24) ||
                            ((XPOS + 56 <= p1_position - p2_position && p1_position - p2_position <= 94 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 56)) && (hcount_in <= XPOS - p1_position + p2_position + 94) && (vcount_in >= YPOS + 22) && (vcount_in <= YPOS + 23) ||
                            ((XPOS + 57 <= p1_position - p2_position && p1_position - p2_position <= 93 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 57)) && (hcount_in <= XPOS - p1_position + p2_position + 93) && (vcount_in == YPOS + 21) ||
                            ((XPOS + 58 <= p1_position - p2_position && p1_position - p2_position <= 92 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 58)) && (hcount_in <= XPOS - p1_position + p2_position + 92) && (vcount_in == YPOS + 20) ||
                            ((XPOS + 59 <= p1_position - p2_position && p1_position - p2_position <= 91 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 59)) && (hcount_in <= XPOS - p1_position + p2_position + 91) && (vcount_in == YPOS + 19) ||
                            ((XPOS + 61 <= p1_position - p2_position && p1_position - p2_position <= 89 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 61)) && (hcount_in <= XPOS - p1_position + p2_position + 89) && (vcount_in == YPOS + 18) ||
                            ((XPOS + 62 <= p1_position - p2_position && p1_position - p2_position <= 88 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 62)) && (hcount_in <= XPOS - p1_position + p2_position + 88) && (vcount_in == YPOS + 17) ||
                            ((XPOS + 63 <= p1_position - p2_position && p1_position - p2_position <= 87 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 63)) && (hcount_in <= XPOS - p1_position + p2_position + 87) && (vcount_in == YPOS + 16) ||
                            ((XPOS + 66 <= p1_position - p2_position && p1_position - p2_position <= 84 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 66)) && (hcount_in <= XPOS - p1_position + p2_position + 84) && (vcount_in == YPOS + 15) ||
                            (hcount_in == XPOS - p1_position + p2_position + 282) && (vcount_in == YPOS + 37) ||
                            ((XPOS + 235 <= p1_position - p2_position && p1_position - p2_position <= 281 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 235)) && (hcount_in <= XPOS - p1_position + p2_position + 281) && (vcount_in >= YPOS + 30) && (vcount_in <= YPOS + 37) ||
                            ((XPOS + 236 <= p1_position - p2_position && p1_position - p2_position <= 280 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 236)) && (hcount_in <= XPOS - p1_position + p2_position + 280) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 29) ||
                            ((XPOS + 236 <= p1_position - p2_position && p1_position - p2_position <= 280 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 236)) && (hcount_in <= XPOS - p1_position + p2_position + 280) && (vcount_in >= YPOS + 26) && (vcount_in <= YPOS + 29) ||
                            ((XPOS + 237 <= p1_position - p2_position && p1_position - p2_position <= 279 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 237)) && (hcount_in <= XPOS - p1_position + p2_position + 279) && (vcount_in == YPOS + 25) ||
                            ((XPOS + 238 <= p1_position - p2_position && p1_position - p2_position <= 278 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 238)) && (hcount_in <= XPOS - p1_position + p2_position + 278) && (vcount_in == YPOS + 24) ||
                            ((XPOS + 239 <= p1_position - p2_position && p1_position - p2_position <= 277 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 239)) && (hcount_in <= XPOS - p1_position + p2_position + 277) && (vcount_in >= YPOS + 22) && (vcount_in <= YPOS + 23) ||
                            ((XPOS + 240 <= p1_position - p2_position && p1_position - p2_position <= 276 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 240)) && (hcount_in <= XPOS - p1_position + p2_position + 276) && (vcount_in == YPOS + 21) ||
                            ((XPOS + 241 <= p1_position - p2_position && p1_position - p2_position <= 275 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 241)) && (hcount_in <= XPOS - p1_position + p2_position + 275) && (vcount_in == YPOS + 20) ||
                            ((XPOS + 242 <= p1_position - p2_position && p1_position - p2_position <= 274 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 242)) && (hcount_in <= XPOS - p1_position + p2_position + 274) && (vcount_in == YPOS + 19) ||
                            ((XPOS + 244 <= p1_position - p2_position && p1_position - p2_position <= 272 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 244)) && (hcount_in <= XPOS - p1_position + p2_position + 272) && (vcount_in == YPOS + 18) ||
                            ((XPOS + 245 <= p1_position - p2_position && p1_position - p2_position <= 271 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 245)) && (hcount_in <= XPOS - p1_position + p2_position + 271) && (vcount_in == YPOS + 17) ||
                            ((XPOS + 246 <= p1_position - p2_position && p1_position - p2_position <= 270 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 246)) && (hcount_in <= XPOS - p1_position + p2_position + 270) && (vcount_in == YPOS + 16) ||
                            ((XPOS + 249 <= p1_position - p2_position && p1_position - p2_position <= 267 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 249)) && (hcount_in <= XPOS - p1_position + p2_position + 267) && (vcount_in == YPOS + 15) ||
                            ((XPOS + 235 <= p1_position - p2_position && p1_position - p2_position <= 236 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 235)) && (hcount_in <= XPOS - p1_position + p2_position + 236) && (vcount_in >= YPOS + 38) && (vcount_in <= YPOS + 41) ||
                            (hcount_in == XPOS - p1_position + p2_position + 234) && (vcount_in == YPOS + 41)                       
                )
                rgb_out_nxt = 12'h322;

                else if(
                            ((XPOS + 49 <= p1_position - p2_position && p1_position - p2_position <= 95 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 49)) && (hcount_in <= XPOS - p1_position + p2_position + 95) && (vcount_in >= YPOS - 4) && (vcount_in <= YPOS - 1) ||
                            (hcount_in == XPOS - p1_position + p2_position + 48) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS - 2) ||
                            ((XPOS + 93 <= p1_position - p2_position && p1_position - p2_position <= 98 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 93)) && (hcount_in <= XPOS - p1_position + p2_position + 98) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 97 <= p1_position - p2_position && p1_position - p2_position <= 99 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 97)) && (hcount_in <= XPOS - p1_position + p2_position + 99) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8)
                )
                rgb_out_nxt = 12'h666;

                else if(
                            ((XPOS + 294 <= p1_position - p2_position && p1_position - p2_position <= 295 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 294)) && (hcount_in <= XPOS - p1_position + p2_position + 295) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 23) ||
                            ((XPOS + 24 <= p1_position - p2_position && p1_position - p2_position <= 50 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 24)) && (hcount_in <= XPOS - p1_position + p2_position + 50) && (vcount_in >= YPOS + 38) && (vcount_in <= YPOS + 40) ||
                            ((XPOS + 100 <= p1_position - p2_position && p1_position - p2_position <= 233 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 100)) && (hcount_in <= XPOS - p1_position + p2_position + 233) && (vcount_in >= YPOS + 42) && (vcount_in <= YPOS + 43) ||
                            ((XPOS + 135 <= p1_position - p2_position && p1_position - p2_position <= 137 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 135)) && (hcount_in <= XPOS - p1_position + p2_position + 137) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS + 41) ||
                            ((XPOS + 135 <= p1_position - p2_position && p1_position - p2_position <= 137 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 135)) && (hcount_in <= XPOS - p1_position + p2_position + 137) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS + 41) || 
                            ((XPOS + 138 <= p1_position - p2_position && p1_position - p2_position <= 181 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 138)) && (hcount_in <= XPOS - p1_position + p2_position + 181) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 180 <= p1_position - p2_position && p1_position - p2_position <= 216 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 180)) && (hcount_in <= XPOS - p1_position + p2_position + 216) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS - 2) ||
                            ((XPOS + 214 <= p1_position - p2_position && p1_position - p2_position <= 216 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 214)) && (hcount_in <= XPOS - p1_position + p2_position + 216) && (vcount_in >= YPOS - 1) && (vcount_in <= YPOS + 41) ||
                            ((XPOS + 283 <= p1_position - p2_position && p1_position - p2_position <= 316 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 283)) && (hcount_in <= XPOS - p1_position + p2_position + 316) && (vcount_in >= YPOS + 37) && (vcount_in <= YPOS + 39) ||
                            ((XPOS + 301 <= p1_position - p2_position && p1_position - p2_position <= 317 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 301)) && (hcount_in <= XPOS - p1_position + p2_position + 317) && (vcount_in >= YPOS + 34) && (vcount_in <= YPOS + 36) ||
                            ((XPOS + 307 <= p1_position - p2_position && p1_position - p2_position <= 320 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 307)) && (hcount_in <= XPOS - p1_position + p2_position + 320) && (vcount_in >= YPOS + 33) && (vcount_in <= YPOS + 35) ||
                            ((XPOS + 318 <= p1_position - p2_position && p1_position - p2_position <= 319 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 318)) && (hcount_in <= XPOS - p1_position + p2_position + 319) && (vcount_in >= YPOS + 7) && (vcount_in <= YPOS + 19) || 
                            (hcount_in == XPOS - p1_position + p2_position + 320) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 19) ||
                            ((XPOS + 321 <= p1_position - p2_position && p1_position - p2_position <= 323 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 321)) && (hcount_in <= XPOS - p1_position + p2_position + 323) && (vcount_in >= YPOS + 18) && (vcount_in <= YPOS + 33) || 
                            ((XPOS + 100 <= p1_position - p2_position && p1_position - p2_position <= 134 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 100)) && (hcount_in <= XPOS - p1_position + p2_position + 134) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 100 <= p1_position - p2_position && p1_position - p2_position <= 134 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 100)) && (hcount_in <= XPOS - p1_position + p2_position + 134) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||  
                            ((XPOS + 104 <= p1_position - p2_position && p1_position - p2_position <= 112 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 104)) && (hcount_in <= XPOS - p1_position + p2_position + 112) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 104 <= p1_position - p2_position && p1_position - p2_position <= 112 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 104)) && (hcount_in <= XPOS - p1_position + p2_position + 112) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 111 <= p1_position - p2_position && p1_position - p2_position <= 119 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 111)) && (hcount_in <= XPOS - p1_position + p2_position + 119) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 118 <= p1_position - p2_position && p1_position - p2_position <= 119 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 118)) && (hcount_in <= XPOS - p1_position + p2_position + 119) && (vcount_in == YPOS - 18) ||
                            ((XPOS + 118 <= p1_position - p2_position && p1_position - p2_position <= 126 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 118)) && (hcount_in <= XPOS - p1_position + p2_position + 126) && (vcount_in >= YPOS - 20) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 118 <= p1_position - p2_position && p1_position - p2_position <= 126 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 118)) && (hcount_in <= XPOS - p1_position + p2_position + 126) && (vcount_in >= YPOS - 20) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 124 <= p1_position - p2_position && p1_position - p2_position <= 126 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 124)) && (hcount_in <= XPOS - p1_position + p2_position + 126) && (vcount_in >= YPOS - 24) && (vcount_in <= YPOS - 21) || 
                            ((XPOS + 127 <= p1_position - p2_position && p1_position - p2_position <= 185 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 127)) && (hcount_in <= XPOS - p1_position + p2_position + 185) && (vcount_in >= YPOS - 24) && (vcount_in <= YPOS - 22) ||
                            ((XPOS + 180 <= p1_position - p2_position && p1_position - p2_position <= 185 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 180)) && (hcount_in <= XPOS - p1_position + p2_position + 185) && (vcount_in >= YPOS - 21) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 180 <= p1_position - p2_position && p1_position - p2_position <= 181 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 180)) && (hcount_in <= XPOS - p1_position + p2_position + 181) && (vcount_in >= YPOS - 18) && (vcount_in <= YPOS - 8) ||
                            (hcount_in == XPOS - p1_position + p2_position + 182) && (vcount_in == YPOS - 18) ||
                            ((XPOS + 180 <= p1_position - p2_position && p1_position - p2_position <= 181 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 180)) && (hcount_in <= XPOS - p1_position + p2_position + 181) && (vcount_in >= YPOS - 18) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 193 <= p1_position - p2_position && p1_position - p2_position <= 199 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 193)) && (hcount_in <= XPOS - p1_position + p2_position + 199) && (vcount_in == YPOS - 4)||
                            ((XPOS + 194 <= p1_position - p2_position && p1_position - p2_position <= 199 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 194)) && (hcount_in <= XPOS - p1_position + p2_position + 199) && (vcount_in >= YPOS - 6) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 180 <= p1_position - p2_position && p1_position - p2_position <= 182 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 180)) && (hcount_in <= XPOS - p1_position + p2_position + 182) && (vcount_in == YPOS - 4) ||
                            ((XPOS + 210 <= p1_position - p2_position && p1_position - p2_position <= 216 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 210)) && (hcount_in <= XPOS - p1_position + p2_position + 216) && (vcount_in == YPOS - 4) ||
                            ((XPOS + 211 <= p1_position - p2_position && p1_position - p2_position <= 216 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 211)) && (hcount_in <= XPOS - p1_position + p2_position + 216) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 214 <= p1_position - p2_position && p1_position - p2_position <= 216 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 214)) && (hcount_in <= XPOS - p1_position + p2_position + 216) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 194 <= p1_position - p2_position && p1_position - p2_position <= 198 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 194)) && (hcount_in <= XPOS - p1_position + p2_position + 198) && (vcount_in == YPOS - 7) ||
                            (hcount_in == XPOS - p1_position + p2_position + 213) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 193 <= p1_position - p2_position && p1_position - p2_position <= 196 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 193)) && (hcount_in <= XPOS - p1_position + p2_position + 196) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 193 <= p1_position - p2_position && p1_position - p2_position <= 196 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 193)) && (hcount_in <= XPOS - p1_position + p2_position + 196) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 190 <= p1_position - p2_position && p1_position - p2_position <= 195 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 190)) && (hcount_in <= XPOS - p1_position + p2_position + 195) && (vcount_in >= YPOS - 11) && (vcount_in <= YPOS - 9) ||
                            ((XPOS + 186 <= p1_position - p2_position && p1_position - p2_position <= 189 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 186)) && (hcount_in <= XPOS - p1_position + p2_position + 189) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 189 <= p1_position - p2_position && p1_position - p2_position <= 192 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 189)) && (hcount_in <= XPOS - p1_position + p2_position + 192) && (vcount_in >= YPOS - 13) && (vcount_in <= YPOS - 12) ||
                            ((XPOS + 189 <= p1_position - p2_position && p1_position - p2_position <= 191 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 189)) && (hcount_in <= XPOS - p1_position + p2_position + 191) && (vcount_in == YPOS - 14) ||
                            ((XPOS + 186 <= p1_position - p2_position && p1_position - p2_position <= 188 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 186)) && (hcount_in <= XPOS - p1_position + p2_position + 188) && (vcount_in == YPOS - 18)
                )
                rgb_out_nxt = 12'h000;

                else if(
                            (hcount_in == XPOS - p1_position + p2_position + 296) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 23)   
                )
                rgb_out_nxt = 12'h650; 

                else if(
                            ((XPOS + 297 <= p1_position - p2_position && p1_position - p2_position <= 302 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 297)) && (hcount_in <= XPOS - p1_position + p2_position + 302) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 23)   
                )
                rgb_out_nxt = 12'hfd1; 

                else if(
                            ((XPOS - 1 <= p1_position - p2_position && p1_position - p2_position <= 2 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position - 1)) && (hcount_in <= XPOS - p1_position + p2_position + 2) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 23) ||
                            ((XPOS - 4 <= p1_position - p2_position && p1_position - p2_position <= XPOS - 2) || (hcount_in >= XPOS - p1_position + p2_position - 4)) && (hcount_in <= XPOS - p1_position + p2_position - 2) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 20) ||
                            ((XPOS + 310 <= p1_position - p2_position && p1_position - p2_position <= 317 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 310)) && (hcount_in <= XPOS - p1_position + p2_position + 317) && (vcount_in >= YPOS + 24) && (vcount_in <= YPOS + 27) || 
                            ((XPOS + 314 <= p1_position - p2_position && p1_position - p2_position <= 317 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 314)) && (hcount_in <= XPOS - p1_position + p2_position + 317) && (vcount_in >= YPOS + 28) && (vcount_in <= YPOS + 30)    
                )
                rgb_out_nxt = 12'hbcc; 

                else if(
                            ((XPOS - 4 <= p1_position - p2_position && p1_position - p2_position <= 2 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position - 4)) && (hcount_in <= XPOS - p1_position + p2_position + 2) && (vcount_in >= YPOS + 14) && (vcount_in <= YPOS + 16) ||
                            ((XPOS + 3 <= p1_position - p2_position && p1_position - p2_position <= 5 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 3)) && (hcount_in <= XPOS - p1_position + p2_position + 5) && (vcount_in >= YPOS + 17) && (vcount_in <= YPOS + 26) ||
                            ((XPOS - 4 <= p1_position - p2_position && p1_position - p2_position <= 2 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position - 4)) && (hcount_in <= XPOS - p1_position + p2_position + 2) && (vcount_in >= YPOS + 24) && (vcount_in <= YPOS + 26) ||
                            ((XPOS - 4 <= p1_position - p2_position && p1_position - p2_position <= XPOS - 1) || (hcount_in >= XPOS - p1_position + p2_position - 4)) && (hcount_in <= XPOS - p1_position + p2_position - 1) && (vcount_in >= YPOS + 21) && (vcount_in <= YPOS + 23) || 
                            ((XPOS + 307 <= p1_position - p2_position && p1_position - p2_position <= 320 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 307)) && (hcount_in <= XPOS - p1_position + p2_position + 320) && (vcount_in >= YPOS + 20) && (vcount_in <= YPOS + 33)    
                )
                rgb_out_nxt = 12'h455;

                else if(
                            ((XPOS + 113 <= p1_position - p2_position && p1_position - p2_position <= 209 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 113)) && (hcount_in <= XPOS - p1_position + p2_position + 209) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 138 <= p1_position - p2_position && p1_position - p2_position <= 212 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 138)) && (hcount_in <= XPOS - p1_position + p2_position + 212) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 182 <= p1_position - p2_position && p1_position - p2_position <= 210 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 182)) && (hcount_in <= XPOS - p1_position + p2_position + 210) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 183 <= p1_position - p2_position && p1_position - p2_position <= 209 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 183)) && (hcount_in <= XPOS - p1_position + p2_position + 209) && (vcount_in == YPOS - 4) ||
                            ((XPOS + 120 <= p1_position - p2_position && p1_position - p2_position <= 206 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 120)) && (hcount_in <= XPOS - p1_position + p2_position + 206) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 120 <= p1_position - p2_position && p1_position - p2_position <= 203 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 120)) && (hcount_in <= XPOS - p1_position + p2_position + 203) && (vcount_in == YPOS - 18) ||
                            ((XPOS + 127 <= p1_position - p2_position && p1_position - p2_position <= 202 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 127)) && (hcount_in <= XPOS - p1_position + p2_position + 202) && (vcount_in >= YPOS - 21) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 127 <= p1_position - p2_position && p1_position - p2_position <= 202 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 127)) && (hcount_in <= XPOS - p1_position + p2_position + 202) && (vcount_in >= YPOS - 21) && (vcount_in <= YPOS - 19) ||
                            ((XPOS + 186 <= p1_position - p2_position && p1_position - p2_position <= 199 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 186)) && (hcount_in <= XPOS - p1_position + p2_position + 199) && (vcount_in >= YPOS - 24) && (vcount_in <= YPOS - 22) ||
                            (hcount_in == XPOS - p1_position + p2_position + 210) && (vcount_in == YPOS - 11)         
                )
                rgb_out_nxt = 12'hddc;   

                else if(
                            ((XPOS + 23 <= p1_position - p2_position && p1_position - p2_position <= 306 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 23)) && (hcount_in <= XPOS - p1_position + p2_position + 306) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 37) ||
                            ((XPOS + 99<= p1_position - p2_position && p1_position - p2_position <= 234 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 99)) && (hcount_in <= XPOS - p1_position + p2_position + 234) && (vcount_in >= YPOS + 38) && (vcount_in <= YPOS + 41) ||
                            ((XPOS + 4 <= p1_position - p2_position && p1_position - p2_position <= 19 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 4)) && (hcount_in <= XPOS - p1_position + p2_position + 19) && (vcount_in >= YPOS + 25) && (vcount_in <= YPOS + 31) ||
                            (hcount_in == XPOS - p1_position + p2_position + 3) && (hcount_in == XPOS - p1_position + p2_position + 27) ||
                            ((XPOS + 13 <= p1_position - p2_position && p1_position - p2_position <= 22 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 13)) && (hcount_in <= XPOS - p1_position + p2_position + 22) && (vcount_in >= YPOS + 27) && (vcount_in <= YPOS + 34)
                )
                rgb_out_nxt = RGB_3;    

                else if(    
                            ((XPOS <= p1_position - p2_position && p1_position - p2_position <= 5 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position)) && (hcount_in <= XPOS - p1_position + p2_position + 5) && (vcount_in >= YPOS) && (vcount_in <= YPOS + 2) ||
                            ((XPOS + 3 <= p1_position - p2_position && p1_position - p2_position <= 47 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 3)) && (hcount_in <= XPOS - p1_position + p2_position + 47) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS - 1) ||
                            ((XPOS + 28 <= p1_position - p2_position && p1_position - p2_position <= 47 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 28)) && (hcount_in <= XPOS - p1_position + p2_position + 47) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 4) ||
                            ((XPOS + 48 <= p1_position - p2_position && p1_position - p2_position <= 57 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 48)) && (hcount_in <= XPOS - p1_position + p2_position + 57) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) || 
                            ((XPOS + 58 <= p1_position - p2_position && p1_position - p2_position <= 68 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 58)) && (hcount_in <= XPOS - p1_position + p2_position + 68) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 69 <= p1_position - p2_position && p1_position - p2_position <= 75 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 69)) && (hcount_in <= XPOS - p1_position + p2_position + 75) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 76 <= p1_position - p2_position && p1_position - p2_position <= 85 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 76)) && (hcount_in <= XPOS - p1_position + p2_position + 85) && (vcount_in >= YPOS - 20) && (vcount_in <= YPOS - 18) ||
                            ((XPOS + 86 <= p1_position - p2_position && p1_position - p2_position <= 96 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 86)) && (hcount_in <= XPOS - p1_position + p2_position + 96) && (vcount_in >= YPOS - 24) && (vcount_in <= YPOS - 21) ||
                            ((XPOS + 97 <= p1_position - p2_position && p1_position - p2_position <= 103 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 97)) && (hcount_in <= XPOS - p1_position + p2_position + 103) && (vcount_in >= YPOS - 27) && (vcount_in <= YPOS - 25) ||
                            ((XPOS + 104 <= p1_position - p2_position && p1_position - p2_position <= 188 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 104)) && (hcount_in <= XPOS - p1_position + p2_position + 188) && (vcount_in >= YPOS - 31) && (vcount_in <= YPOS - 28) ||
                            ((XPOS + 189 <= p1_position - p2_position && p1_position - p2_position <= 198 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 189)) && (hcount_in <= XPOS - p1_position + p2_position + 198) && (vcount_in >= YPOS - 28) && (vcount_in <= YPOS - 26) ||
                            ((XPOS + 198 <= p1_position - p2_position && p1_position - p2_position <= 199 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 198)) && (hcount_in <= XPOS - p1_position + p2_position + 199) && (vcount_in == YPOS - 25) ||
                            ((XPOS + 217 <= p1_position - p2_position && p1_position - p2_position <= 261 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 217)) && (hcount_in <= XPOS - p1_position + p2_position + 261) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 262 <= p1_position - p2_position && p1_position - p2_position <= 282 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 262)) && (hcount_in <= XPOS - p1_position + p2_position + 282) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 5) ||
                            ((XPOS + 283 <= p1_position - p2_position && p1_position - p2_position <= 299 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 283)) && (hcount_in <= XPOS - p1_position + p2_position + 299) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS - 2) ||
                            ((XPOS + 297 <= p1_position - p2_position && p1_position - p2_position <= 299 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 297)) && (hcount_in <= XPOS - p1_position + p2_position + 299) && (vcount_in >= YPOS - 1) && (vcount_in <= YPOS + 2) ||
                            ((XPOS + 300 <= p1_position - p2_position && p1_position - p2_position <= 309 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 300)) && (hcount_in <= XPOS - p1_position + p2_position + 309) && (vcount_in >= YPOS) && (vcount_in <= YPOS + 2) || 
                            ((XPOS + 307 <= p1_position - p2_position && p1_position - p2_position <= 309 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 307)) && (hcount_in <= XPOS - p1_position + p2_position + 309) && (vcount_in >= YPOS + 3)  && (vcount_in <= YPOS + 5) ||
                            ((XPOS + 310 <= p1_position - p2_position && p1_position - p2_position <= 313 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 310)) && (hcount_in <= XPOS - p1_position + p2_position + 313) && (vcount_in >= YPOS + 4)  && (vcount_in <= YPOS + 6) ||
                            ((XPOS + 311 <= p1_position - p2_position && p1_position - p2_position <= 317 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 311)) && (hcount_in <= XPOS - p1_position + p2_position + 317) && (vcount_in >= YPOS + 7)  && (vcount_in <= YPOS + 9) ||
                            ((XPOS <= p1_position - p2_position && p1_position - p2_position <= 2 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position)) && (hcount_in <= XPOS - p1_position + p2_position + 2) && (vcount_in >= YPOS + 3)  && (vcount_in <= YPOS + 13) ||
                            ((XPOS + 3 <= p1_position - p2_position && p1_position - p2_position <= 317 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 3)) && (hcount_in <= XPOS - p1_position + p2_position + 317) && (vcount_in >= YPOS + 10)  && (vcount_in <= YPOS + 26)       
                )
                rgb_out_nxt = RGB_2;

                else if(
                            ((XPOS + 3 <= p1_position - p2_position && p1_position - p2_position <= 282 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 3)) && (hcount_in <= XPOS - p1_position + p2_position + 282) && (vcount_in >= YPOS - 3) && (vcount_in <= YPOS + 9) ||
                            ((XPOS + 48 <= p1_position - p2_position && p1_position - p2_position <= 282 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 48)) && (hcount_in <= XPOS - p1_position + p2_position + 282) && (vcount_in >= YPOS - 7) && (vcount_in <= YPOS - 4) ||
                            ((XPOS + 283 <= p1_position - p2_position && p1_position - p2_position <= 296 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 283)) && (hcount_in <= XPOS - p1_position + p2_position + 296) && (vcount_in >= YPOS - 1) && (vcount_in <= YPOS + 9) ||
                            ((XPOS + 297 <= p1_position - p2_position && p1_position - p2_position <= 309 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 297)) && (hcount_in <= XPOS - p1_position + p2_position + 309) && (vcount_in >= YPOS + 3) && (vcount_in <= YPOS + 9) ||
                            ((XPOS + 310 <= p1_position - p2_position && p1_position - p2_position <= 310 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 310)) && (hcount_in <= XPOS - p1_position + p2_position + 310) && (vcount_in >= YPOS + 7) && (vcount_in <= YPOS + 9) ||
                            ((XPOS + 58 <= p1_position - p2_position && p1_position - p2_position <= 96 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 58)) && (hcount_in <= XPOS - p1_position + p2_position + 96) && (vcount_in >= YPOS - 10) && (vcount_in <= YPOS - 8) ||
                            ((XPOS + 69 <= p1_position - p2_position && p1_position - p2_position <= 103 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 69)) && (hcount_in <= XPOS - p1_position + p2_position + 103) && (vcount_in >= YPOS - 14) && (vcount_in <= YPOS - 11) ||
                            ((XPOS + 76 <= p1_position - p2_position && p1_position - p2_position <= 110 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 76)) && (hcount_in <= XPOS - p1_position + p2_position + 110) && (vcount_in >= YPOS - 17) && (vcount_in <= YPOS - 15) ||
                            ((XPOS + 86 <= p1_position - p2_position && p1_position - p2_position <= 117 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 86)) && (hcount_in <= XPOS - p1_position + p2_position + 117) && (vcount_in >= YPOS - 20) && (vcount_in <= YPOS - 17) ||
                            ((XPOS + 97 <= p1_position - p2_position && p1_position - p2_position <= 197 + XPOS) || (hcount_in >= XPOS - p1_position + p2_position + 97)) && (hcount_in <= XPOS - p1_position + p2_position + 197) && (vcount_in >= YPOS - 27) && (vcount_in <= YPOS - 20)
                )
                rgb_out_nxt = RGB_1;
                //---------------------------------------------------------------------------------
                else rgb_out_nxt = rgb_in;
            end
        end
endmodule