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
    input wire [11:0] car_rgb_pixel,
    //input wire [11:0] car_velocity, //hmm?
    output reg [10:0] car_hcount_out,
    output reg car_hsync_out,
    output reg car_hblnk_out,
    output reg [10:0] car_vcount_out,
    output reg car_vsync_out,
    output reg car_vblnk_out,
    output reg [11:0] car_rgb_out,
    output wire [16:0] pixel_addr
);
    localparam  WIDTH_CAR_M     = 512,
                HEIGHT_CAR_M    = 158;

    reg [11:0] rgb_out_nxt;
    reg [10:0] hcount_out_nxt, vcount_out_nxt;
    reg hsync_out_nxt, hblnk_out_nxt, vsync_out_nxt, vblnk_out_nxt;

    wire [11:0] rgb_delayed;
    wire [10:0] hcount_delayed, vcount_delayed;
    wire hsync_delayed, hblnk_delayed, vsync_delayed, vblnk_delayed;
    wire [11:0] xpos_delayed, ypos_delayed;

    wire [8:0] addrx;
    wire [7:0] addry;

    delay #(.WIDTH(62)) u_delay(
        .clk(clk),
        .rst(reset),
        .din({car_hcount_in[10:0], car_hsync_in, car_hblnk_in, car_vcount_in[10:0], car_vsync_in, car_vblnk_in, car_rgb_in[11:0], car_xpos[11:0], car_ypos[11:0]}),
        .dout({hcount_delayed[10:0], hsync_delayed, hblnk_delayed, vcount_delayed[10:0], vsync_delayed, vblnk_delayed, rgb_delayed[11:0], xpos_delayed[11:0], ypos_delayed[11:0]})
    );

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
            hcount_out_nxt = hcount_delayed; 
            hsync_out_nxt = hsync_delayed;
            hblnk_out_nxt = hblnk_delayed;
            vcount_out_nxt = vcount_delayed;
            vsync_out_nxt = vsync_delayed;
            vblnk_out_nxt = vblnk_delayed;
            if(hblnk_delayed || vblnk_delayed) rgb_out_nxt = 12'h0_0_0;
            else begin
                if (vcount_delayed == 0) rgb_out_nxt = 12'hf_f_0;
                else if (vcount_delayed == 767) rgb_out_nxt = 12'hf_0_0;
                else if (hcount_delayed == 0) rgb_out_nxt = 12'h0_f_0;
                else if (hcount_delayed == 1023) rgb_out_nxt = 12'h0_0_f;
                else if( (hcount_delayed > xpos_delayed) && (hcount_delayed <= xpos_delayed + WIDTH_CAR_M) && (vcount_delayed >= ypos_delayed) && (vcount_delayed < ypos_delayed + HEIGHT_CAR_M) && (car_rgb_pixel != 12'hF_F_F) ) 
                    rgb_out_nxt = car_rgb_pixel;
                else rgb_out_nxt = rgb_delayed;
            end
        end

        assign addrx = car_hcount_in - car_xpos;
        assign addry = car_vcount_in - car_ypos;
        assign pixel_addr = {addry[7:0], addrx[8:0]};
endmodule