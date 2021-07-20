module vga_timing (
    output wire [10:0] vcount,
    output wire vsync,
    output wire vblnk,
    output wire [10:0] hcount,
    output wire hsync,
    output wire hblnk,
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
    
    reg [10:0] vcount_reg = 0, hcount_reg = 0;
    reg vsync_reg = 0, vblnk_reg = 0, hsync_reg = 0, hblnk_reg = 0;
    
    reg [10:0] vcount_nxt = 0, hcount_nxt = 0;
    reg vsync_nxt = 0, vblnk_nxt = 0, hsync_nxt = 0, hblnk_nxt = 0;
    
    always @(posedge clk) begin
        vcount_reg <= vcount_nxt;
        vsync_reg <= vsync_nxt;
        vblnk_reg <= vblnk_nxt;
        hcount_reg <= hcount_nxt;
        hsync_reg <= hsync_nxt;
        hblnk_reg <= hblnk_nxt;   
    end
    
    always @* begin
        if(hcount_reg == HOR_TOTAL_TIME - 1) begin
            hcount_nxt = 0;
            if(vcount_reg == VER_TOTAL_TIME - 1)
                vcount_nxt = 0;
            else
                vcount_nxt = vcount_reg + 1;
        end
        else begin
            hcount_nxt = hcount_reg + 1;
            vcount_nxt = vcount_reg;
        end 
        vsync_nxt = ((vcount_nxt >= VER_SYNC_START) && (vcount_nxt < VER_SYNC_START + VER_SYNC_TIME));
        vblnk_nxt = ((vcount_nxt >= VER_BLNK_START) && (vcount_nxt < VER_TOTAL_TIME));
        hsync_nxt = ((hcount_nxt >= HOR_SYNC_START) && (hcount_nxt < HOR_SYNC_START + HOR_SYNC_TIME));
        hblnk_nxt = ((hcount_nxt >= HOR_BLNK_START) && (hcount_nxt < HOR_TOTAL_TIME));
    end
    
    assign vcount = vcount_reg;
    assign vsync = vsync_reg; 
    assign vblnk = vblnk_reg;
    assign hcount = hcount_reg;
    assign hsync = hsync_reg;
    assign hblnk = hblnk_reg;

endmodule