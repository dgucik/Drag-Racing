//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik
// 
// Create Date: 20.07.2021 21:23:01
// Design Name: -
// Module Name: vga_timing
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is vga_timing module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module vga_timing (
    output wire [10:0] vga_vcount,
    output wire vga_vsync,
    output wire vga_vblnk,
    output wire [10:0] vga_hcount,
    output wire vga_hsync,
    output wire vga_hblnk,
    input wire clk
    );
    
    localparam  HOR_TOTAL_TIME = 1344,
                HOR_BLNK_START = 1024,
                HOR_SYNC_START = 1048,
                HOR_SYNC_TIME = 136;
    
    localparam  VER_TOTAL_TIME = 806,
                VER_BLNK_START = 768,
                VER_SYNC_START = 771,
                VER_SYNC_TIME = 6;
    
    reg [10:0] vga_vcount_reg = 0, vga_hcount_reg = 0;
    reg vga_vsync_reg = 0, vga_vblnk_reg = 0, vga_hsync_reg = 0, vga_hblnk_reg = 0;
    
    reg [10:0] vga_vcount_nxt = 0, vga_hcount_nxt = 0;
    reg vga_vsync_nxt = 0, vga_vblnk_nxt = 0, vga_hsync_nxt = 0, vga_hblnk_nxt = 0;
    
    always @(posedge clk) begin
        vga_vcount_reg <= vga_vcount_nxt;
        vga_vsync_reg <= vga_vsync_nxt;
        vga_vblnk_reg <= vga_vblnk_nxt;
        vga_hcount_reg <= vga_hcount_nxt;
        vga_hsync_reg <= vga_hsync_nxt;
        vga_hblnk_reg <= vga_hblnk_nxt;   
    end
    
    always @* begin
        if(vga_hcount_reg == HOR_TOTAL_TIME - 1) begin
            vga_hcount_nxt = 0;
            if(vga_vcount_reg == VER_TOTAL_TIME - 1)
                vga_vcount_nxt = 0;
            else
                vga_vcount_nxt = vga_vcount_reg + 1;
        end
        else begin
            vga_hcount_nxt = vga_hcount_reg + 1;
            vga_vcount_nxt = vga_vcount_reg;
        end 
        vga_vsync_nxt = ((vga_vcount_nxt >= VER_SYNC_START) && (vga_vcount_nxt < VER_SYNC_START + VER_SYNC_TIME));
        vga_vblnk_nxt = ((vga_vcount_nxt >= VER_BLNK_START) && (vga_vcount_nxt < VER_TOTAL_TIME));
        vga_hsync_nxt = ((vga_hcount_nxt >= HOR_SYNC_START) && (vga_hcount_nxt < HOR_SYNC_START + HOR_SYNC_TIME));
        vga_hblnk_nxt = ((vga_hcount_nxt >= HOR_BLNK_START) && (vga_hcount_nxt < HOR_TOTAL_TIME));
    end
    
    assign vga_vcount = vga_vcount_reg;
    assign vga_vsync = vga_vsync_reg; 
    assign vga_vblnk = vga_vblnk_reg;
    assign vga_hcount = vga_hcount_reg;
    assign vga_hsync = vga_hsync_reg;
    assign vga_hblnk = vga_hblnk_reg;
endmodule