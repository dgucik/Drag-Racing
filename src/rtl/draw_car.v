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
    output reg [10:0] car_hcount_out,
    output reg car_hsync_out,
    output reg car_hblnk_out,
    output reg [10:0] car_vcount_out,
    output reg car_vsync_out,
    output reg car_vblnk_out,
    output reg [11:0] car_rgb_out
);
    //car 328px na 91 px
    localparam  RGB_1 = 12'hF8A,
                RGB_2 = 12'hF54,
                RGB_3 = 12'hD10;

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
                if (car_vcount_in == 0) rgb_out_nxt = 12'hf_f_0;
                else if (car_vcount_in == 767) rgb_out_nxt = 12'hf_0_0;
                else if (car_hcount_in == 0) rgb_out_nxt = 12'h0_f_0;
                else if (car_hcount_in == 1023) rgb_out_nxt = 12'h0_0_f;

                //---------------------------------------------------------------------------------
                else if(    (car_hcount_in >= car_xpos) && (car_hcount_in <= car_xpos + 5) && (car_vcount_in >= car_ypos) && (car_vcount_in <= car_ypos + 2) ||
                            (car_hcount_in >= car_xpos + 3) && (car_hcount_in <= car_xpos + 47) && (car_vcount_in >= car_ypos - 3) && (car_vcount_in <= car_ypos - 1) ||
                            (car_hcount_in >= car_xpos + 28) && (car_hcount_in <= car_xpos + 47) && (car_vcount_in >= car_ypos - 7) && (car_vcount_in <= car_ypos - 4) ||
                            (car_hcount_in >= car_xpos + 48) && (car_hcount_in <= car_xpos + 57) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 8) || 
                            (car_hcount_in >= car_xpos + 58) && (car_hcount_in <= car_xpos + 68) && (car_vcount_in >= car_ypos - 14) && (car_vcount_in <= car_ypos - 11) ||
                            (car_hcount_in >= car_xpos + 69) && (car_hcount_in <= car_xpos + 75) && (car_vcount_in >= car_ypos - 17) && (car_vcount_in <= car_ypos - 15) ||
                            (car_hcount_in >= car_xpos + 76) && (car_hcount_in <= car_xpos + 85) && (car_vcount_in >= car_ypos - 20) && (car_vcount_in <= car_ypos - 18) ||
                            (car_hcount_in >= car_xpos + 86) && (car_hcount_in <= car_xpos + 96) && (car_vcount_in >= car_ypos - 24) && (car_vcount_in <= car_ypos - 21) ||
                            (car_hcount_in >= car_xpos + 97) && (car_hcount_in <= car_xpos + 103) && (car_vcount_in >= car_ypos - 27) && (car_vcount_in <= car_ypos - 25) ||
                            (car_hcount_in >= car_xpos + 104) && (car_hcount_in <= car_xpos + 188) && (car_vcount_in >= car_ypos - 31) && (car_vcount_in <= car_ypos - 28) ||
                            (car_hcount_in >= car_xpos + 189) && (car_hcount_in <= car_xpos + 198) && (car_vcount_in >= car_ypos - 29) && (car_vcount_in <= car_ypos - 27) ||
                            (car_hcount_in >= car_xpos + 198) && (car_hcount_in <= car_xpos + 199) && (car_vcount_in >= car_ypos - 26) && (car_vcount_in <= car_ypos - 26) ||
                            (car_hcount_in >= car_xpos + 217) && (car_hcount_in <= car_xpos + 261) && (car_vcount_in >= car_ypos - 10) && (car_vcount_in <= car_ypos - 5) ||
                            (car_hcount_in >= car_xpos + 262) && (car_hcount_in <= car_xpos + 282) && (car_vcount_in >= car_ypos - 7) && (car_vcount_in <= car_ypos - 5) ||
                            (car_hcount_in >= car_xpos + 283) && (car_hcount_in <= car_xpos + 299) && (car_vcount_in >= car_ypos - 3) && (car_vcount_in <= car_ypos - 2) ||
                            (car_hcount_in >= car_xpos + 297) && (car_hcount_in <= car_xpos + 299) && (car_vcount_in >= car_ypos - 1) && (car_vcount_in <= car_ypos + 2) ||
                            (car_hcount_in >= car_xpos + 300) && (car_hcount_in <= car_xpos + 309) && (car_vcount_in >= car_ypos) && (car_vcount_in <= car_ypos + 2) || 
                            (car_hcount_in >= car_xpos + 307) && (car_hcount_in <= car_xpos + 309) && (car_vcount_in >= car_ypos + 3)  && (car_vcount_in <= car_ypos + 5) || //lgtm
                            (car_hcount_in >= car_xpos + 310) && (car_hcount_in <= car_xpos + 313) && (car_vcount_in >= car_ypos + 4)  && (car_vcount_in <= car_ypos + 6) ||
                            (car_hcount_in >= car_xpos + 311) && (car_hcount_in <= car_xpos + 317) && (car_vcount_in >= car_ypos + 7)  && (car_vcount_in <= car_ypos + 9) ||
                            (car_hcount_in >= car_xpos) && (car_hcount_in <= car_xpos + 2) && (car_vcount_in >= car_ypos + 3)  && (car_vcount_in <= car_ypos + 13)
                )
                rgb_out_nxt = RGB_2;

                //---------------------------------------------------------------------------------

                else rgb_out_nxt = car_rgb_in;
            end
        end
endmodule