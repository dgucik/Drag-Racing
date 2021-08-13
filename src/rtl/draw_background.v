module draw_background(
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire vsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
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
    
//----colors_for_game_background-------------------------------------------------   
    localparam SKY_COLOR = 12'h5_c_f;           //blue
    localparam GRASS_COLOR = 12'h4_9_4;         //green
    localparam ROAD_COLOR = 12'h9_a_b;          //gray
    localparam ROAD_MIDLINE_COLOR = 12'hf_f_4;  //yellow
    localparam ROAD_SIDELINE_COLOR = 12'h4_6_6; //dark_gray
    localparam MENU_SQUARE_COLOR = 12'hf_5_2;   //orange
    localparam PILLAR_COLOR = 12'h678; //gray
//------------------------------------------------------------------------------- 

//----finish/start line position-------------------------------------------------
    localparam FINISH_LINE_HOR_POS = 1500;

    localparam LINE_VER_POS = 275;
//-------------------------------------------------------------------------------

    reg [11:0] rgb_out_nxt;
    reg [10:0] hcount_out_nxt, vcount_out_nxt;
    reg hsync_out_nxt, hblnk_out_nxt, vsync_out_nxt, vblnk_out_nxt;

    wire [9:0] pillar_1_top_start, pillar_1_top_end, pillar_1_bottom_start, pillar_1_bottom_end;
    wire [9:0] pillar_2_top_start, pillar_2_top_end, pillar_2_bottom_start, pillar_2_bottom_end;
    wire [9:0] pillar_3_top_start, pillar_3_top_end, pillar_3_bottom_start, pillar_3_bottom_end;
    wire [9:0] pillar_4_top_start, pillar_4_top_end, pillar_4_bottom_start, pillar_4_bottom_end;

    assign pillar_1_top_start = 5 - position;
    assign pillar_1_top_end = 14 - position;
    assign pillar_1_bottom_start = 0 - position;
    assign pillar_1_bottom_end = 19 - position;

    assign pillar_2_top_start = 5 - position + 256;
    assign pillar_2_top_end = 14 - position + 256;
    assign pillar_2_bottom_start = 0 - position + 256;
    assign pillar_2_bottom_end = 19 - position + 256;

    assign pillar_3_top_start = 5 - position + 512;
    assign pillar_3_top_end = 14 - position + 512;
    assign pillar_3_bottom_start = 0 - position + 512;
    assign pillar_3_bottom_end = 19 - position + 512;

    assign pillar_4_top_start = 5 - position + 768;
    assign pillar_4_top_end = 14 - position + 768;
    assign pillar_4_bottom_start = 0 - position + 768;
    assign pillar_4_bottom_end = 19 - position + 768;
    
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
        // During blanking, make it it black.
        if(hblnk_in||vblnk_in) rgb_out_nxt = 12'h0_0_0;
        else begin

            //START LINE
            if( (hcount_in >= 580 - position) && (hcount_in <= 589 - position) && (vcount_in >= LINE_VER_POS) && (vcount_in <= LINE_VER_POS + 285) )
                rgb_out_nxt = 12'hfff;

            //FINISH LINE
            else if(    (hcount_in >= FINISH_LINE_HOR_POS - position) && (hcount_in <= FINISH_LINE_HOR_POS + 4 - position) && ((vcount_in >= LINE_VER_POS) && (vcount_in <= LINE_VER_POS + 4) ||
                        (vcount_in >= LINE_VER_POS + 10) && (vcount_in <= LINE_VER_POS + 14) ||
                        (vcount_in >= LINE_VER_POS + 20) && (vcount_in <= LINE_VER_POS + 24) ||
                        (vcount_in >= LINE_VER_POS + 30) && (vcount_in <= LINE_VER_POS + 34) ||
                        (vcount_in >= LINE_VER_POS + 40) && (vcount_in <= LINE_VER_POS + 44) ||
                        (vcount_in >= LINE_VER_POS + 50) && (vcount_in <= LINE_VER_POS + 54) ||
                        (vcount_in >= LINE_VER_POS + 60) && (vcount_in <= LINE_VER_POS + 64) ||
                        (vcount_in >= LINE_VER_POS + 70) && (vcount_in <= LINE_VER_POS + 74) ||
                        (vcount_in >= LINE_VER_POS + 80) && (vcount_in <= LINE_VER_POS + 84) ||
                        (vcount_in >= LINE_VER_POS + 90) && (vcount_in <= LINE_VER_POS + 94) ||
                        (vcount_in >= LINE_VER_POS + 100) && (vcount_in <= LINE_VER_POS + 104) ||
                        (vcount_in >= LINE_VER_POS + 110) && (vcount_in <= LINE_VER_POS + 114) ||
                        (vcount_in >= LINE_VER_POS + 120) && (vcount_in <= LINE_VER_POS + 124) ||
                        (vcount_in >= LINE_VER_POS + 130) && (vcount_in <= LINE_VER_POS + 134) ||
                        (vcount_in >= LINE_VER_POS + 140) && (vcount_in <= LINE_VER_POS + 144) ||
                        (vcount_in >= LINE_VER_POS + 150) && (vcount_in <= LINE_VER_POS + 154) ||
                        (vcount_in >= LINE_VER_POS + 160) && (vcount_in <= LINE_VER_POS + 164) ||
                        (vcount_in >= LINE_VER_POS + 170) && (vcount_in <= LINE_VER_POS + 174) ||
                        (vcount_in >= LINE_VER_POS + 180) && (vcount_in <= LINE_VER_POS + 184) ||
                        (vcount_in >= LINE_VER_POS + 190) && (vcount_in <= LINE_VER_POS + 194) ||
                        (vcount_in >= LINE_VER_POS + 200) && (vcount_in <= LINE_VER_POS + 204) ||
                        (vcount_in >= LINE_VER_POS + 210) && (vcount_in <= LINE_VER_POS + 214) ||
                        (vcount_in >= LINE_VER_POS + 220) && (vcount_in <= LINE_VER_POS + 224) ||
                        (vcount_in >= LINE_VER_POS + 230) && (vcount_in <= LINE_VER_POS + 234) ||
                        (vcount_in >= LINE_VER_POS + 240) && (vcount_in <= LINE_VER_POS + 244) ||
                        (vcount_in >= LINE_VER_POS + 250) && (vcount_in <= LINE_VER_POS + 254) ||
                        (vcount_in >= LINE_VER_POS + 260) && (vcount_in <= LINE_VER_POS + 264) ||
                        (vcount_in >= LINE_VER_POS + 270) && (vcount_in <= LINE_VER_POS + 274) ||
                        (vcount_in >= LINE_VER_POS + 280) && (vcount_in <= LINE_VER_POS + 285)) ||

                        (hcount_in >= FINISH_LINE_HOR_POS + 5 - position) && (hcount_in <= FINISH_LINE_HOR_POS + 9 - position) && ((vcount_in >= LINE_VER_POS + 5) && (vcount_in <= LINE_VER_POS + 9) ||
                        (vcount_in >= LINE_VER_POS + 15) && (vcount_in <= LINE_VER_POS + 19) ||
                        (vcount_in >= LINE_VER_POS + 25) && (vcount_in <= LINE_VER_POS + 29) ||
                        (vcount_in >= LINE_VER_POS + 35) && (vcount_in <= LINE_VER_POS + 39) ||
                        (vcount_in >= LINE_VER_POS + 45) && (vcount_in <= LINE_VER_POS + 49) ||
                        (vcount_in >= LINE_VER_POS + 55) && (vcount_in <= LINE_VER_POS + 59) ||
                        (vcount_in >= LINE_VER_POS + 65) && (vcount_in <= LINE_VER_POS + 69) ||
                        (vcount_in >= LINE_VER_POS + 75) && (vcount_in <= LINE_VER_POS + 79) ||
                        (vcount_in >= LINE_VER_POS + 85) && (vcount_in <= LINE_VER_POS + 89) ||
                        (vcount_in >= LINE_VER_POS + 95) && (vcount_in <= LINE_VER_POS + 99) ||
                        (vcount_in >= LINE_VER_POS + 105) && (vcount_in <= LINE_VER_POS + 109) ||
                        (vcount_in >= LINE_VER_POS + 115) && (vcount_in <= LINE_VER_POS + 119) ||
                        (vcount_in >= LINE_VER_POS + 125) && (vcount_in <= LINE_VER_POS + 129) ||
                        (vcount_in >= LINE_VER_POS + 135) && (vcount_in <= LINE_VER_POS + 139) ||
                        (vcount_in >= LINE_VER_POS + 145) && (vcount_in <= LINE_VER_POS + 149) ||
                        (vcount_in >= LINE_VER_POS + 155) && (vcount_in <= LINE_VER_POS + 159) ||
                        (vcount_in >= LINE_VER_POS + 165) && (vcount_in <= LINE_VER_POS + 169) ||
                        (vcount_in >= LINE_VER_POS + 175) && (vcount_in <= LINE_VER_POS + 179) ||
                        (vcount_in >= LINE_VER_POS + 185) && (vcount_in <= LINE_VER_POS + 189) ||
                        (vcount_in >= LINE_VER_POS + 195) && (vcount_in <= LINE_VER_POS + 199) ||
                        (vcount_in >= LINE_VER_POS + 205) && (vcount_in <= LINE_VER_POS + 209) ||
                        (vcount_in >= LINE_VER_POS + 215) && (vcount_in <= LINE_VER_POS + 219) ||
                        (vcount_in >= LINE_VER_POS + 225) && (vcount_in <= LINE_VER_POS + 229) ||
                        (vcount_in >= LINE_VER_POS + 235) && (vcount_in <= LINE_VER_POS + 239) ||
                        (vcount_in >= LINE_VER_POS + 245) && (vcount_in <= LINE_VER_POS + 249) ||
                        (vcount_in >= LINE_VER_POS + 255) && (vcount_in <= LINE_VER_POS + 259) ||
                        (vcount_in >= LINE_VER_POS + 265) && (vcount_in <= LINE_VER_POS + 269) ||
                        (vcount_in >= LINE_VER_POS + 275) && (vcount_in <= LINE_VER_POS + 279))
                )
                rgb_out_nxt = 12'h000;

            else if( (hcount_in >= FINISH_LINE_HOR_POS - position) && (hcount_in <= FINISH_LINE_HOR_POS + 9 - position) && (vcount_in >= LINE_VER_POS) && (vcount_in <= LINE_VER_POS + 285) )
                rgb_out_nxt = 12'hfff;

            //Pillars
            else if( (pillar_1_bottom_start < pillar_1_bottom_end) && (hcount_in >= pillar_1_bottom_start ) && (hcount_in <= pillar_1_bottom_end) && (vcount_in >= 84) && (vcount_in <= 169) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_1_bottom_start >= pillar_1_bottom_end) && ((hcount_in >= pillar_1_bottom_start ) || (hcount_in <= pillar_1_bottom_end)) && (vcount_in >= 84) && (vcount_in <= 169) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_1_top_start < pillar_1_top_end) && (hcount_in >= pillar_1_top_start ) && (hcount_in <= pillar_1_top_end) && (vcount_in >= 0) && (vcount_in <= 83) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_1_top_start >= pillar_1_top_end) && ((hcount_in >= pillar_1_top_start ) || (hcount_in <= pillar_1_top_end)) && (vcount_in >= 0) && (vcount_in <= 83) )
                rgb_out_nxt = PILLAR_COLOR;

            else if( (pillar_2_bottom_start < pillar_2_bottom_end) && (hcount_in >= pillar_2_bottom_start ) && (hcount_in <= pillar_2_bottom_end) && (vcount_in >= 84) && (vcount_in <= 169) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_2_bottom_start >= pillar_2_bottom_end) && ((hcount_in >= pillar_2_bottom_start ) || (hcount_in <= pillar_2_bottom_end)) && (vcount_in >= 84) && (vcount_in <= 169) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_2_top_start < pillar_2_top_end) && (hcount_in >= pillar_2_top_start ) && (hcount_in <= pillar_2_top_end) && (vcount_in >= 0) && (vcount_in <= 83) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_2_top_start >= pillar_2_top_end) && ((hcount_in >= pillar_2_top_start ) || (hcount_in <= pillar_2_top_end)) && (vcount_in >= 0) && (vcount_in <= 83) )
                rgb_out_nxt = PILLAR_COLOR;

            else if( (pillar_3_bottom_start < pillar_3_bottom_end) && (hcount_in >= pillar_3_bottom_start ) && (hcount_in <= pillar_3_bottom_end) && (vcount_in >= 84) && (vcount_in <= 169) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_3_bottom_start >= pillar_3_bottom_end) && ((hcount_in >= pillar_3_bottom_start ) || (hcount_in <= pillar_3_bottom_end)) && (vcount_in >= 84) && (vcount_in <= 169) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_3_top_start < pillar_3_top_end) && (hcount_in >= pillar_3_top_start ) && (hcount_in <= pillar_3_top_end) && (vcount_in >= 0) && (vcount_in <= 83) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_3_top_start >= pillar_3_top_end) && ((hcount_in >= pillar_3_top_start ) || (hcount_in <= pillar_3_top_end)) && (vcount_in >= 0) && (vcount_in <= 83) )
                rgb_out_nxt = PILLAR_COLOR;

            else if( (pillar_4_bottom_start < pillar_4_bottom_end) && (hcount_in >= pillar_4_bottom_start ) && (hcount_in <= pillar_4_bottom_end) && (vcount_in >= 84) && (vcount_in <= 169) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_4_bottom_start >= pillar_4_bottom_end) && ((hcount_in >= pillar_4_bottom_start ) || (hcount_in <= pillar_4_bottom_end)) && (vcount_in >= 84) && (vcount_in <= 169) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_4_top_start < pillar_4_top_end) && (hcount_in >= pillar_4_top_start ) && (hcount_in <= pillar_4_top_end) && (vcount_in >= 0) && (vcount_in <= 83) )
                rgb_out_nxt = PILLAR_COLOR;
            else if( (pillar_4_top_start >= pillar_4_top_end) && ((hcount_in >= pillar_4_top_start ) || (hcount_in <= pillar_4_top_end)) && (vcount_in >= 0) && (vcount_in <= 83) )
                rgb_out_nxt = PILLAR_COLOR;

            //Sky
            else if( (vcount_in>=0)&&(vcount_in<=169)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = SKY_COLOR;
            
            //Bound
            else if( (vcount_in>=170)&&(vcount_in<=176)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_SIDELINE_COLOR; 
            else if( (vcount_in>=176)&&(vcount_in<=182)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_COLOR;
            else if( (vcount_in>=182)&&(vcount_in<=188)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_SIDELINE_COLOR;
            else if( (vcount_in>=188)&&(vcount_in<=194)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_COLOR;
            else if( (vcount_in>=194)&&(vcount_in<=200)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_SIDELINE_COLOR;
            else if( (vcount_in>=200)&&(vcount_in<=206)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_COLOR;
            else if( (vcount_in>=206)&&(vcount_in<=212)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_SIDELINE_COLOR;
            else if( (vcount_in>=212)&&(vcount_in<=218)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_COLOR;
            else if( (vcount_in>=218)&&(vcount_in<=224)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_SIDELINE_COLOR;
            
            //Road
            else if( (vcount_in>=269)&&(vcount_in<=274)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_SIDELINE_COLOR;
            else if( (vcount_in>=275)&&(vcount_in<=414)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_COLOR;
            else if( (vcount_in>=415)&&(vcount_in<=420)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_MIDLINE_COLOR;
            else if( (vcount_in>=421)&&(vcount_in<=560)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_COLOR;
            else if( (vcount_in>=561)&&(vcount_in<=566)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_SIDELINE_COLOR;
            
            //Grass_up
            else rgb_out_nxt = GRASS_COLOR;        
        end
    end
    
endmodule
