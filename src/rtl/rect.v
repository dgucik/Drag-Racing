`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2021 18:38:27
// Design Name: 
// Module Name: rect
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


module rect(
    input wire clk,
    input wire rst,
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire vsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    input wire [11:0] rgb_in,
    input wire [10:0] x_pointer,
    input wire [10:0] y_pointer,
    output reg [10:0] hcount_out,
    output reg [10:0] vcount_out,
    output reg hsync_out,
    output reg vsync_out,
    output reg hblnk_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out
    );
    
    localparam RECT_HIGH = 13, RECT_LONG = 10, RECT_COLOR = 12'hd_f_0;
    
    reg [10:0] hcount_nxt, vcount_nxt;
    reg hsync_nxt, vsync_nxt, hblnk_nxt, vblnk_nxt;
    reg [11:0] rgb_out_nxt;
    
    reg [10:0] xpos, ypos, xpos_nxt, ypos_nxt;
    
    always@(posedge clk) begin
        if(rst) begin
            hsync_out <= 0;
            vsync_out <= 0;
            hblnk_out <= 0;
            vblnk_out <= 0;
            hcount_out <= 0;
            vcount_out <= 0;
            rgb_out <= 0;
        end
        else begin
            hsync_out <= hsync_in;
            vsync_out <= vsync_in;
            hblnk_out <= hblnk_in;
            vblnk_out <= vblnk_in;
            hcount_out <= hcount_in;
            vcount_out <= vcount_in;
            rgb_out <= rgb_out_nxt;
        end
    end
    
    always@* begin  
        if(vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0;   //paint black
        else begin
            if(~vblnk_in & ~hblnk_in) begin     //in drawing area
                //if((vcount_in <= ypos + RECT_HIGH) && (vcount_in >= ypos) && (hcount_in <= xpos + RECT_LONG) && (hcount_in >= xpos))
                if((vcount_in <= y_pointer + RECT_HIGH) && (vcount_in >= y_pointer) && (hcount_in <= x_pointer + RECT_LONG) && (hcount_in >= x_pointer))
                    rgb_out_nxt = RECT_COLOR;
                else
                    //rgb_out_nxt = 12'h0_0_0;
                    rgb_out_nxt = rgb_in;                 
            end else
                rgb_out_nxt = 12'b0_0_0;
        end
    end

endmodule
