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
    //input wire [11:0] car_velocity, //hmm?
    output reg [10:0] car_hcount_out,
    output reg car_hsync_out,
    output reg car_hblnk_out,
    output reg [10:0] car_vcount_out,
    output reg car_vsync_out,
    output reg car_vblnk_out,
    output reg [11:0] car_rgb_out,
);
    localparam  WIDTH_CAR_M     = 512,
                HEIGHT_CAR_M    = 158;

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
                if (vcount_delayed == 0) rgb_out_nxt = 12'hf_f_0;
                else if (vcount_delayed == 767) rgb_out_nxt = 12'hf_0_0;
                else if (hcount_delayed == 0) rgb_out_nxt = 12'h0_f_0;
                else if (hcount_delayed == 1023) rgb_out_nxt = 12'h0_0_f;
                else rgb_out_nxt = car_rgb_in;
            end
        end
endmodule