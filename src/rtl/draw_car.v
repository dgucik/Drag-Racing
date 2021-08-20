//draw_car HORIZONTAL/VERTICAL: 328px/91 px
module draw_car
#(
    parameter   RGB_1 = 12'hF83,
                RGB_2 = 12'hF50,
                RGB_3 = 12'hD10
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
    input wire [11:0] xpos,
    input wire [11:0] ypos,
    input wire mov,
    input wire [31:0] position,
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
                            ((xpos + 71 <= position && position <= 73 + xpos) || (hcount_in >= xpos - position + 71)) && (hcount_in <= xpos - position + 73) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            ((xpos + 71 <= position && position <= 73 + xpos) || (hcount_in >= xpos - position + 71)) && (hcount_in <= xpos - position + 73) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            ((xpos + 77 <= position && position <= 79 + xpos) || (hcount_in >= xpos - position + 77)) && (hcount_in <= xpos - position + 79) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            ((xpos + 77 <= position && position <= 79 + xpos) || (hcount_in >= xpos - position + 77)) && (hcount_in <= xpos - position + 79) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            ((xpos + 254 <= position && position <= 256 + xpos) || (hcount_in >= xpos - position + 254)) && (hcount_in <= xpos - position + 256) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            ((xpos + 254 <= position && position <= 256 + xpos) || (hcount_in >= xpos - position + 254)) && (hcount_in <= xpos - position + 256) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            ((xpos + 260 <= position && position <= 262 + xpos) || (hcount_in >= xpos - position + 260)) && (hcount_in <= xpos - position + 262) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            ((xpos + 260 <= position && position <= 262 + xpos) || (hcount_in >= xpos - position + 260)) && (hcount_in <= xpos - position + 262) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42)
                        )
                )
                rgb_out_nxt = 12'h777;

                else if((mov == 1) && (
                            ((xpos + 74 <= position && position <= 76 + xpos) || (hcount_in >= xpos - position + 74)) && (hcount_in <= xpos - position + 76) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            ((xpos + 74 <= position && position <= 76 + xpos) || (hcount_in >= xpos - position + 74)) && (hcount_in <= xpos - position + 76) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            ((xpos + 71 <= position && position <= 73 + xpos) || (hcount_in >= xpos - position + 71)) && (hcount_in <= xpos - position + 73) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39) ||
                            ((xpos + 77 <= position && position <= 79 + xpos) || (hcount_in >= xpos - position + 77)) && (hcount_in <= xpos - position + 79) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39) ||
                            ((xpos + 257 <= position && position <= 259 + xpos) || (hcount_in >= xpos - position + 257)) && (hcount_in <= xpos - position + 259) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            ((xpos + 257 <= position && position <= 259 + xpos) || (hcount_in >= xpos - position + 257)) && (hcount_in <= xpos - position + 259) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            ((xpos + 254 <= position && position <= 256 + xpos) || (hcount_in >= xpos - position + 254)) && (hcount_in <= xpos - position + 256) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39) ||
                            ((xpos + 260 <= position && position <= 262 + xpos) || (hcount_in >= xpos - position + 260)) && (hcount_in <= xpos - position + 262) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39)
                        )
                )
                rgb_out_nxt = 12'h777;

                else if(
                            ((xpos + 71 <= position && position <= 79 + xpos) || (hcount_in >= xpos - position + 71)) && (hcount_in <= xpos - position + 79) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) ||
                            ((xpos + 254 <= position && position <= 262 + xpos) || (hcount_in >= xpos - position + 254)) && (hcount_in <= xpos - position + 262) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) 
                )
                rgb_out_nxt = 12'h445;

                else if(
                            ((xpos + 67 <= position && position <= 83 + xpos) || (hcount_in >= xpos - position + 67)) && (hcount_in <= xpos - position + 83) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) || 
                            ((xpos + 68 <= position && position <= 82 + xpos) || (hcount_in >= xpos - position + 68)) && (hcount_in <= xpos - position + 82) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 43) || 
                            ((xpos + 69 <= position && position <= 81 + xpos) || (hcount_in >= xpos - position + 69)) && (hcount_in <= xpos - position + 81) && (vcount_in >= ypos + 32) && (vcount_in <= ypos + 44) ||
                            ((xpos + 70 <= position && position <= 80 + xpos) || (hcount_in >= xpos - position + 70)) && (hcount_in <= xpos - position + 80) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||
                            ((xpos + 71 <= position && position <= 79 + xpos) || (hcount_in >= xpos - position + 71)) && (hcount_in <= xpos - position + 79) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 46) ||
                            ((xpos + 250 <= position && position <= 266 + xpos) || (hcount_in >= xpos - position + 250)) && (hcount_in <= xpos - position + 266) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) || 
                            ((xpos + 251 <= position && position <= 265 + xpos) || (hcount_in >= xpos - position + 251)) && (hcount_in <= xpos - position + 265) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 43) || 
                            ((xpos + 252 <= position && position <= 264 + xpos) || (hcount_in >= xpos - position + 252)) && (hcount_in <= xpos - position + 264) && (vcount_in >= ypos + 32) && (vcount_in <= ypos + 44) ||
                            ((xpos + 253 <= position && position <= 263 + xpos) || (hcount_in >= xpos - position + 253)) && (hcount_in <= xpos - position + 263) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||
                            ((xpos + 254 <= position && position <= 262 + xpos) || (hcount_in >= xpos - position + 254)) && (hcount_in <= xpos - position + 262) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 46) 
                )
                rgb_out_nxt = 12'h000;

                else if(
                            ((xpos + 71 <= position && position <= 79 + xpos) || (hcount_in >= xpos - position + 71)) && (hcount_in <= xpos - position + 79) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 50) || 
                            ((xpos + 63 <= position && position <= 87 + xpos) || (hcount_in >= xpos - position + 63)) && (hcount_in <= xpos - position + 87) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) ||
                            ((xpos + 64 <= position && position <= 86 + xpos) || (hcount_in >= xpos - position + 64)) && (hcount_in <= xpos - position + 86) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 43) ||
                            ((xpos + 65 <= position && position <= 85 + xpos) || (hcount_in >= xpos - position + 65)) && (hcount_in <= xpos - position + 85) && (vcount_in >= ypos + 32) && (vcount_in <= ypos + 44) ||
                            ((xpos + 66 <= position && position <= 84 + xpos) || (hcount_in >= xpos - position + 66)) && (hcount_in <= xpos - position + 84) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||   
                            ((xpos + 67 <= position && position <= 83 + xpos) || (hcount_in >= xpos - position + 67)) && (hcount_in <= xpos - position + 83) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 46) ||
                            ((xpos + 68 <= position && position <= 82 + xpos) || (hcount_in >= xpos - position + 68)) && (hcount_in <= xpos - position + 82) && (vcount_in >= ypos + 29) && (vcount_in <= ypos + 47) ||
                            ((xpos + 69 <= position && position <= 81 + xpos) || (hcount_in >= xpos - position + 69)) && (hcount_in <= xpos - position + 81) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 48) ||
                            ((xpos + 70 <= position && position <= 80 + xpos) || (hcount_in >= xpos - position + 70)) && (hcount_in <= xpos - position + 80) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 49) ||
                            ((xpos + 254 <= position && position <= 262 + xpos) || (hcount_in >= xpos - position + 254)) && (hcount_in <= xpos - position + 262) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 50) || 
                            ((xpos + 246 <= position && position <= 270 + xpos) || (hcount_in >= xpos - position + 246)) && (hcount_in <= xpos - position + 270) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) ||
                            ((xpos + 247 <= position && position <= 269 + xpos) || (hcount_in >= xpos - position + 247)) && (hcount_in <= xpos - position + 269) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 43) ||
                            ((xpos + 248 <= position && position <= 268 + xpos) || (hcount_in >= xpos - position + 248)) && (hcount_in <= xpos - position + 268) && (vcount_in >= ypos + 32) && (vcount_in <= ypos + 44) ||
                            ((xpos + 249 <= position && position <= 267 + xpos) || (hcount_in >= xpos - position + 249)) && (hcount_in <= xpos - position + 267) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||   
                            ((xpos + 250 <= position && position <= 266 + xpos) || (hcount_in >= xpos - position + 250)) && (hcount_in <= xpos - position + 266) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 46) ||
                            ((xpos + 251 <= position && position <= 265 + xpos) || (hcount_in >= xpos - position + 251)) && (hcount_in <= xpos - position + 265) && (vcount_in >= ypos + 29) && (vcount_in <= ypos + 47) ||
                            ((xpos + 252 <= position && position <= 264 + xpos) || (hcount_in >= xpos - position + 252)) && (hcount_in <= xpos - position + 264) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 48) ||
                            ((xpos + 253 <= position && position <= 263 + xpos) || (hcount_in >= xpos - position + 253)) && (hcount_in <= xpos - position + 263) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 49)  
                            
                )
                rgb_out_nxt = 12'h222;

                else if(
                            ((xpos + 68 <= position && position <= 82 + xpos) || (hcount_in >= xpos - position + 68)) && (hcount_in <= xpos - position + 82) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 59) ||
                            ((xpos + 65 <= position && position <= 85 + xpos) || (hcount_in >= xpos - position + 65)) && (hcount_in <= xpos - position + 85) && (vcount_in >= ypos + 18) && (vcount_in <= ypos + 58) ||
                            ((xpos + 54 <= position && position <= 96 + xpos) || (hcount_in >= xpos - position + 54)) && (hcount_in <= xpos - position + 96) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||
                            ((xpos + 55 <= position && position <= 95 + xpos) || (hcount_in >= xpos - position + 55)) && (hcount_in <= xpos - position + 95) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 48) ||
                            ((xpos + 56 <= position && position <= 94 + xpos) || (hcount_in >= xpos - position + 56)) && (hcount_in <= xpos - position + 94) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 49) ||
                            ((xpos + 57 <= position && position <= 93 + xpos) || (hcount_in >= xpos - position + 57)) && (hcount_in <= xpos - position + 93) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 50) ||
                            ((xpos + 58 <= position && position <= 92 + xpos) || (hcount_in >= xpos - position + 58)) && (hcount_in <= xpos - position + 92) && (vcount_in >= ypos + 24) && (vcount_in <= ypos + 52) ||
                            ((xpos + 59 <= position && position <= 91 + xpos) || (hcount_in >= xpos - position + 59)) && (hcount_in <= xpos - position + 91) && (vcount_in >= ypos + 23) && (vcount_in <= ypos + 53) ||
                            ((xpos + 60 <= position && position <= 90 + xpos) || (hcount_in >= xpos - position + 60)) && (hcount_in <= xpos - position + 90) && (vcount_in >= ypos + 22) && (vcount_in <= ypos + 54) ||
                            ((xpos + 61 <= position && position <= 89 + xpos) || (hcount_in >= xpos - position + 61)) && (hcount_in <= xpos - position + 89) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 55) ||
                            ((xpos + 63 <= position && position <= 87 + xpos) || (hcount_in >= xpos - position + 63)) && (hcount_in <= xpos - position + 87) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 56) ||
                            ((xpos + 63 <= position && position <= 87 + xpos) || (hcount_in >= xpos - position + 63)) && (hcount_in <= xpos - position + 87) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 56) ||
                            ((xpos + 64 <= position && position <= 86 + xpos) || (hcount_in >= xpos - position + 64)) && (hcount_in <= xpos - position + 86) && (vcount_in >= ypos + 19) && (vcount_in <= ypos + 57) ||
                            ((xpos + 251 <= position && position <= 265 + xpos) || (hcount_in >= xpos - position + 251)) && (hcount_in <= xpos - position + 265) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 59) ||
                            ((xpos + 248 <= position && position <= 268 + xpos) || (hcount_in >= xpos - position + 248)) && (hcount_in <= xpos - position + 268) && (vcount_in >= ypos + 18) && (vcount_in <= ypos + 58) ||
                            ((xpos + 237 <= position && position <= 279 + xpos) || (hcount_in >= xpos - position + 237)) && (hcount_in <= xpos - position + 279) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||
                            ((xpos + 238 <= position && position <= 278 + xpos) || (hcount_in >= xpos - position + 238)) && (hcount_in <= xpos - position + 278) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 48) ||
                            ((xpos + 239 <= position && position <= 277 + xpos) || (hcount_in >= xpos - position + 239)) && (hcount_in <= xpos - position + 277) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 49) ||
                            ((xpos + 240 <= position && position <= 276 + xpos) || (hcount_in >= xpos - position + 240)) && (hcount_in <= xpos - position + 276) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 50) ||
                            ((xpos + 241 <= position && position <= 275 + xpos) || (hcount_in >= xpos - position + 241)) && (hcount_in <= xpos - position + 275) && (vcount_in >= ypos + 24) && (vcount_in <= ypos + 52) ||
                            ((xpos + 242 <= position && position <= 274 + xpos) || (hcount_in >= xpos - position + 242)) && (hcount_in <= xpos - position + 274) && (vcount_in >= ypos + 23) && (vcount_in <= ypos + 53) ||
                            ((xpos + 243 <= position && position <= 273 + xpos) || (hcount_in >= xpos - position + 243)) && (hcount_in <= xpos - position + 273) && (vcount_in >= ypos + 22) && (vcount_in <= ypos + 54) ||
                            ((xpos + 244<= position && position <= 272 + xpos) || (hcount_in >= xpos - position + 244)) && (hcount_in <= xpos - position + 272) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 55) ||
                            ((xpos + 246 <= position && position <= 270 + xpos) || (hcount_in >= xpos - position + 246)) && (hcount_in <= xpos - position + 270) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 56) ||
                            ((xpos + 246 <= position && position <= 270 + xpos) || (hcount_in >= xpos - position + 246)) && (hcount_in <= xpos - position + 270) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 56) ||
                            ((xpos + 247 <= position && position <= 269 + xpos) || (hcount_in >= xpos - position + 247)) && (hcount_in <= xpos - position + 269) && (vcount_in >= ypos + 19) && (vcount_in <= ypos + 57)
                )
                rgb_out_nxt = 12'h000;

                else if(
                            ((xpos + 142 <= position && position <= 150 + xpos) || (hcount_in >= xpos - position + 142)) && (hcount_in <= xpos - position + 150) && (vcount_in >= ypos) && (vcount_in <= ypos + 2) ||
                            ((xpos + 142 <= position && position <= 144 + xpos) || (hcount_in >= xpos - position + 142)) && (hcount_in <= xpos - position + 144) && (vcount_in == ypos + 3) ||
                            ((xpos + 142 <= position && position <= 143 + xpos) || (hcount_in >= xpos - position + 142)) && (hcount_in <= xpos - position + 143) && (vcount_in >= ypos + 4) && (vcount_in <= ypos + 5) ||
                            (hcount_in == xpos - position + 51) && (vcount_in == ypos + 37) ||
                            ((xpos + 52 <= position && position <= 98 + xpos) || (hcount_in >= xpos - position + 52)) && (hcount_in <= xpos - position + 98) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 37) ||
                            ((xpos + 97<= position && position <= 98 + xpos) || (hcount_in >= xpos - position + 97)) && (hcount_in <= xpos - position + 98) && (vcount_in >= ypos + 38) && (vcount_in <= ypos + 41) ||
                            (hcount_in == xpos - position + 99) && (vcount_in == ypos + 41) ||
                            ((xpos + 53 <= position && position <= 97 + xpos) || (hcount_in >= xpos - position + 53)) && (hcount_in <= xpos - position + 97) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 29) ||
                            ((xpos + 53 <= position && position <= 97 + xpos) || (hcount_in >= xpos - position + 53)) && (hcount_in <= xpos - position + 97) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 29) ||
                            ((xpos + 54 <= position && position <= 96 + xpos) || (hcount_in >= xpos - position + 54)) && (hcount_in <= xpos - position + 96) && (vcount_in == ypos + 25) ||
                            ((xpos + 55 <= position && position <= 95 + xpos) || (hcount_in >= xpos - position + 55)) && (hcount_in <= xpos - position + 95) && (vcount_in == ypos + 24) ||
                            ((xpos + 56 <= position && position <= 94 + xpos) || (hcount_in >= xpos - position + 56)) && (hcount_in <= xpos - position + 94) && (vcount_in >= ypos + 22) && (vcount_in <= ypos + 23) ||
                            ((xpos + 57 <= position && position <= 93 + xpos) || (hcount_in >= xpos - position + 57)) && (hcount_in <= xpos - position + 93) && (vcount_in == ypos + 21) ||
                            ((xpos + 58 <= position && position <= 92 + xpos) || (hcount_in >= xpos - position + 58)) && (hcount_in <= xpos - position + 92) && (vcount_in == ypos + 20) ||
                            ((xpos + 59 <= position && position <= 91 + xpos) || (hcount_in >= xpos - position + 59)) && (hcount_in <= xpos - position + 91) && (vcount_in == ypos + 19) ||
                            ((xpos + 61 <= position && position <= 89 + xpos) || (hcount_in >= xpos - position + 61)) && (hcount_in <= xpos - position + 89) && (vcount_in == ypos + 18) ||
                            ((xpos + 62 <= position && position <= 88 + xpos) || (hcount_in >= xpos - position + 62)) && (hcount_in <= xpos - position + 88) && (vcount_in == ypos + 17) ||
                            ((xpos + 63 <= position && position <= 87 + xpos) || (hcount_in >= xpos - position + 63)) && (hcount_in <= xpos - position + 87) && (vcount_in == ypos + 16) ||
                            ((xpos + 66 <= position && position <= 84 + xpos) || (hcount_in >= xpos - position + 66)) && (hcount_in <= xpos - position + 84) && (vcount_in == ypos + 15) ||
                            (hcount_in == xpos - position + 282) && (vcount_in == ypos + 37) ||
                            ((xpos + 235 <= position && position <= 281 + xpos) || (hcount_in >= xpos - position + 235)) && (hcount_in <= xpos - position + 281) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 37) ||
                            ((xpos + 236 <= position && position <= 280 + xpos) || (hcount_in >= xpos - position + 236)) && (hcount_in <= xpos - position + 280) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 29) ||
                            ((xpos + 236 <= position && position <= 280 + xpos) || (hcount_in >= xpos - position + 236)) && (hcount_in <= xpos - position + 280) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 29) ||
                            ((xpos + 237 <= position && position <= 279 + xpos) || (hcount_in >= xpos - position + 237)) && (hcount_in <= xpos - position + 279) && (vcount_in == ypos + 25) ||
                            ((xpos + 238 <= position && position <= 278 + xpos) || (hcount_in >= xpos - position + 238)) && (hcount_in <= xpos - position + 278) && (vcount_in == ypos + 24) ||
                            ((xpos + 239 <= position && position <= 277 + xpos) || (hcount_in >= xpos - position + 239)) && (hcount_in <= xpos - position + 277) && (vcount_in >= ypos + 22) && (vcount_in <= ypos + 23) ||
                            ((xpos + 240 <= position && position <= 276 + xpos) || (hcount_in >= xpos - position + 240)) && (hcount_in <= xpos - position + 276) && (vcount_in == ypos + 21) ||
                            ((xpos + 241 <= position && position <= 275 + xpos) || (hcount_in >= xpos - position + 241)) && (hcount_in <= xpos - position + 275) && (vcount_in == ypos + 20) ||
                            ((xpos + 242 <= position && position <= 274 + xpos) || (hcount_in >= xpos - position + 242)) && (hcount_in <= xpos - position + 274) && (vcount_in == ypos + 19) ||
                            ((xpos + 244 <= position && position <= 272 + xpos) || (hcount_in >= xpos - position + 244)) && (hcount_in <= xpos - position + 272) && (vcount_in == ypos + 18) ||
                            ((xpos + 245 <= position && position <= 271 + xpos) || (hcount_in >= xpos - position + 245)) && (hcount_in <= xpos - position + 271) && (vcount_in == ypos + 17) ||
                            ((xpos + 246 <= position && position <= 270 + xpos) || (hcount_in >= xpos - position + 246)) && (hcount_in <= xpos - position + 270) && (vcount_in == ypos + 16) ||
                            ((xpos + 249 <= position && position <= 267 + xpos) || (hcount_in >= xpos - position + 249)) && (hcount_in <= xpos - position + 267) && (vcount_in == ypos + 15) ||
                            ((xpos + 235 <= position && position <= 236 + xpos) || (hcount_in >= xpos - position + 235)) && (hcount_in <= xpos - position + 236) && (vcount_in >= ypos + 38) && (vcount_in <= ypos + 41) ||
                            (hcount_in == xpos - position + 234) && (vcount_in == ypos + 41)                       
                )
                rgb_out_nxt = 12'h322;

                else if(
                            ((xpos + 49 <= position && position <= 95 + xpos) || (hcount_in >= xpos - position + 49)) && (hcount_in <= xpos - position + 95) && (vcount_in >= ypos - 4) && (vcount_in <= ypos - 1) ||
                            (hcount_in == xpos - position + 48) && (vcount_in >= ypos - 3) && (vcount_in <= ypos - 2) ||
                            ((xpos + 93 <= position && position <= 98 + xpos) || (hcount_in >= xpos - position + 93)) && (hcount_in <= xpos - position + 98) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            ((xpos + 97 <= position && position <= 99 + xpos) || (hcount_in >= xpos - position + 97)) && (hcount_in <= xpos - position + 99) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8)
                )
                rgb_out_nxt = 12'h666;

                else if(
                            ((xpos + 294 <= position && position <= 295 + xpos) || (hcount_in >= xpos - position + 294)) && (hcount_in <= xpos - position + 295) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 23) ||
                            ((xpos + 24 <= position && position <= 50 + xpos) || (hcount_in >= xpos - position + 24)) && (hcount_in <= xpos - position + 50) && (vcount_in >= ypos + 38) && (vcount_in <= ypos + 40) ||
                            ((xpos + 100 <= position && position <= 233 + xpos) || (hcount_in >= xpos - position + 100)) && (hcount_in <= xpos - position + 233) && (vcount_in >= ypos + 42) && (vcount_in <= ypos + 43) ||
                            ((xpos + 135 <= position && position <= 137 + xpos) || (hcount_in >= xpos - position + 135)) && (hcount_in <= xpos - position + 137) && (vcount_in >= ypos - 10) && (vcount_in <= ypos + 41) ||
                            ((xpos + 135 <= position && position <= 137 + xpos) || (hcount_in >= xpos - position + 135)) && (hcount_in <= xpos - position + 137) && (vcount_in >= ypos - 10) && (vcount_in <= ypos + 41) || 
                            ((xpos + 138 <= position && position <= 181 + xpos) || (hcount_in >= xpos - position + 138)) && (hcount_in <= xpos - position + 181) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            ((xpos + 180 <= position && position <= 216 + xpos) || (hcount_in >= xpos - position + 180)) && (hcount_in <= xpos - position + 216) && (vcount_in >= ypos - 3) && (vcount_in <= ypos - 2) ||
                            ((xpos + 214 <= position && position <= 216 + xpos) || (hcount_in >= xpos - position + 214)) && (hcount_in <= xpos - position + 216) && (vcount_in >= ypos - 1) && (vcount_in <= ypos + 41) ||
                            ((xpos + 283 <= position && position <= 316 + xpos) || (hcount_in >= xpos - position + 283)) && (hcount_in <= xpos - position + 316) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39) ||
                            ((xpos + 301 <= position && position <= 317 + xpos) || (hcount_in >= xpos - position + 301)) && (hcount_in <= xpos - position + 317) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            ((xpos + 307 <= position && position <= 320 + xpos) || (hcount_in >= xpos - position + 307)) && (hcount_in <= xpos - position + 320) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 35) ||
                            ((xpos + 318 <= position && position <= 319 + xpos) || (hcount_in >= xpos - position + 318)) && (hcount_in <= xpos - position + 319) && (vcount_in >= ypos + 7) && (vcount_in <= ypos + 19) || 
                            (hcount_in == xpos - position + 320) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 19) ||
                            ((xpos + 321 <= position && position <= 323 + xpos) || (hcount_in >= xpos - position + 321)) && (hcount_in <= xpos - position + 323) && (vcount_in >= ypos + 18) && (vcount_in <= ypos + 33) || 
                            ((xpos + 100 <= position && position <= 134 + xpos) || (hcount_in >= xpos - position + 100)) && (hcount_in <= xpos - position + 134) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            ((xpos + 100 <= position && position <= 134 + xpos) || (hcount_in >= xpos - position + 100)) && (hcount_in <= xpos - position + 134) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||  
                            ((xpos + 104 <= position && position <= 112 + xpos) || (hcount_in >= xpos - position + 104)) && (hcount_in <= xpos - position + 112) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            ((xpos + 104 <= position && position <= 112 + xpos) || (hcount_in >= xpos - position + 104)) && (hcount_in <= xpos - position + 112) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            ((xpos + 111 <= position && position <= 119 + xpos) || (hcount_in >= xpos - position + 111)) && (hcount_in <= xpos - position + 119) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            ((xpos + 118 <= position && position <= 119 + xpos) || (hcount_in >= xpos - position + 118)) && (hcount_in <= xpos - position + 119) && (vcount_in == ypos - 18) ||
                            ((xpos + 118 <= position && position <= 126 + xpos) || (hcount_in >= xpos - position + 118)) && (hcount_in <= xpos - position + 126) && (vcount_in >= ypos - 20) && (vcount_in <= ypos - 19) ||
                            ((xpos + 118 <= position && position <= 126 + xpos) || (hcount_in >= xpos - position + 118)) && (hcount_in <= xpos - position + 126) && (vcount_in >= ypos - 20) && (vcount_in <= ypos - 19) ||
                            ((xpos + 124 <= position && position <= 126 + xpos) || (hcount_in >= xpos - position + 124)) && (hcount_in <= xpos - position + 126) && (vcount_in >= ypos - 24) && (vcount_in <= ypos - 21) || 
                            ((xpos + 127 <= position && position <= 185 + xpos) || (hcount_in >= xpos - position + 127)) && (hcount_in <= xpos - position + 185) && (vcount_in >= ypos - 24) && (vcount_in <= ypos - 22) ||
                            ((xpos + 180 <= position && position <= 185 + xpos) || (hcount_in >= xpos - position + 180)) && (hcount_in <= xpos - position + 185) && (vcount_in >= ypos - 21) && (vcount_in <= ypos - 19) ||
                            ((xpos + 180 <= position && position <= 181 + xpos) || (hcount_in >= xpos - position + 180)) && (hcount_in <= xpos - position + 181) && (vcount_in >= ypos - 18) && (vcount_in <= ypos - 8) ||
                            (hcount_in == xpos - position + 182) && (vcount_in == ypos - 18) ||
                            ((xpos + 180 <= position && position <= 181 + xpos) || (hcount_in >= xpos - position + 180)) && (hcount_in <= xpos - position + 181) && (vcount_in >= ypos - 18) && (vcount_in <= ypos - 8) ||
                            ((xpos + 193 <= position && position <= 199 + xpos) || (hcount_in >= xpos - position + 193)) && (hcount_in <= xpos - position + 199) && (vcount_in == ypos - 4)||
                            ((xpos + 194 <= position && position <= 199 + xpos) || (hcount_in >= xpos - position + 194)) && (hcount_in <= xpos - position + 199) && (vcount_in >= ypos - 6) && (vcount_in <= ypos - 5) ||
                            ((xpos + 180 <= position && position <= 182 + xpos) || (hcount_in >= xpos - position + 180)) && (hcount_in <= xpos - position + 182) && (vcount_in == ypos - 4) ||
                            ((xpos + 210 <= position && position <= 216 + xpos) || (hcount_in >= xpos - position + 210)) && (hcount_in <= xpos - position + 216) && (vcount_in == ypos - 4) ||
                            ((xpos + 211 <= position && position <= 216 + xpos) || (hcount_in >= xpos - position + 211)) && (hcount_in <= xpos - position + 216) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            ((xpos + 214 <= position && position <= 216 + xpos) || (hcount_in >= xpos - position + 214)) && (hcount_in <= xpos - position + 216) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            ((xpos + 194 <= position && position <= 198 + xpos) || (hcount_in >= xpos - position + 194)) && (hcount_in <= xpos - position + 198) && (vcount_in == ypos - 7) ||
                            (hcount_in == xpos - position + 213) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            ((xpos + 193 <= position && position <= 196 + xpos) || (hcount_in >= xpos - position + 193)) && (hcount_in <= xpos - position + 196) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            ((xpos + 193 <= position && position <= 196 + xpos) || (hcount_in >= xpos - position + 193)) && (hcount_in <= xpos - position + 196) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            ((xpos + 190 <= position && position <= 195 + xpos) || (hcount_in >= xpos - position + 190)) && (hcount_in <= xpos - position + 195) && (vcount_in >= ypos - 11) && (vcount_in <= ypos - 9) ||
                            ((xpos + 186 <= position && position <= 189 + xpos) || (hcount_in >= xpos - position + 186)) && (hcount_in <= xpos - position + 189) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            ((xpos + 189 <= position && position <= 192 + xpos) || (hcount_in >= xpos - position + 189)) && (hcount_in <= xpos - position + 192) && (vcount_in >= ypos - 13) && (vcount_in <= ypos - 12) ||
                            ((xpos + 189 <= position && position <= 191 + xpos) || (hcount_in >= xpos - position + 189)) && (hcount_in <= xpos - position + 191) && (vcount_in == ypos - 14) ||
                            ((xpos + 186 <= position && position <= 188 + xpos) || (hcount_in >= xpos - position + 186)) && (hcount_in <= xpos - position + 188) && (vcount_in == ypos - 18)
                )
                rgb_out_nxt = 12'h000;

                else if(
                            (hcount_in == xpos - position + 296) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 23)   
                )
                rgb_out_nxt = 12'h650; 

                else if(
                            ((xpos + 297 <= position && position <= 302 + xpos) || (hcount_in >= xpos - position + 297)) && (hcount_in <= xpos - position + 302) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 23)   
                )
                rgb_out_nxt = 12'hfd1; 

                else if(
                            ((xpos - 1 <= position && position <= 2 + xpos) || (hcount_in >= xpos - position - 1)) && (hcount_in <= xpos - position + 2) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 23) ||
                            ((xpos - 4 <= position && position <= xpos - 2) || (hcount_in >= xpos - position - 4)) && (hcount_in <= xpos - position - 2) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 20) ||
                            ((xpos + 310 <= position && position <= 317 + xpos) || (hcount_in >= xpos - position + 310)) && (hcount_in <= xpos - position + 317) && (vcount_in >= ypos + 24) && (vcount_in <= ypos + 27) || 
                            ((xpos + 314 <= position && position <= 317 + xpos) || (hcount_in >= xpos - position + 314)) && (hcount_in <= xpos - position + 317) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 30)    
                )
                rgb_out_nxt = 12'hbcc; 

                else if(
                            ((xpos - 4 <= position && position <= 2 + xpos) || (hcount_in >= xpos - position - 4)) && (hcount_in <= xpos - position + 2) && (vcount_in >= ypos + 14) && (vcount_in <= ypos + 16) ||
                            ((xpos + 3 <= position && position <= 5 + xpos) || (hcount_in >= xpos - position + 3)) && (hcount_in <= xpos - position + 5) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 26) ||
                            ((xpos - 4 <= position && position <= 2 + xpos) || (hcount_in >= xpos - position - 4)) && (hcount_in <= xpos - position + 2) && (vcount_in >= ypos + 24) && (vcount_in <= ypos + 26) ||
                            ((xpos - 4 <= position && position <= xpos - 1) || (hcount_in >= xpos - position - 4)) && (hcount_in <= xpos - position - 1) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 23) || 
                            ((xpos + 307 <= position && position <= 320 + xpos) || (hcount_in >= xpos - position + 307)) && (hcount_in <= xpos - position + 320) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 33)    
                )
                rgb_out_nxt = 12'h455;

                else if(
                            ((xpos + 113 <= position && position <= 209 + xpos) || (hcount_in >= xpos - position + 113)) && (hcount_in <= xpos - position + 209) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            ((xpos + 138 <= position && position <= 212 + xpos) || (hcount_in >= xpos - position + 138)) && (hcount_in <= xpos - position + 212) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            ((xpos + 182 <= position && position <= 210 + xpos) || (hcount_in >= xpos - position + 182)) && (hcount_in <= xpos - position + 210) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            ((xpos + 183 <= position && position <= 209 + xpos) || (hcount_in >= xpos - position + 183)) && (hcount_in <= xpos - position + 209) && (vcount_in == ypos - 4) ||
                            ((xpos + 120 <= position && position <= 206 + xpos) || (hcount_in >= xpos - position + 120)) && (hcount_in <= xpos - position + 206) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            ((xpos + 120 <= position && position <= 203 + xpos) || (hcount_in >= xpos - position + 120)) && (hcount_in <= xpos - position + 203) && (vcount_in == ypos - 18) ||
                            ((xpos + 127 <= position && position <= 202 + xpos) || (hcount_in >= xpos - position + 127)) && (hcount_in <= xpos - position + 202) && (vcount_in >= ypos - 21) && (vcount_in <= ypos - 19) ||
                            ((xpos + 127 <= position && position <= 202 + xpos) || (hcount_in >= xpos - position + 127)) && (hcount_in <= xpos - position + 202) && (vcount_in >= ypos - 21) && (vcount_in <= ypos - 19) ||
                            ((xpos + 186 <= position && position <= 199 + xpos) || (hcount_in >= xpos - position + 186)) && (hcount_in <= xpos - position + 199) && (vcount_in >= ypos - 24) && (vcount_in <= ypos - 22) ||
                            (hcount_in == xpos - position + 210) && (vcount_in == ypos - 11)         
                )
                rgb_out_nxt = 12'hddc;   

                else if(
                            ((xpos + 23 <= position && position <= 306 + xpos) || (hcount_in >= xpos - position + 23)) && (hcount_in <= xpos - position + 306) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 37) ||
                            ((xpos + 99<= position && position <= 234 + xpos) || (hcount_in >= xpos - position + 99)) && (hcount_in <= xpos - position + 234) && (vcount_in >= ypos + 38) && (vcount_in <= ypos + 41) ||
                            ((xpos + 4 <= position && position <= 19 + xpos) || (hcount_in >= xpos - position + 4)) && (hcount_in <= xpos - position + 19) && (vcount_in >= ypos + 25) && (vcount_in <= ypos + 31) ||
                            (hcount_in == xpos - position + 3) && (hcount_in == xpos - position + 27) ||
                            ((xpos + 13 <= position && position <= 22 + xpos) || (hcount_in >= xpos - position + 13)) && (hcount_in <= xpos - position + 22) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 34)
                )
                rgb_out_nxt = RGB_3;    

                else if(    
                            ((xpos <= position && position <= 5 + xpos) || (hcount_in >= xpos - position)) && (hcount_in <= xpos - position + 5) && (vcount_in >= ypos) && (vcount_in <= ypos + 2) ||
                            ((xpos + 3 <= position && position <= 47 + xpos) || (hcount_in >= xpos - position + 3)) && (hcount_in <= xpos - position + 47) && (vcount_in >= ypos - 3) && (vcount_in <= ypos - 1) ||
                            ((xpos + 28 <= position && position <= 47 + xpos) || (hcount_in >= xpos - position + 28)) && (hcount_in <= xpos - position + 47) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 4) ||
                            ((xpos + 48 <= position && position <= 57 + xpos) || (hcount_in >= xpos - position + 48)) && (hcount_in <= xpos - position + 57) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) || 
                            ((xpos + 58 <= position && position <= 68 + xpos) || (hcount_in >= xpos - position + 58)) && (hcount_in <= xpos - position + 68) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            ((xpos + 69 <= position && position <= 75 + xpos) || (hcount_in >= xpos - position + 69)) && (hcount_in <= xpos - position + 75) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            ((xpos + 76 <= position && position <= 85 + xpos) || (hcount_in >= xpos - position + 76)) && (hcount_in <= xpos - position + 85) && (vcount_in >= ypos - 20) && (vcount_in <= ypos - 18) ||
                            ((xpos + 86 <= position && position <= 96 + xpos) || (hcount_in >= xpos - position + 86)) && (hcount_in <= xpos - position + 96) && (vcount_in >= ypos - 24) && (vcount_in <= ypos - 21) ||
                            ((xpos + 97 <= position && position <= 103 + xpos) || (hcount_in >= xpos - position + 97)) && (hcount_in <= xpos - position + 103) && (vcount_in >= ypos - 27) && (vcount_in <= ypos - 25) ||
                            ((xpos + 104 <= position && position <= 188 + xpos) || (hcount_in >= xpos - position + 104)) && (hcount_in <= xpos - position + 188) && (vcount_in >= ypos - 31) && (vcount_in <= ypos - 28) ||
                            ((xpos + 189 <= position && position <= 198 + xpos) || (hcount_in >= xpos - position + 189)) && (hcount_in <= xpos - position + 198) && (vcount_in >= ypos - 28) && (vcount_in <= ypos - 26) ||
                            ((xpos + 198 <= position && position <= 199 + xpos) || (hcount_in >= xpos - position + 198)) && (hcount_in <= xpos - position + 199) && (vcount_in == ypos - 25) ||
                            ((xpos + 217 <= position && position <= 261 + xpos) || (hcount_in >= xpos - position + 217)) && (hcount_in <= xpos - position + 261) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 5) ||
                            ((xpos + 262 <= position && position <= 282 + xpos) || (hcount_in >= xpos - position + 262)) && (hcount_in <= xpos - position + 282) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            ((xpos + 283 <= position && position <= 299 + xpos) || (hcount_in >= xpos - position + 283)) && (hcount_in <= xpos - position + 299) && (vcount_in >= ypos - 3) && (vcount_in <= ypos - 2) ||
                            ((xpos + 297 <= position && position <= 299 + xpos) || (hcount_in >= xpos - position + 297)) && (hcount_in <= xpos - position + 299) && (vcount_in >= ypos - 1) && (vcount_in <= ypos + 2) ||
                            ((xpos + 300 <= position && position <= 309 + xpos) || (hcount_in >= xpos - position + 300)) && (hcount_in <= xpos - position + 309) && (vcount_in >= ypos) && (vcount_in <= ypos + 2) || 
                            ((xpos + 307 <= position && position <= 309 + xpos) || (hcount_in >= xpos - position + 307)) && (hcount_in <= xpos - position + 309) && (vcount_in >= ypos + 3)  && (vcount_in <= ypos + 5) ||
                            ((xpos + 310 <= position && position <= 313 + xpos) || (hcount_in >= xpos - position + 310)) && (hcount_in <= xpos - position + 313) && (vcount_in >= ypos + 4)  && (vcount_in <= ypos + 6) ||
                            ((xpos + 311 <= position && position <= 317 + xpos) || (hcount_in >= xpos - position + 311)) && (hcount_in <= xpos - position + 317) && (vcount_in >= ypos + 7)  && (vcount_in <= ypos + 9) ||
                            ((xpos <= position && position <= 2 + xpos) || (hcount_in >= xpos - position)) && (hcount_in <= xpos - position + 2) && (vcount_in >= ypos + 3)  && (vcount_in <= ypos + 13) ||
                            ((xpos + 3 <= position && position <= 317 + xpos) || (hcount_in >= xpos - position + 3)) && (hcount_in <= xpos - position + 317) && (vcount_in >= ypos + 10)  && (vcount_in <= ypos + 26)       
                )
                rgb_out_nxt = RGB_2;

                else if(
                            ((xpos + 3 <= position && position <= 282 + xpos) || (hcount_in >= xpos - position + 3)) && (hcount_in <= xpos - position + 282) && (vcount_in >= ypos - 3) && (vcount_in <= ypos + 9) ||
                            ((xpos + 48 <= position && position <= 282 + xpos) || (hcount_in >= xpos - position + 48)) && (hcount_in <= xpos - position + 282) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 4) ||
                            ((xpos + 283 <= position && position <= 296 + xpos) || (hcount_in >= xpos - position + 283)) && (hcount_in <= xpos - position + 296) && (vcount_in >= ypos - 1) && (vcount_in <= ypos + 9) ||
                            ((xpos + 297 <= position && position <= 309 + xpos) || (hcount_in >= xpos - position + 297)) && (hcount_in <= xpos - position + 309) && (vcount_in >= ypos + 3) && (vcount_in <= ypos + 9) ||
                            ((xpos + 310 <= position && position <= 310 + xpos) || (hcount_in >= xpos - position + 310)) && (hcount_in <= xpos - position + 310) && (vcount_in >= ypos + 7) && (vcount_in <= ypos + 9) ||
                            ((xpos + 58 <= position && position <= 96 + xpos) || (hcount_in >= xpos - position + 58)) && (hcount_in <= xpos - position + 96) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            ((xpos + 69 <= position && position <= 103 + xpos) || (hcount_in >= xpos - position + 69)) && (hcount_in <= xpos - position + 103) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            ((xpos + 76 <= position && position <= 110 + xpos) || (hcount_in >= xpos - position + 76)) && (hcount_in <= xpos - position + 110) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            ((xpos + 86 <= position && position <= 117 + xpos) || (hcount_in >= xpos - position + 86)) && (hcount_in <= xpos - position + 117) && (vcount_in >= ypos - 20) && (vcount_in <= ypos - 17) ||
                            ((xpos + 97 <= position && position <= 197 + xpos) || (hcount_in >= xpos - position + 97)) && (hcount_in <= xpos - position + 197) && (vcount_in >= ypos - 27) && (vcount_in <= ypos - 20)
                )
                rgb_out_nxt = RGB_1;
                //---------------------------------------------------------------------------------
                else rgb_out_nxt = rgb_in;
            end
        end
endmodule