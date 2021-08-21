module draw_cockpit(
    input wire clk,
    input wire reset,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [11:0] rgb_in,
    input wire [1:0] current_gear,
    input wire gear_change_status,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out
);

    localparam  HOR_POS = 305,
                VER_POS = 636;

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
            if(     (current_gear == 0) && (
                    (hcount_in >= HOR_POS + 349) && (hcount_in <= HOR_POS + 360) && (vcount_in >= VER_POS + 36) && (vcount_in <= VER_POS + 95)
                    )        
                )
                rgb_out_nxt = 12'hbbb;
            else if(    (current_gear == 1) && (
                        (hcount_in >= HOR_POS + 313) && (hcount_in <= HOR_POS + 356) && (vcount_in >= VER_POS + 84) && (vcount_in <= VER_POS + 95) ||
                        (hcount_in >= HOR_POS + 313) && (hcount_in <= HOR_POS + 324) && (vcount_in >= VER_POS + 60) && (vcount_in <= VER_POS + 95) ||
                        (hcount_in >= HOR_POS + 313) && (hcount_in <= HOR_POS + 360) && (vcount_in >= VER_POS + 60) && (vcount_in <= VER_POS + 71) ||
                        (hcount_in >= HOR_POS + 349) && (hcount_in <= HOR_POS + 360) && (vcount_in >= VER_POS + 36) && (vcount_in <= VER_POS + 71) ||
                        (hcount_in >= HOR_POS + 313) && (hcount_in <= HOR_POS + 360) && (vcount_in >= VER_POS + 36) && (vcount_in <= VER_POS + 47)
                        )        
                )
                rgb_out_nxt = 12'hbbb;
            else if(    (current_gear == 2) && (
                        (hcount_in >= HOR_POS + 313) && (hcount_in <= HOR_POS + 360) && (vcount_in >= VER_POS + 84) && (vcount_in <= VER_POS + 95) ||
                        (hcount_in >= HOR_POS + 349) && (hcount_in <= HOR_POS + 360) && (vcount_in >= VER_POS + 36) && (vcount_in <= VER_POS + 95) ||
                        (hcount_in >= HOR_POS + 313) && (hcount_in <= HOR_POS + 360) && (vcount_in >= VER_POS + 60) && (vcount_in <= VER_POS + 71) ||
                        (hcount_in >= HOR_POS + 313) && (hcount_in <= HOR_POS + 360) && (vcount_in >= VER_POS + 36) && (vcount_in <= VER_POS + 47)
                        )        
                )
                rgb_out_nxt = 12'hbbb;
            else if(    (current_gear == 3) && (
                        (hcount_in >= HOR_POS + 349) && (hcount_in <= HOR_POS + 360) && (vcount_in >= VER_POS + 36) && (vcount_in <= VER_POS + 95) ||
                        (hcount_in >= HOR_POS + 313) && (hcount_in <= HOR_POS + 348) && (vcount_in >= VER_POS + 60) && (vcount_in <= VER_POS + 71) ||
                        (hcount_in >= HOR_POS + 313) && (hcount_in <= HOR_POS + 324) && (vcount_in >= VER_POS + 36) && (vcount_in <= VER_POS + 59)
                        )        
                )
                rgb_out_nxt = 12'hbbb;
            else if(    (hcount_in >= HOR_POS + 61) && (hcount_in <= HOR_POS + 104) && (vcount_in >= VER_POS + 56) && (vcount_in <= VER_POS + 75) ||
                        (hcount_in >= HOR_POS + 73) && (hcount_in <= HOR_POS + 92) && (vcount_in >= VER_POS + 44) && (vcount_in <= VER_POS + 87) ||
                        (hcount_in >= HOR_POS + 65) && (hcount_in <= HOR_POS + 100) && (vcount_in >= VER_POS + 48) && (vcount_in <= VER_POS + 83)
                )
                rgb_out_nxt = (gear_change_status)? 12'h0c5: 12'ha00;
            else if(    (hcount_in >= HOR_POS + 57) && (hcount_in <= HOR_POS + 108) && (vcount_in >= VER_POS + 56) && (vcount_in <= VER_POS + 75) ||
                        (hcount_in >= HOR_POS + 73) && (hcount_in <= HOR_POS + 92) && (vcount_in >= VER_POS + 40) && (vcount_in <= VER_POS + 91) ||
                        (hcount_in >= HOR_POS + 65) && (hcount_in <= HOR_POS + 100) && (vcount_in >= VER_POS + 44) && (vcount_in <= VER_POS + 87) ||
                        (hcount_in >= HOR_POS + 61) && (hcount_in <= HOR_POS + 104) && (vcount_in >= VER_POS + 48) && (vcount_in <= VER_POS + 83)
                )
                rgb_out_nxt = 12'hbbc;
            else if( (hcount_in >= HOR_POS + 5) && (hcount_in <= HOR_POS + 408) && (vcount_in >= VER_POS + 5) && (vcount_in <= VER_POS + 126) )
                rgb_out_nxt = 12'h222;
            else if( (hcount_in >= HOR_POS) && (hcount_in <= HOR_POS + 413) && (vcount_in >= VER_POS) && (vcount_in <= VER_POS + 131) )
                rgb_out_nxt = 12'h466;
            else rgb_out_nxt = rgb_in;
        end      
    end

endmodule