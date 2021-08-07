//draw_car HORIZONTAL/VERTICAL: 328px/91 px
module draw_car(
    input wire clk,
    input wire reset,
    input wire [10:0] car_hcount_in,
    input wire car_hsync_in,
    input wire car_hblnk_in,
    input wire [10:0] car_vcount_in,
    input wire car_vsync_in,
    input wire car_vblnk_in,
    input wire [11:0] car_rgb_in,
    input wire [11:0] car_xpos,
    input wire [11:0] car_ypos,
    output reg [10:0] car_hcount_out,
    output reg car_hsync_out,
    output reg car_hblnk_out,
    output reg [10:0] car_vcount_out,
    output reg car_vsync_out,
    output reg car_vblnk_out,
    output reg [11:0] car_rgb_out
);

    localparam  RGB_1 = 12'hF8A,
                RGB_2 = 12'hF54,
                RGB_3 = 12'hD10;

    reg [11:0] rgb_out_nxt;
    reg [10:0] hcount_out_nxt, vcount_out_nxt;
    reg hsync_out_nxt, hblnk_out_nxt, vsync_out_nxt, vblnk_out_nxt;

    always @(posedge clk)
        if(reset) begin
            car_hcount_out <= 0;
            car_hsync_out <= 0;
            car_hblnk_out <= 0;
            car_vcount_out <= 0;
            car_vsync_out <= 0;
            car_vblnk_out <= 0;
            car_rgb_out <= 0;
        end
        else begin
            car_hcount_out <= hcount_out_nxt; 
            car_hsync_out <= hsync_out_nxt;
            car_hblnk_out <= hblnk_out_nxt;
            car_vcount_out <= vcount_out_nxt;
            car_vsync_out <= vsync_out_nxt;
            car_vblnk_out <= vblnk_out_nxt;
            car_rgb_out <= rgb_out_nxt;
        end

        always @* begin
            hcount_out_nxt = car_hcount_in; 
            hsync_out_nxt = car_hsync_in;
            hblnk_out_nxt = car_hblnk_in;
            vcount_out_nxt = car_vcount_in;
            vsync_out_nxt = car_vsync_in;
            vblnk_out_nxt = car_vblnk_in;
            if(car_hblnk_in || car_vblnk_in) rgb_out_nxt = 12'h0_0_0;
            else begin
                if (car_vcount_in == 0) rgb_out_nxt = 12'hf_f_0;
                else if (car_vcount_in == 767) rgb_out_nxt = 12'hf_0_0;
                else if (car_hcount_in == 0) rgb_out_nxt = 12'h0_f_0;
                else if (car_hcount_in == 1023) rgb_out_nxt = 12'h0_0_f;


                //---------------------------------------------------------------------------------

                else if( //SZARY CIEMNY
                            (car_hcount_in >= car_xpos + 142) && (car_hcount_in <= car_xpos + 150) && (car_vcount_in >= car_ypos) && (car_vcount_in <= car_ypos + 2) ||
                            (car_hcount_in >= car_xpos + 142) && (car_hcount_in <= car_xpos + 144) && (car_vcount_in == car_ypos + 3) ||
                            (car_hcount_in >= car_xpos + 142) && (car_hcount_in <= car_xpos + 143) && (car_vcount_in >= car_ypos + 4) && (car_vcount_in <= car_ypos + 5) ||
                            
                            //Blotnik lewy
                            (car_hcount_in == car_xpos + 51) && (car_vcount_in == car_ypos + 37) ||
                            (car_hcount_in >= car_xpos + 52) && (car_hcount_in <= car_xpos + 98) && (car_vcount_in >= car_ypos + 30) && (car_vcount_in <= car_ypos + 37) ||
                            (car_hcount_in >= car_xpos + 97) && (car_hcount_in <= car_xpos + 98) && (car_vcount_in >= car_ypos + 38) && (car_vcount_in <= car_ypos + 41) ||
                            (car_hcount_in == car_xpos + 99) && (car_vcount_in == car_ypos + 41) ||
                            (car_hcount_in >= car_xpos + 53) && (car_hcount_in <= car_xpos + 97) && (car_vcount_in >= car_ypos + 26) && (car_vcount_in <= car_ypos + 29) ||
                            (car_hcount_in >= car_xpos + 53) && (car_hcount_in <= car_xpos + 97) && (car_vcount_in >= car_ypos + 26) && (car_vcount_in <= car_ypos + 29) ||
                            (car_hcount_in >= car_xpos + 54) && (car_hcount_in <= car_xpos + 96) && (car_vcount_in == car_ypos + 25) ||
                            (car_hcount_in >= car_xpos + 55) && (car_hcount_in <= car_xpos + 95) && (car_vcount_in == car_ypos + 24) ||
                            (car_hcount_in >= car_xpos + 56) && (car_hcount_in <= car_xpos + 94) && (car_vcount_in >= car_ypos + 22) && (car_vcount_in <= car_ypos + 23) ||
                            (car_hcount_in >= car_xpos + 57) && (car_hcount_in <= car_xpos + 93) && (car_vcount_in == car_ypos + 21) ||
                            (car_hcount_in >= car_xpos + 58) && (car_hcount_in <= car_xpos + 92) && (car_vcount_in == car_ypos + 20) ||
                            (car_hcount_in >= car_xpos + 59) && (car_hcount_in <= car_xpos + 91) && (car_vcount_in == car_ypos + 19) ||
                            (car_hcount_in >= car_xpos + 61) && (car_hcount_in <= car_xpos + 89) && (car_vcount_in == car_ypos + 18) ||
                            (car_hcount_in >= car_xpos + 62) && (car_hcount_in <= car_xpos + 88) && (car_vcount_in == car_ypos + 17) ||
                            (car_hcount_in >= car_xpos + 63) && (car_hcount_in <= car_xpos + 87) && (car_vcount_in == car_ypos + 16) ||
                            (car_hcount_in >= car_xpos + 66) && (car_hcount_in <= car_xpos + 84) && (car_vcount_in == car_ypos + 15) ||

                            //Blotnik prawa
                            (car_hcount_in == car_xpos + 282) && (car_vcount_in == car_ypos + 37) ||
                            (car_hcount_in >= car_xpos + 235) && (car_hcount_in <= car_xpos + 281) && (car_vcount_in >= car_ypos + 30) && (car_vcount_in <= car_ypos + 37) ||
                            (car_hcount_in >= car_xpos + 236) && (car_hcount_in <= car_xpos + 280) && (car_vcount_in >= car_ypos + 26) && (car_vcount_in <= car_ypos + 29) ||
                            (car_hcount_in >= car_xpos + 236) && (car_hcount_in <= car_xpos + 280) && (car_vcount_in >= car_ypos + 26) && (car_vcount_in <= car_ypos + 29) ||
                            (car_hcount_in >= car_xpos + 237) && (car_hcount_in <= car_xpos + 279) && (car_vcount_in == car_ypos + 25) ||
                            (car_hcount_in >= car_xpos + 238) && (car_hcount_in <= car_xpos + 278) && (car_vcount_in == car_ypos + 24) ||
                            (car_hcount_in >= car_xpos + 239) && (car_hcount_in <= car_xpos + 277) && (car_vcount_in >= car_ypos + 22) && (car_vcount_in <= car_ypos + 23) ||
                            (car_hcount_in >= car_xpos + 240) && (car_hcount_in <= car_xpos + 276) && (car_vcount_in == car_ypos + 21) ||
                            (car_hcount_in >= car_xpos + 241) && (car_hcount_in <= car_xpos + 275) && (car_vcount_in == car_ypos + 20) ||
                            (car_hcount_in >= car_xpos + 242) && (car_hcount_in <= car_xpos + 274) && (car_vcount_in == car_ypos + 19) ||
                            (car_hcount_in >= car_xpos + 244) && (car_hcount_in <= car_xpos + 272) && (car_vcount_in == car_ypos + 18) ||
                            (car_hcount_in >= car_xpos + 245) && (car_hcount_in <= car_xpos + 271) && (car_vcount_in == car_ypos + 17) ||
                            (car_hcount_in >= car_xpos + 246) && (car_hcount_in <= car_xpos + 270) && (car_vcount_in == car_ypos + 16) ||
                            (car_hcount_in >= car_xpos + 249) && (car_hcount_in <= car_xpos + 267) && (car_vcount_in == car_ypos + 15) ||
                            (car_hcount_in >= car_xpos + 235) && (car_hcount_in <= car_xpos + 236) && (car_vcount_in >= car_ypos + 38) && (car_vcount_in <= car_ypos + 41) ||
                            (car_hcount_in == car_xpos + 234) && (car_vcount_in == car_ypos + 41)                       
                )
                rgb_out_nxt = 12'h322;

                else if( //SZARY CIEMNY
                            (car_hcount_in >= car_xpos + 49) && (car_hcount_in <= car_xpos + 95) && (car_vcount_in >= car_ypos - 4) && (car_vcount_in <= car_ypos - 1) ||
                            (car_hcount_in == car_xpos + 48) && (car_vcount_in >= car_ypos - 3) && (car_vcount_in <= car_ypos - 2) ||
                            (car_hcount_in >= car_xpos + 93) && (car_hcount_in <= car_xpos + 98) && (car_vcount_in >= car_ypos - 7) && (car_vcount_in <= car_ypos - 5) ||
                            (car_hcount_in >= car_xpos + 97) && (car_hcount_in <= car_xpos + 99) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8)
                )
                rgb_out_nxt = 12'h666;

                else if( //CZARNY
                            (car_hcount_in >= car_xpos + 294) && (car_hcount_in <= car_xpos + 295) && (car_vcount_in >= car_ypos + 21) && (car_vcount_in <= car_ypos + 23) ||
                            (car_hcount_in >= car_xpos + 24) && (car_hcount_in <= car_xpos + 50) && (car_vcount_in >= car_ypos + 38) && (car_vcount_in <= car_ypos + 40) ||
                            (car_hcount_in >= car_xpos + 100) && (car_hcount_in <= car_xpos + 233) && (car_vcount_in >= car_ypos + 42) && (car_vcount_in <= car_ypos + 43) ||
                            (car_hcount_in >= car_xpos + 135) && (car_hcount_in <= car_xpos + 137) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos + 41) ||
                            (car_hcount_in >= car_xpos + 135) && (car_hcount_in <= car_xpos + 137) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos + 41) || 
                            (car_hcount_in >= car_xpos + 138) && (car_hcount_in <= car_xpos + 181) && (car_vcount_in >= car_ypos - 7) && (car_vcount_in <= car_ypos - 5) ||
                            (car_hcount_in >= car_xpos + 180) && (car_hcount_in <= car_xpos + 216) && (car_vcount_in >= car_ypos - 3) && (car_vcount_in <= car_ypos - 2) ||
                            (car_hcount_in >= car_xpos + 214) && (car_hcount_in <= car_xpos + 216) && (car_vcount_in >= car_ypos - 1) && (car_vcount_in <= car_ypos + 41) ||
                            (car_hcount_in >= car_xpos + 283) && (car_hcount_in <= car_xpos + 316) && (car_vcount_in >= car_ypos + 37) && (car_vcount_in <= car_ypos + 39) ||
                            (car_hcount_in >= car_xpos + 301) && (car_hcount_in <= car_xpos + 317) && (car_vcount_in >= car_ypos + 34) && (car_vcount_in <= car_ypos + 36) ||
                            (car_hcount_in >= car_xpos + 307) && (car_hcount_in <= car_xpos + 320) && (car_vcount_in >= car_ypos + 33) && (car_vcount_in <= car_ypos + 35) ||
                            (car_hcount_in >= car_xpos + 318) && (car_hcount_in <= car_xpos + 319) && (car_vcount_in >= car_ypos + 7) && (car_vcount_in <= car_ypos + 19) || 
                            (car_hcount_in == car_xpos + 320) && (car_vcount_in >= car_ypos + 17) && (car_vcount_in <= car_ypos + 19) ||
                            (car_hcount_in >= car_xpos + 321) && (car_hcount_in <= car_xpos + 323) && (car_vcount_in >= car_ypos + 18) && (car_vcount_in <= car_ypos + 33) || 
                            (car_hcount_in >= car_xpos + 100) && (car_hcount_in <= car_xpos + 134) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) ||
                            (car_hcount_in >= car_xpos + 100) && (car_hcount_in <= car_xpos + 134) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) ||  
                            (car_hcount_in >= car_xpos + 104) && (car_hcount_in <= car_xpos + 112) && (car_vcount_in >= car_ypos - 14) && (car_vcount_in <= car_ypos - 11) ||
                            (car_hcount_in >= car_xpos + 104) && (car_hcount_in <= car_xpos + 112) && (car_vcount_in >= car_ypos - 14) && (car_vcount_in <= car_ypos - 11) ||
                            (car_hcount_in >= car_xpos + 111) && (car_hcount_in <= car_xpos + 119) && (car_vcount_in >= car_ypos - 17) && (car_vcount_in <= car_ypos - 15) ||
                            (car_hcount_in >= car_xpos + 118) && (car_hcount_in <= car_xpos + 119) && (car_vcount_in == car_ypos - 18) ||
                            (car_hcount_in >= car_xpos + 118) && (car_hcount_in <= car_xpos + 126) && (car_vcount_in >= car_ypos - 20) && (car_vcount_in <= car_ypos - 19) ||
                            (car_hcount_in >= car_xpos + 118) && (car_hcount_in <= car_xpos + 126) && (car_vcount_in >= car_ypos - 20) && (car_vcount_in <= car_ypos - 19) ||
                            (car_hcount_in >= car_xpos + 124) && (car_hcount_in <= car_xpos + 126) && (car_vcount_in >= car_ypos - 24) && (car_vcount_in <= car_ypos - 21) || 
                            (car_hcount_in >= car_xpos + 127) && (car_hcount_in <= car_xpos + 185) && (car_vcount_in >= car_ypos - 24) && (car_vcount_in <= car_ypos - 22) ||
                            (car_hcount_in >= car_xpos + 180) && (car_hcount_in <= car_xpos + 185) && (car_vcount_in >= car_ypos - 21) && (car_vcount_in <= car_ypos - 19) ||
                            (car_hcount_in >= car_xpos + 180) && (car_hcount_in <= car_xpos + 181) && (car_vcount_in >= car_ypos - 18) && (car_vcount_in <= car_ypos - 8) ||
                            (car_hcount_in == car_xpos + 182) && (car_vcount_in == car_ypos - 18) ||
                            (car_hcount_in >= car_xpos + 180) && (car_hcount_in <= car_xpos + 181) && (car_vcount_in >= car_ypos - 18) && (car_vcount_in <= car_ypos - 8) ||
                            (car_hcount_in >= car_xpos + 193) && (car_hcount_in <= car_xpos + 199) && (car_vcount_in == car_ypos - 4)||
                            (car_hcount_in >= car_xpos + 194) && (car_hcount_in <= car_xpos + 199) && (car_vcount_in >= car_ypos - 6) && (car_vcount_in <= car_ypos - 5) ||
                            (car_hcount_in >= car_xpos + 180) && (car_hcount_in <= car_xpos + 182) && (car_vcount_in == car_ypos - 4) ||
                            (car_hcount_in >= car_xpos + 210) && (car_hcount_in <= car_xpos + 216) && (car_vcount_in == car_ypos - 4) ||
                            (car_hcount_in >= car_xpos + 211) && (car_hcount_in <= car_xpos + 216) && (car_vcount_in >= car_ypos - 7) && (car_vcount_in <= car_ypos - 5) ||
                            (car_hcount_in >= car_xpos + 214) && (car_hcount_in <= car_xpos + 216) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) ||
                            (car_hcount_in >= car_xpos + 194) && (car_hcount_in <= car_xpos + 198) && (car_vcount_in == car_ypos - 7) ||
                            (car_hcount_in == car_xpos + 213) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) ||
                            (car_hcount_in >= car_xpos + 193) && (car_hcount_in <= car_xpos + 196) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) ||
                            (car_hcount_in >= car_xpos + 193) && (car_hcount_in <= car_xpos + 196) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) ||
                            (car_hcount_in >= car_xpos + 190) && (car_hcount_in <= car_xpos + 195) && (car_vcount_in >= car_ypos - 11) && (car_vcount_in <= car_ypos - 9) ||
                            (car_hcount_in >= car_xpos + 186) && (car_hcount_in <= car_xpos + 189) && (car_vcount_in >= car_ypos - 17) && (car_vcount_in <= car_ypos - 15) ||
                            (car_hcount_in >= car_xpos + 189) && (car_hcount_in <= car_xpos + 192) && (car_vcount_in >= car_ypos - 13) && (car_vcount_in <= car_ypos - 12) ||
                            (car_hcount_in >= car_xpos + 189) && (car_hcount_in <= car_xpos + 191) && (car_vcount_in == car_ypos - 14) ||
                            (car_hcount_in >= car_xpos + 186) && (car_hcount_in <= car_xpos + 188) && (car_vcount_in == car_ypos - 18)
                )
                rgb_out_nxt = 12'h000;

                else if( //ZOLTY CIEMNY
                            (car_hcount_in == car_xpos + 296) && (car_vcount_in >= car_ypos + 21) && (car_vcount_in <= car_ypos + 23)   
                )
                rgb_out_nxt = 12'h000; 

                else if( //ZOLTY JASNY
                            (car_hcount_in >= car_xpos + 297) && (car_hcount_in <= car_xpos + 302) && (car_vcount_in >= car_ypos + 21) && (car_vcount_in <= car_ypos + 23)   
                )
                rgb_out_nxt = 12'hfff; 

                else if( //SZARY
                            (car_hcount_in >= car_xpos - 1) && (car_hcount_in <= car_xpos + 2) && (car_vcount_in >= car_ypos + 17) && (car_vcount_in <= car_ypos + 23) ||
                            (car_hcount_in >= car_xpos - 4) && (car_hcount_in <= car_xpos - 2) && (car_vcount_in >= car_ypos + 17) && (car_vcount_in <= car_ypos + 20) ||
                            (car_hcount_in >= car_xpos + 310) && (car_hcount_in <= car_xpos + 317) && (car_vcount_in >= car_ypos + 24) && (car_vcount_in <= car_ypos + 27) || 
                            (car_hcount_in >= car_xpos + 314) && (car_hcount_in <= car_xpos + 317) && (car_vcount_in >= car_ypos + 28) && (car_vcount_in <= car_ypos + 30)    
                )
                rgb_out_nxt = 12'hbcc; 

                else if( //SZARY
                            (car_hcount_in >= car_xpos - 4) && (car_hcount_in <= car_xpos + 2) && (car_vcount_in >= car_ypos + 14) && (car_vcount_in <= car_ypos + 16) ||
                            (car_hcount_in >= car_xpos + 3) && (car_hcount_in <= car_xpos + 5) && (car_vcount_in >= car_ypos + 17) && (car_vcount_in <= car_ypos + 26) ||
                            (car_hcount_in >= car_xpos - 4) && (car_hcount_in <= car_xpos + 2) && (car_vcount_in >= car_ypos + 24) && (car_vcount_in <= car_ypos + 26) ||
                            (car_hcount_in >= car_xpos - 4) && (car_hcount_in <= car_xpos - 1) && (car_vcount_in >= car_ypos + 21) && (car_vcount_in <= car_ypos + 23) || 
                            (car_hcount_in >= car_xpos + 307) && (car_hcount_in <= car_xpos + 320) && (car_vcount_in >= car_ypos + 20) && (car_vcount_in <= car_ypos + 33)    
                )
                rgb_out_nxt = 12'h455;

                else if( //SZARY OKNA DO POPRAWY
                            (car_hcount_in >= car_xpos + 113) && (car_hcount_in <= car_xpos + 209) && (car_vcount_in >= car_ypos - 14) && (car_vcount_in <= car_ypos - 11) ||
                            (car_hcount_in >= car_xpos + 138) && (car_hcount_in <= car_xpos + 212) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) ||
                            (car_hcount_in >= car_xpos + 182) && (car_hcount_in <= car_xpos + 210) && (car_vcount_in >= car_ypos - 7) && (car_vcount_in <= car_ypos - 5) ||
                            (car_hcount_in >= car_xpos + 183) && (car_hcount_in <= car_xpos + 209) && (car_vcount_in == car_ypos - 4) ||
                            (car_hcount_in >= car_xpos + 120) && (car_hcount_in <= car_xpos + 206) && (car_vcount_in >= car_ypos - 17) && (car_vcount_in <= car_ypos - 15) ||
                            (car_hcount_in >= car_xpos + 120) && (car_hcount_in <= car_xpos + 203) && (car_vcount_in == car_ypos - 18) ||
                            (car_hcount_in >= car_xpos + 127) && (car_hcount_in <= car_xpos + 202) && (car_vcount_in >= car_ypos - 21) && (car_vcount_in <= car_ypos - 19) ||
                            (car_hcount_in >= car_xpos + 127) && (car_hcount_in <= car_xpos + 202) && (car_vcount_in >= car_ypos - 21) && (car_vcount_in <= car_ypos - 19) ||
                            (car_hcount_in >= car_xpos + 186) && (car_hcount_in <= car_xpos + 199) && (car_vcount_in >= car_ypos - 24) && (car_vcount_in <= car_ypos - 22) ||
                            (car_hcount_in == car_xpos + 210) && (car_vcount_in == car_ypos - 11)         
                )
                rgb_out_nxt = 12'hdd3;   

                else if(
                            (car_hcount_in >= car_xpos + 23) && (car_hcount_in <= car_xpos + 306) && (car_vcount_in >= car_ypos + 27) && (car_vcount_in <= car_ypos + 37) ||
                            (car_hcount_in >= car_xpos + 99) && (car_hcount_in <= car_xpos + 234) && (car_vcount_in >= car_ypos + 38) && (car_vcount_in <= car_ypos + 41) ||
                            (car_hcount_in >= car_xpos + 4) && (car_hcount_in <= car_xpos + 19) && (car_vcount_in >= car_ypos + 25) && (car_vcount_in <= car_ypos + 31) ||
                            (car_hcount_in == car_xpos + 3) && (car_hcount_in == car_xpos + 27) ||
                            (car_hcount_in >= car_xpos + 13) && (car_hcount_in <= car_xpos + 22) && (car_vcount_in >= car_ypos + 27) && (car_vcount_in <= car_ypos + 34)
                )
                rgb_out_nxt = RGB_3;    

                else if(    
                            (car_hcount_in >= car_xpos) && (car_hcount_in <= car_xpos + 5) && (car_vcount_in >= car_ypos) && (car_vcount_in <= car_ypos + 2) ||
                            (car_hcount_in >= car_xpos + 3) && (car_hcount_in <= car_xpos + 47) && (car_vcount_in >= car_ypos - 3) && (car_vcount_in <= car_ypos - 1) ||
                            (car_hcount_in >= car_xpos + 28) && (car_hcount_in <= car_xpos + 47) && (car_vcount_in >= car_ypos - 7) && (car_vcount_in <= car_ypos - 4) ||
                            (car_hcount_in >= car_xpos + 48) && (car_hcount_in <= car_xpos + 57) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) || 
                            (car_hcount_in >= car_xpos + 58) && (car_hcount_in <= car_xpos + 68) && (car_vcount_in >= car_ypos - 14) && (car_vcount_in <= car_ypos - 11) ||
                            (car_hcount_in >= car_xpos + 69) && (car_hcount_in <= car_xpos + 75) && (car_vcount_in >= car_ypos - 17) && (car_vcount_in <= car_ypos - 15) ||
                            (car_hcount_in >= car_xpos + 76) && (car_hcount_in <= car_xpos + 85) && (car_vcount_in >= car_ypos - 20) && (car_vcount_in <= car_ypos - 18) ||
                            (car_hcount_in >= car_xpos + 86) && (car_hcount_in <= car_xpos + 96) && (car_vcount_in >= car_ypos - 24) && (car_vcount_in <= car_ypos - 21) ||
                            (car_hcount_in >= car_xpos + 97) && (car_hcount_in <= car_xpos + 103) && (car_vcount_in >= car_ypos - 27) && (car_vcount_in <= car_ypos - 25) ||
                            (car_hcount_in >= car_xpos + 104) && (car_hcount_in <= car_xpos + 188) && (car_vcount_in >= car_ypos - 31) && (car_vcount_in <= car_ypos - 28) ||
                            (car_hcount_in >= car_xpos + 189) && (car_hcount_in <= car_xpos + 198) && (car_vcount_in >= car_ypos - 28) && (car_vcount_in <= car_ypos - 26) ||
                            (car_hcount_in >= car_xpos + 198) && (car_hcount_in <= car_xpos + 199) && (car_vcount_in == car_ypos - 25) ||
                            (car_hcount_in >= car_xpos + 217) && (car_hcount_in <= car_xpos + 261) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 5) ||
                            (car_hcount_in >= car_xpos + 262) && (car_hcount_in <= car_xpos + 282) && (car_vcount_in >= car_ypos - 7) && (car_vcount_in <= car_ypos - 5) ||
                            (car_hcount_in >= car_xpos + 283) && (car_hcount_in <= car_xpos + 299) && (car_vcount_in >= car_ypos - 3) && (car_vcount_in <= car_ypos - 2) ||
                            (car_hcount_in >= car_xpos + 297) && (car_hcount_in <= car_xpos + 299) && (car_vcount_in >= car_ypos - 1) && (car_vcount_in <= car_ypos + 2) ||
                            (car_hcount_in >= car_xpos + 300) && (car_hcount_in <= car_xpos + 309) && (car_vcount_in >= car_ypos) && (car_vcount_in <= car_ypos + 2) || 
                            (car_hcount_in >= car_xpos + 307) && (car_hcount_in <= car_xpos + 309) && (car_vcount_in >= car_ypos + 3)  && (car_vcount_in <= car_ypos + 5) ||
                            (car_hcount_in >= car_xpos + 310) && (car_hcount_in <= car_xpos + 313) && (car_vcount_in >= car_ypos + 4)  && (car_vcount_in <= car_ypos + 6) ||
                            (car_hcount_in >= car_xpos + 311) && (car_hcount_in <= car_xpos + 317) && (car_vcount_in >= car_ypos + 7)  && (car_vcount_in <= car_ypos + 9) ||
                            (car_hcount_in >= car_xpos) && (car_hcount_in <= car_xpos + 2) && (car_vcount_in >= car_ypos + 3)  && (car_vcount_in <= car_ypos + 13) ||
                            (car_hcount_in >= car_xpos + 3) && (car_hcount_in <= car_xpos + 317) && (car_vcount_in >= car_ypos + 10)  && (car_vcount_in <= car_ypos + 26)       
                )
                rgb_out_nxt = RGB_2;

                else if(
                            (car_hcount_in >= car_xpos + 3) && (car_hcount_in <= car_xpos + 282) && (car_vcount_in >= car_ypos - 3) && (car_vcount_in <= car_ypos + 9) ||
                            (car_hcount_in >= car_xpos + 48) && (car_hcount_in <= car_xpos + 282) && (car_vcount_in >= car_ypos - 7) && (car_vcount_in <= car_ypos - 4) ||
                            (car_hcount_in >= car_xpos + 283) && (car_hcount_in <= car_xpos + 296) && (car_vcount_in >= car_ypos - 1) && (car_vcount_in <= car_ypos + 9) ||
                            (car_hcount_in >= car_xpos + 297) && (car_hcount_in <= car_xpos + 309) && (car_vcount_in >= car_ypos + 3) && (car_vcount_in <= car_ypos + 9) ||
                            (car_hcount_in >= car_xpos + 310) && (car_hcount_in <= car_xpos + 310) && (car_vcount_in >= car_ypos + 7) && (car_vcount_in <= car_ypos + 9) ||
                            (car_hcount_in >= car_xpos + 58) && (car_hcount_in <= car_xpos + 96) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) ||
                            (car_hcount_in >= car_xpos + 69) && (car_hcount_in <= car_xpos + 103) && (car_vcount_in >= car_ypos - 14) && (car_vcount_in <= car_ypos - 11) ||
                            (car_hcount_in >= car_xpos + 76) && (car_hcount_in <= car_xpos + 110) && (car_vcount_in >= car_ypos - 17) && (car_vcount_in <= car_ypos - 15) ||
                            (car_hcount_in >= car_xpos + 86) && (car_hcount_in <= car_xpos + 117) && (car_vcount_in >= car_ypos - 20) && (car_vcount_in <= car_ypos - 17) ||
                            (car_hcount_in >= car_xpos + 97) && (car_hcount_in <= car_xpos + 197) && (car_vcount_in >= car_ypos - 27) && (car_vcount_in <= car_ypos - 20)
                )
                rgb_out_nxt = RGB_1;
                //---------------------------------------------------------------------------------

                else rgb_out_nxt = car_rgb_in;
            end
        end
endmodule