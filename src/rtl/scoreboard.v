module scoreboard (
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out,
    output wire [14:0] pixel_addr,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [11:0] rgb_in,
    input wire [1:0] pixel,
    input wire clk,
    input wire rst
    );

    localparam  RESULT_TEXT_HOR_POS = 50,
                RESULT_TEXT_VER_POS = 50;

    wire [8:0] addrx; 
    wire [5:0] addry;

    reg [10:0] hcount_delay, vcount_delay;
    reg hsync_delay, hblnk_delay, vsync_delay, vblnk_delay;
    reg [11:0] rgb_delay;

    always @(posedge clk) begin
        if(rst) begin
            hcount_out <= 0;
            hsync_out <= 0;
            hblnk_out <= 0;
            vcount_out <= 0;
            vsync_out <= 0;
            vblnk_out <= 0;
        end
        else begin
            hcount_out <= hcount_delay;
            hsync_out <= hsync_delay;
            hblnk_out <= hblnk_delay;
            vcount_out <= vcount_delay;
            vsync_out <= vsync_delay;
            vblnk_out <= vblnk_delay;
        end
    end

    always @(posedge clk) begin
        if(rst) begin
            hcount_delay <= 0;
            hsync_delay <= 0;
            hblnk_delay <= 0;
            vcount_delay <= 0;
            vsync_delay <= 0;
            vblnk_delay <= 0;
        end
        else begin
            hcount_delay <= hcount_in;
            hsync_delay <= hsync_in;
            hblnk_delay <= hblnk_in;
            vcount_delay <= vcount_in;
            vsync_delay <= vsync_in;
            vblnk_delay <= vblnk_in;
        end
    end

    always @(posedge clk) begin
        if(rst)
            rgb_out <= 0;
        else begin
            if (vblnk_delay || hblnk_delay) rgb_out <= 12'h0_0_0;
            else if ((hcount_in > RESULT_TEXT_HOR_POS) && (hcount_in <= RESULT_TEXT_HOR_POS + 512) && (vcount_in >= RESULT_TEXT_VER_POS) && (vcount_in < RESULT_TEXT_VER_POS + 43) && (pixel[1] == 1)) rgb_out <= 12'hfd0;
            else rgb_out <= rgb_delay;
        end
    end

    always @(posedge clk)
        if(rst)
            rgb_delay <= 0;
        else
            rgb_delay <= rgb_in;

    assign addrx = hcount_in - RESULT_TEXT_HOR_POS;
    assign addry = vcount_in - RESULT_TEXT_VER_POS;
    assign pixel_addr = {addry[5:0], addrx[8:0]};
endmodule