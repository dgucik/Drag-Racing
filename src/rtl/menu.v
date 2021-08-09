`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2021 23:28:51
// Design Name: 
// Module Name: menu
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


module menu(
    output reg [10:0] hcount_out,
    output reg [10:0] vcount_out,
    output reg hsync_out,
    output reg vsync_out,
    output reg hblnk_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out,
    
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire vsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    input wire clk,
    input wire rst
    );
    
    reg [11:0] rgb_out_nxt;
    reg [10:0] hcount_out_nxt, vcount_out_nxt;
    reg hsync_out_nxt, hblnk_out_nxt, vsync_out_nxt, vblnk_out_nxt;

//----colors_for_menu-------------------------------------------------   
    localparam SKY_COLOR = 12'h5_c_f;           //blue
    localparam GRASS_COLOR = 12'h4_9_4;         //green
    localparam ROAD_COLOR = 12'h9_a_b;          //gray
    localparam ROAD_MIDLINE_COLOR = 12'hf_f_4;  //yellow
    //localparam ROAD_SIDELINE_COLOR = 12'h4_6_6; //dark_gray
    localparam MENU_SQUARE_COLOR = 12'hf_5_2;   //orange
 
//----main_menu_rect--------------------------------------------------
    localparam MENU_RECT_X = 11;
    localparam MENU_RECT_Y = 12;
    localparam MENU_RECT_HIGH = 256;
    localparam MENU_RECT_WIDTH = 200;
    
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
            //Sky
            //if( (vcount_in>=0)&&(vcount_in<=629)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = SKY_COLOR;
            if( (vcount_in>=0)&&(vcount_in<=MENU_RECT_Y-1)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = SKY_COLOR;
            else if( (vcount_in>=MENU_RECT_Y)&&(vcount_in<=MENU_RECT_Y+MENU_RECT_HIGH-1)&&( ((hcount_in>=0)&&(hcount_in<=MENU_RECT_X-1)||(hcount_in>=MENU_RECT_X+MENU_RECT_WIDTH)&&(hcount_in<=1023)) ) ) rgb_out_nxt = SKY_COLOR;
            else if( (vcount_in>=MENU_RECT_Y+MENU_RECT_HIGH)&&(vcount_in<=629)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = SKY_COLOR;
            //Grass
            else if( ((vcount_in>=630&&vcount_in<=646)||(vcount_in>=715&&vcount_in<=762))&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = GRASS_COLOR; 
            
            //Road
            else if( (vcount_in>=647)&&(vcount_in<=714)&&(hcount_in>=0)&&(hcount_in<=1023) ) rgb_out_nxt = ROAD_COLOR; 
            
            //MainMenu_Rect
            else if( (vcount_in>=MENU_RECT_Y)&&(vcount_in<=MENU_RECT_Y+MENU_RECT_HIGH-1)&&(hcount_in>=MENU_RECT_X)&&(hcount_in<=MENU_RECT_X+MENU_RECT_WIDTH-1) ) rgb_out_nxt = MENU_SQUARE_COLOR;
            
            else rgb_out_nxt = 12'h0_0_0;        
        end
    end
    
endmodule
