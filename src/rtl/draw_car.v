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
                            (hcount_in >= xpos + 71) && (hcount_in <= xpos + 73) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            (hcount_in >= xpos + 71) && (hcount_in <= xpos + 73) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            (hcount_in >= xpos + 77) && (hcount_in <= xpos + 79) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            (hcount_in >= xpos + 77) && (hcount_in <= xpos + 79) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            (hcount_in >= xpos + 254) && (hcount_in <= xpos + 256) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            (hcount_in >= xpos + 254) && (hcount_in <= xpos + 256) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            (hcount_in >= xpos + 260) && (hcount_in <= xpos + 262) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            (hcount_in >= xpos + 260) && (hcount_in <= xpos + 262) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42)
                        )
                )
                rgb_out_nxt = 12'h777;

                else if((mov == 1) && (
                            (hcount_in >= xpos + 74) && (hcount_in <= xpos + 76) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            (hcount_in >= xpos + 74) && (hcount_in <= xpos + 76) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            (hcount_in >= xpos + 71) && (hcount_in <= xpos + 73) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39) ||
                            (hcount_in >= xpos + 77) && (hcount_in <= xpos + 79) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39) ||
                            (hcount_in >= xpos + 257) && (hcount_in <= xpos + 259) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            (hcount_in >= xpos + 257) && (hcount_in <= xpos + 259) && (vcount_in >= ypos + 40) && (vcount_in <= ypos + 42) ||
                            (hcount_in >= xpos + 254) && (hcount_in <= xpos + 256) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39) ||
                            (hcount_in >= xpos + 260) && (hcount_in <= xpos + 262) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39)
                        )
                )
                rgb_out_nxt = 12'h777;

                else if(
                            (hcount_in >= xpos + 71) && (hcount_in <= xpos + 79) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) ||
                            (hcount_in >= xpos + 254) && (hcount_in <= xpos + 262) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) 
                )
                rgb_out_nxt = 12'h445;

                else if(
                            (hcount_in >= xpos + 67) && (hcount_in <= xpos + 83) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) || 
                            (hcount_in >= xpos + 68) && (hcount_in <= xpos + 82) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 43) || 
                            (hcount_in >= xpos + 69) && (hcount_in <= xpos + 81) && (vcount_in >= ypos + 32) && (vcount_in <= ypos + 44) ||
                            (hcount_in >= xpos + 70) && (hcount_in <= xpos + 80) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||
                            (hcount_in >= xpos + 71) && (hcount_in <= xpos + 79) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 46) ||
                            (hcount_in >= xpos + 250) && (hcount_in <= xpos + 266) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) || 
                            (hcount_in >= xpos + 251) && (hcount_in <= xpos + 265) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 43) || 
                            (hcount_in >= xpos + 252) && (hcount_in <= xpos + 264) && (vcount_in >= ypos + 32) && (vcount_in <= ypos + 44) ||
                            (hcount_in >= xpos + 253) && (hcount_in <= xpos + 263) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||
                            (hcount_in >= xpos + 254) && (hcount_in <= xpos + 262) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 46) 
                )
                rgb_out_nxt = 12'h000;

                else if(
                            (hcount_in >= xpos + 71) && (hcount_in <= xpos + 79) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 50) || 
                            (hcount_in >= xpos + 63) && (hcount_in <= xpos + 87) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) ||
                            (hcount_in >= xpos + 64) && (hcount_in <= xpos + 86) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 43) ||
                            (hcount_in >= xpos + 65) && (hcount_in <= xpos + 85) && (vcount_in >= ypos + 32) && (vcount_in <= ypos + 44) ||
                            (hcount_in >= xpos + 66) && (hcount_in <= xpos + 84) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||   
                            (hcount_in >= xpos + 67) && (hcount_in <= xpos + 83) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 46) ||
                            (hcount_in >= xpos + 68) && (hcount_in <= xpos + 82) && (vcount_in >= ypos + 29) && (vcount_in <= ypos + 47) ||
                            (hcount_in >= xpos + 69) && (hcount_in <= xpos + 81) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 48) ||
                            (hcount_in >= xpos + 70) && (hcount_in <= xpos + 80) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 49) ||
                            (hcount_in >= xpos + 254) && (hcount_in <= xpos + 262) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 50) || 
                            (hcount_in >= xpos + 246) && (hcount_in <= xpos + 270) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 42) ||
                            (hcount_in >= xpos + 247) && (hcount_in <= xpos + 269) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 43) ||
                            (hcount_in >= xpos + 248) && (hcount_in <= xpos + 268) && (vcount_in >= ypos + 32) && (vcount_in <= ypos + 44) ||
                            (hcount_in >= xpos + 249) && (hcount_in <= xpos + 267) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||   
                            (hcount_in >= xpos + 250) && (hcount_in <= xpos + 266) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 46) ||
                            (hcount_in >= xpos + 251) && (hcount_in <= xpos + 265) && (vcount_in >= ypos + 29) && (vcount_in <= ypos + 47) ||
                            (hcount_in >= xpos + 252) && (hcount_in <= xpos + 264) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 48) ||
                            (hcount_in >= xpos + 253) && (hcount_in <= xpos + 263) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 49)  
                            
                )
                rgb_out_nxt = 12'h222;

                else if(
                            (hcount_in >= xpos + 68) && (hcount_in <= xpos + 82) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 59) ||
                            (hcount_in >= xpos + 65) && (hcount_in <= xpos + 85) && (vcount_in >= ypos + 18) && (vcount_in <= ypos + 58) ||
                            (hcount_in >= xpos + 54) && (hcount_in <= xpos + 96) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||
                            (hcount_in >= xpos + 55) && (hcount_in <= xpos + 95) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 48) ||
                            (hcount_in >= xpos + 56) && (hcount_in <= xpos + 94) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 49) ||
                            (hcount_in >= xpos + 57) && (hcount_in <= xpos + 93) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 50) ||
                            (hcount_in >= xpos + 58) && (hcount_in <= xpos + 92) && (vcount_in >= ypos + 24) && (vcount_in <= ypos + 52) ||
                            (hcount_in >= xpos + 59) && (hcount_in <= xpos + 91) && (vcount_in >= ypos + 23) && (vcount_in <= ypos + 53) ||
                            (hcount_in >= xpos + 60) && (hcount_in <= xpos + 90) && (vcount_in >= ypos + 22) && (vcount_in <= ypos + 54) ||
                            (hcount_in >= xpos + 61) && (hcount_in <= xpos + 89) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 55) ||
                            (hcount_in >= xpos + 63) && (hcount_in <= xpos + 87) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 56) ||
                            (hcount_in >= xpos + 63) && (hcount_in <= xpos + 87) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 56) ||
                            (hcount_in >= xpos + 64) && (hcount_in <= xpos + 86) && (vcount_in >= ypos + 19) && (vcount_in <= ypos + 57) ||
                            (hcount_in >= xpos + 251) && (hcount_in <= xpos + 265) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 59) ||
                            (hcount_in >= xpos + 248) && (hcount_in <= xpos + 268) && (vcount_in >= ypos + 18) && (vcount_in <= ypos + 58) ||
                            (hcount_in >= xpos + 237) && (hcount_in <= xpos + 279) && (vcount_in >= ypos + 31) && (vcount_in <= ypos + 45) ||
                            (hcount_in >= xpos + 238) && (hcount_in <= xpos + 278) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 48) ||
                            (hcount_in >= xpos + 239) && (hcount_in <= xpos + 277) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 49) ||
                            (hcount_in >= xpos + 240) && (hcount_in <= xpos + 276) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 50) ||
                            (hcount_in >= xpos + 241) && (hcount_in <= xpos + 275) && (vcount_in >= ypos + 24) && (vcount_in <= ypos + 52) ||
                            (hcount_in >= xpos + 242) && (hcount_in <= xpos + 274) && (vcount_in >= ypos + 23) && (vcount_in <= ypos + 53) ||
                            (hcount_in >= xpos + 243) && (hcount_in <= xpos + 273) && (vcount_in >= ypos + 22) && (vcount_in <= ypos + 54) ||
                            (hcount_in >= xpos + 244) && (hcount_in <= xpos + 272) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 55) ||
                            (hcount_in >= xpos + 246) && (hcount_in <= xpos + 270) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 56) ||
                            (hcount_in >= xpos + 246) && (hcount_in <= xpos + 270) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 56) ||
                            (hcount_in >= xpos + 247) && (hcount_in <= xpos + 269) && (vcount_in >= ypos + 19) && (vcount_in <= ypos + 57)
                )
                rgb_out_nxt = 12'h000;

                else if(
                            (hcount_in >= xpos + 142) && (hcount_in <= xpos + 150) && (vcount_in >= ypos) && (vcount_in <= ypos + 2) ||
                            (hcount_in >= xpos + 142) && (hcount_in <= xpos + 144) && (vcount_in == ypos + 3) ||
                            (hcount_in >= xpos + 142) && (hcount_in <= xpos + 143) && (vcount_in >= ypos + 4) && (vcount_in <= ypos + 5) ||
                            (hcount_in == xpos + 51) && (vcount_in == ypos + 37) ||
                            (hcount_in >= xpos + 52) && (hcount_in <= xpos + 98) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 37) ||
                            (hcount_in >= xpos + 97) && (hcount_in <= xpos + 98) && (vcount_in >= ypos + 38) && (vcount_in <= ypos + 41) ||
                            (hcount_in == xpos + 99) && (vcount_in == ypos + 41) ||
                            (hcount_in >= xpos + 53) && (hcount_in <= xpos + 97) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 29) ||
                            (hcount_in >= xpos + 53) && (hcount_in <= xpos + 97) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 29) ||
                            (hcount_in >= xpos + 54) && (hcount_in <= xpos + 96) && (vcount_in == ypos + 25) ||
                            (hcount_in >= xpos + 55) && (hcount_in <= xpos + 95) && (vcount_in == ypos + 24) ||
                            (hcount_in >= xpos + 56) && (hcount_in <= xpos + 94) && (vcount_in >= ypos + 22) && (vcount_in <= ypos + 23) ||
                            (hcount_in >= xpos + 57) && (hcount_in <= xpos + 93) && (vcount_in == ypos + 21) ||
                            (hcount_in >= xpos + 58) && (hcount_in <= xpos + 92) && (vcount_in == ypos + 20) ||
                            (hcount_in >= xpos + 59) && (hcount_in <= xpos + 91) && (vcount_in == ypos + 19) ||
                            (hcount_in >= xpos + 61) && (hcount_in <= xpos + 89) && (vcount_in == ypos + 18) ||
                            (hcount_in >= xpos + 62) && (hcount_in <= xpos + 88) && (vcount_in == ypos + 17) ||
                            (hcount_in >= xpos + 63) && (hcount_in <= xpos + 87) && (vcount_in == ypos + 16) ||
                            (hcount_in >= xpos + 66) && (hcount_in <= xpos + 84) && (vcount_in == ypos + 15) ||
                            (hcount_in == xpos + 282) && (vcount_in == ypos + 37) ||
                            (hcount_in >= xpos + 235) && (hcount_in <= xpos + 281) && (vcount_in >= ypos + 30) && (vcount_in <= ypos + 37) ||
                            (hcount_in >= xpos + 236) && (hcount_in <= xpos + 280) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 29) ||
                            (hcount_in >= xpos + 236) && (hcount_in <= xpos + 280) && (vcount_in >= ypos + 26) && (vcount_in <= ypos + 29) ||
                            (hcount_in >= xpos + 237) && (hcount_in <= xpos + 279) && (vcount_in == ypos + 25) ||
                            (hcount_in >= xpos + 238) && (hcount_in <= xpos + 278) && (vcount_in == ypos + 24) ||
                            (hcount_in >= xpos + 239) && (hcount_in <= xpos + 277) && (vcount_in >= ypos + 22) && (vcount_in <= ypos + 23) ||
                            (hcount_in >= xpos + 240) && (hcount_in <= xpos + 276) && (vcount_in == ypos + 21) ||
                            (hcount_in >= xpos + 241) && (hcount_in <= xpos + 275) && (vcount_in == ypos + 20) ||
                            (hcount_in >= xpos + 242) && (hcount_in <= xpos + 274) && (vcount_in == ypos + 19) ||
                            (hcount_in >= xpos + 244) && (hcount_in <= xpos + 272) && (vcount_in == ypos + 18) ||
                            (hcount_in >= xpos + 245) && (hcount_in <= xpos + 271) && (vcount_in == ypos + 17) ||
                            (hcount_in >= xpos + 246) && (hcount_in <= xpos + 270) && (vcount_in == ypos + 16) ||
                            (hcount_in >= xpos + 249) && (hcount_in <= xpos + 267) && (vcount_in == ypos + 15) ||
                            (hcount_in >= xpos + 235) && (hcount_in <= xpos + 236) && (vcount_in >= ypos + 38) && (vcount_in <= ypos + 41) ||
                            (hcount_in == xpos + 234) && (vcount_in == ypos + 41)                       
                )
                rgb_out_nxt = 12'h322;

                else if(
                            (hcount_in >= xpos + 49) && (hcount_in <= xpos + 95) && (vcount_in >= ypos - 4) && (vcount_in <= ypos - 1) ||
                            (hcount_in == xpos + 48) && (vcount_in >= ypos - 3) && (vcount_in <= ypos - 2) ||
                            (hcount_in >= xpos + 93) && (hcount_in <= xpos + 98) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            (hcount_in >= xpos + 97) && (hcount_in <= xpos + 99) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8)
                )
                rgb_out_nxt = 12'h666;

                else if(
                            (hcount_in >= xpos + 294) && (hcount_in <= xpos + 295) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 23) ||
                            (hcount_in >= xpos + 24) && (hcount_in <= xpos + 50) && (vcount_in >= ypos + 38) && (vcount_in <= ypos + 40) ||
                            (hcount_in >= xpos + 100) && (hcount_in <= xpos + 233) && (vcount_in >= ypos + 42) && (vcount_in <= ypos + 43) ||
                            (hcount_in >= xpos + 135) && (hcount_in <= xpos + 137) && (vcount_in >= ypos - 10) && (vcount_in <= ypos + 41) ||
                            (hcount_in >= xpos + 135) && (hcount_in <= xpos + 137) && (vcount_in >= ypos - 10) && (vcount_in <= ypos + 41) || 
                            (hcount_in >= xpos + 138) && (hcount_in <= xpos + 181) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            (hcount_in >= xpos + 180) && (hcount_in <= xpos + 216) && (vcount_in >= ypos - 3) && (vcount_in <= ypos - 2) ||
                            (hcount_in >= xpos + 214) && (hcount_in <= xpos + 216) && (vcount_in >= ypos - 1) && (vcount_in <= ypos + 41) ||
                            (hcount_in >= xpos + 283) && (hcount_in <= xpos + 316) && (vcount_in >= ypos + 37) && (vcount_in <= ypos + 39) ||
                            (hcount_in >= xpos + 301) && (hcount_in <= xpos + 317) && (vcount_in >= ypos + 34) && (vcount_in <= ypos + 36) ||
                            (hcount_in >= xpos + 307) && (hcount_in <= xpos + 320) && (vcount_in >= ypos + 33) && (vcount_in <= ypos + 35) ||
                            (hcount_in >= xpos + 318) && (hcount_in <= xpos + 319) && (vcount_in >= ypos + 7) && (vcount_in <= ypos + 19) || 
                            (hcount_in == xpos + 320) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 19) ||
                            (hcount_in >= xpos + 321) && (hcount_in <= xpos + 323) && (vcount_in >= ypos + 18) && (vcount_in <= ypos + 33) || 
                            (hcount_in >= xpos + 100) && (hcount_in <= xpos + 134) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            (hcount_in >= xpos + 100) && (hcount_in <= xpos + 134) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||  
                            (hcount_in >= xpos + 104) && (hcount_in <= xpos + 112) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            (hcount_in >= xpos + 104) && (hcount_in <= xpos + 112) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            (hcount_in >= xpos + 111) && (hcount_in <= xpos + 119) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            (hcount_in >= xpos + 118) && (hcount_in <= xpos + 119) && (vcount_in == ypos - 18) ||
                            (hcount_in >= xpos + 118) && (hcount_in <= xpos + 126) && (vcount_in >= ypos - 20) && (vcount_in <= ypos - 19) ||
                            (hcount_in >= xpos + 118) && (hcount_in <= xpos + 126) && (vcount_in >= ypos - 20) && (vcount_in <= ypos - 19) ||
                            (hcount_in >= xpos + 124) && (hcount_in <= xpos + 126) && (vcount_in >= ypos - 24) && (vcount_in <= ypos - 21) || 
                            (hcount_in >= xpos + 127) && (hcount_in <= xpos + 185) && (vcount_in >= ypos - 24) && (vcount_in <= ypos - 22) ||
                            (hcount_in >= xpos + 180) && (hcount_in <= xpos + 185) && (vcount_in >= ypos - 21) && (vcount_in <= ypos - 19) ||
                            (hcount_in >= xpos + 180) && (hcount_in <= xpos + 181) && (vcount_in >= ypos - 18) && (vcount_in <= ypos - 8) ||
                            (hcount_in == xpos + 182) && (vcount_in == ypos - 18) ||
                            (hcount_in >= xpos + 180) && (hcount_in <= xpos + 181) && (vcount_in >= ypos - 18) && (vcount_in <= ypos - 8) ||
                            (hcount_in >= xpos + 193) && (hcount_in <= xpos + 199) && (vcount_in == ypos - 4)||
                            (hcount_in >= xpos + 194) && (hcount_in <= xpos + 199) && (vcount_in >= ypos - 6) && (vcount_in <= ypos - 5) ||
                            (hcount_in >= xpos + 180) && (hcount_in <= xpos + 182) && (vcount_in == ypos - 4) ||
                            (hcount_in >= xpos + 210) && (hcount_in <= xpos + 216) && (vcount_in == ypos - 4) ||
                            (hcount_in >= xpos + 211) && (hcount_in <= xpos + 216) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            (hcount_in >= xpos + 214) && (hcount_in <= xpos + 216) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            (hcount_in >= xpos + 194) && (hcount_in <= xpos + 198) && (vcount_in == ypos - 7) ||
                            (hcount_in == xpos + 213) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            (hcount_in >= xpos + 193) && (hcount_in <= xpos + 196) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            (hcount_in >= xpos + 193) && (hcount_in <= xpos + 196) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            (hcount_in >= xpos + 190) && (hcount_in <= xpos + 195) && (vcount_in >= ypos - 11) && (vcount_in <= ypos - 9) ||
                            (hcount_in >= xpos + 186) && (hcount_in <= xpos + 189) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            (hcount_in >= xpos + 189) && (hcount_in <= xpos + 192) && (vcount_in >= ypos - 13) && (vcount_in <= ypos - 12) ||
                            (hcount_in >= xpos + 189) && (hcount_in <= xpos + 191) && (vcount_in == ypos - 14) ||
                            (hcount_in >= xpos + 186) && (hcount_in <= xpos + 188) && (vcount_in == ypos - 18)
                )
                rgb_out_nxt = 12'h000;

                else if(
                            (hcount_in == xpos + 296) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 23)   
                )
                rgb_out_nxt = 12'h650; 

                else if(
                            (hcount_in >= xpos + 297) && (hcount_in <= xpos + 302) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 23)   
                )
                rgb_out_nxt = 12'hfd1; 

                else if(
                            (hcount_in >= xpos - 1) && (hcount_in <= xpos + 2) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 23) ||
                            (hcount_in >= xpos - 4) && (hcount_in <= xpos - 2) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 20) ||
                            (hcount_in >= xpos + 310) && (hcount_in <= xpos + 317) && (vcount_in >= ypos + 24) && (vcount_in <= ypos + 27) || 
                            (hcount_in >= xpos + 314) && (hcount_in <= xpos + 317) && (vcount_in >= ypos + 28) && (vcount_in <= ypos + 30)    
                )
                rgb_out_nxt = 12'hbcc; 

                else if(
                            (hcount_in >= xpos - 4) && (hcount_in <= xpos + 2) && (vcount_in >= ypos + 14) && (vcount_in <= ypos + 16) ||
                            (hcount_in >= xpos + 3) && (hcount_in <= xpos + 5) && (vcount_in >= ypos + 17) && (vcount_in <= ypos + 26) ||
                            (hcount_in >= xpos - 4) && (hcount_in <= xpos + 2) && (vcount_in >= ypos + 24) && (vcount_in <= ypos + 26) ||
                            (hcount_in >= xpos - 4) && (hcount_in <= xpos - 1) && (vcount_in >= ypos + 21) && (vcount_in <= ypos + 23) || 
                            (hcount_in >= xpos + 307) && (hcount_in <= xpos + 320) && (vcount_in >= ypos + 20) && (vcount_in <= ypos + 33)    
                )
                rgb_out_nxt = 12'h455;

                else if(
                            (hcount_in >= xpos + 113) && (hcount_in <= xpos + 209) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            (hcount_in >= xpos + 138) && (hcount_in <= xpos + 212) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            (hcount_in >= xpos + 182) && (hcount_in <= xpos + 210) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            (hcount_in >= xpos + 183) && (hcount_in <= xpos + 209) && (vcount_in == ypos - 4) ||
                            (hcount_in >= xpos + 120) && (hcount_in <= xpos + 206) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            (hcount_in >= xpos + 120) && (hcount_in <= xpos + 203) && (vcount_in == ypos - 18) ||
                            (hcount_in >= xpos + 127) && (hcount_in <= xpos + 202) && (vcount_in >= ypos - 21) && (vcount_in <= ypos - 19) ||
                            (hcount_in >= xpos + 127) && (hcount_in <= xpos + 202) && (vcount_in >= ypos - 21) && (vcount_in <= ypos - 19) ||
                            (hcount_in >= xpos + 186) && (hcount_in <= xpos + 199) && (vcount_in >= ypos - 24) && (vcount_in <= ypos - 22) ||
                            (hcount_in == xpos + 210) && (vcount_in == ypos - 11)         
                )
                rgb_out_nxt = 12'hddc;   

                else if(
                            (hcount_in >= xpos + 23) && (hcount_in <= xpos + 306) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 37) ||
                            (hcount_in >= xpos + 99) && (hcount_in <= xpos + 234) && (vcount_in >= ypos + 38) && (vcount_in <= ypos + 41) ||
                            (hcount_in >= xpos + 4) && (hcount_in <= xpos + 19) && (vcount_in >= ypos + 25) && (vcount_in <= ypos + 31) ||
                            (hcount_in == xpos + 3) && (hcount_in == xpos + 27) ||
                            (hcount_in >= xpos + 13) && (hcount_in <= xpos + 22) && (vcount_in >= ypos + 27) && (vcount_in <= ypos + 34)
                )
                rgb_out_nxt = RGB_3;    

                else if(    
                            (hcount_in >= xpos) && (hcount_in <= xpos + 5) && (vcount_in >= ypos) && (vcount_in <= ypos + 2) ||
                            (hcount_in >= xpos + 3) && (hcount_in <= xpos + 47) && (vcount_in >= ypos - 3) && (vcount_in <= ypos - 1) ||
                            (hcount_in >= xpos + 28) && (hcount_in <= xpos + 47) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 4) ||
                            (hcount_in >= xpos + 48) && (hcount_in <= xpos + 57) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) || 
                            (hcount_in >= xpos + 58) && (hcount_in <= xpos + 68) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            (hcount_in >= xpos + 69) && (hcount_in <= xpos + 75) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            (hcount_in >= xpos + 76) && (hcount_in <= xpos + 85) && (vcount_in >= ypos - 20) && (vcount_in <= ypos - 18) ||
                            (hcount_in >= xpos + 86) && (hcount_in <= xpos + 96) && (vcount_in >= ypos - 24) && (vcount_in <= ypos - 21) ||
                            (hcount_in >= xpos + 97) && (hcount_in <= xpos + 103) && (vcount_in >= ypos - 27) && (vcount_in <= ypos - 25) ||
                            (hcount_in >= xpos + 104) && (hcount_in <= xpos + 188) && (vcount_in >= ypos - 31) && (vcount_in <= ypos - 28) ||
                            (hcount_in >= xpos + 189) && (hcount_in <= xpos + 198) && (vcount_in >= ypos - 28) && (vcount_in <= ypos - 26) ||
                            (hcount_in >= xpos + 198) && (hcount_in <= xpos + 199) && (vcount_in == ypos - 25) ||
                            (hcount_in >= xpos + 217) && (hcount_in <= xpos + 261) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 5) ||
                            (hcount_in >= xpos + 262) && (hcount_in <= xpos + 282) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 5) ||
                            (hcount_in >= xpos + 283) && (hcount_in <= xpos + 299) && (vcount_in >= ypos - 3) && (vcount_in <= ypos - 2) ||
                            (hcount_in >= xpos + 297) && (hcount_in <= xpos + 299) && (vcount_in >= ypos - 1) && (vcount_in <= ypos + 2) ||
                            (hcount_in >= xpos + 300) && (hcount_in <= xpos + 309) && (vcount_in >= ypos) && (vcount_in <= ypos + 2) || 
                            (hcount_in >= xpos + 307) && (hcount_in <= xpos + 309) && (vcount_in >= ypos + 3)  && (vcount_in <= ypos + 5) ||
                            (hcount_in >= xpos + 310) && (hcount_in <= xpos + 313) && (vcount_in >= ypos + 4)  && (vcount_in <= ypos + 6) ||
                            (hcount_in >= xpos + 311) && (hcount_in <= xpos + 317) && (vcount_in >= ypos + 7)  && (vcount_in <= ypos + 9) ||
                            (hcount_in >= xpos) && (hcount_in <= xpos + 2) && (vcount_in >= ypos + 3)  && (vcount_in <= ypos + 13) ||
                            (hcount_in >= xpos + 3) && (hcount_in <= xpos + 317) && (vcount_in >= ypos + 10)  && (vcount_in <= ypos + 26)       
                )
                rgb_out_nxt = RGB_2;

                else if(
                            (hcount_in >= xpos + 3) && (hcount_in <= xpos + 282) && (vcount_in >= ypos - 3) && (vcount_in <= ypos + 9) ||
                            (hcount_in >= xpos + 48) && (hcount_in <= xpos + 282) && (vcount_in >= ypos - 7) && (vcount_in <= ypos - 4) ||
                            (hcount_in >= xpos + 283) && (hcount_in <= xpos + 296) && (vcount_in >= ypos - 1) && (vcount_in <= ypos + 9) ||
                            (hcount_in >= xpos + 297) && (hcount_in <= xpos + 309) && (vcount_in >= ypos + 3) && (vcount_in <= ypos + 9) ||
                            (hcount_in >= xpos + 310) && (hcount_in <= xpos + 310) && (vcount_in >= ypos + 7) && (vcount_in <= ypos + 9) ||
                            (hcount_in >= xpos + 58) && (hcount_in <= xpos + 96) && (vcount_in >= ypos - 10) && (vcount_in <= ypos - 8) ||
                            (hcount_in >= xpos + 69) && (hcount_in <= xpos + 103) && (vcount_in >= ypos - 14) && (vcount_in <= ypos - 11) ||
                            (hcount_in >= xpos + 76) && (hcount_in <= xpos + 110) && (vcount_in >= ypos - 17) && (vcount_in <= ypos - 15) ||
                            (hcount_in >= xpos + 86) && (hcount_in <= xpos + 117) && (vcount_in >= ypos - 20) && (vcount_in <= ypos - 17) ||
                            (hcount_in >= xpos + 97) && (hcount_in <= xpos + 197) && (vcount_in >= ypos - 27) && (vcount_in <= ypos - 20)
                )
                rgb_out_nxt = RGB_1;
                //---------------------------------------------------------------------------------
                else rgb_out_nxt = rgb_in;
            end
        end
endmodule