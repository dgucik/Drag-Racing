`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2021 11:27:50
// Design Name: 
// Module Name: draw_background
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module draw_background(
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input hsync_in,
    input vsync_in,
    input hblnk_in,
    input vblnk_in,
    input clk,
    input rst,
    
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
    
    localparam RECT_HIGH = 530;
    localparam RECT_WIDTH = 540;
    localparam RECT_X = 545;
    localparam RECT_Y = 26;
    localparam GRASS_Y = 630;
//------------------------------------------------------------------------------- 
    reg [11:0] rgb_out_nxt;
    
    localparam IN_MENU = 0;
    localparam IN_GAME = 1;
    
    always @(posedge clk) begin
        if(rst) begin
            hcount_out <= 0;
            vcount_out <= 0;
            hblnk_out <= 0;
            vblnk_out <= 0;
            hsync_out <= 0;
            vsync_out <= 0;
            rgb_out <= 0;
        end 
        else begin
            hcount_out <= hcount_in;
            vcount_out <= vcount_in;
            hblnk_out <= hblnk_in;
            vblnk_out <= vblnk_in;
            hsync_out <= hsync_in;
            vsync_out <= vsync_in;
            rgb_out <= rgb_out_nxt;
        end
    end
    
    always @* begin
        // During blanking, make it it black.
        if(hblnk_in||vblnk_in) rgb_out_nxt <= 12'h0_0_0;
        else begin

            //Sky
            if( (vcount_in>=0)&&(vcount_in<=169)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= SKY_COLOR;
            
            //Bound
            else if( (vcount_in>=170)&&(vcount_in<=176)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_SIDELINE_COLOR; 
            else if( (vcount_in>=176)&&(vcount_in<=182)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_COLOR;
            else if( (vcount_in>=182)&&(vcount_in<=188)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_SIDELINE_COLOR;
            else if( (vcount_in>=188)&&(vcount_in<=194)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_COLOR;
            else if( (vcount_in>=194)&&(vcount_in<=200)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_SIDELINE_COLOR;
            else if( (vcount_in>=200)&&(vcount_in<=206)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_COLOR;
            else if( (vcount_in>=206)&&(vcount_in<=212)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_SIDELINE_COLOR;
            else if( (vcount_in>=212)&&(vcount_in<=218)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_COLOR;
            else if( (vcount_in>=218)&&(vcount_in<=224)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_SIDELINE_COLOR;
            
            //Grass_up
            else if( (vcount_in>=225)&&(vcount_in<=268)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= GRASS_COLOR;
            
            
            //Road
            else if( (vcount_in>=269)&&(vcount_in<=274)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_SIDELINE_COLOR;
            else if( (vcount_in>=275)&&(vcount_in<=454)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_COLOR;
            else if( (vcount_in>=455)&&(vcount_in<=460)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_MIDLINE_COLOR;
            else if( (vcount_in>=461)&&(vcount_in<=641)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_COLOR;
            else if( (vcount_in>=642)&&(vcount_in<=646)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt <= ROAD_SIDELINE_COLOR;
            //Grass_down
            else if( (vcount_in>=647)&&(vcount_in<=767)&&( (hcount_in>=0&&hcount_in<=310)||(hcount_in>=712&&hcount_in<=1023) ) ) rgb_out_nxt <= GRASS_COLOR;
            
            //Cockpit
            //else if( (vcount_in>=647)&&(vcount_in<=767)&&(hcount_in==461||hcount_in==561) ) rgb_out_nxt <= ROAD_SIDELINE_COLOR;
            else if( (vcount_in>=647)&&(vcount_in<=767)&&( hcount_in>311||hcount_in<711 ) ) rgb_out_nxt <= 12'h1_1_1;
            else rgb_out_nxt <= ROAD_SIDELINE_COLOR;
            
        end
    end
    
endmodule
