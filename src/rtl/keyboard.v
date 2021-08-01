module keyboard (
    input wire clk, 
    input wire reset,
    input wire ps2_clk,
    input wire ps2_data,
    output reg code_new,
    output reg key_pressed,
    output reg [7:0] key_code
    );

    localparam  WAIT_CODE   = 2'b00,
                BRK_CODE    = 2'b01,
                MAKE_CODE   = 2'b10;    
                

    reg [1:0] state, state_nxt;
    wire scan_done_tick;
    wire [7:0] scan_out;

    reg [7:0] key_code_nxt;
    reg code_new_nxt, key_pressed_nxt;

    ps2_rx u_ps2_rx (
      .clk(clk),
      .reset(reset),
      .rx_en(1'b1),
      .ps2c(ps2_clk),
      .ps2d(ps2_data),
      .rx_done_tick(scan_done_tick),
      .dout(scan_out)
    );

    always @(posedge clk, posedge reset)
        if(reset) begin
            code_new <= 0;
            key_pressed <= 0;
            key_code <= 0;
        end
        else begin
            code_new <= code_new_nxt;
            key_pressed <= key_pressed_nxt;
            key_code <= key_code_nxt;
        end

    always @(posedge clk, posedge reset)
        if(reset)
            state <= WAIT_CODE;
        else
            state <= state_nxt;

    always @* begin
        code_new_nxt = 0;      
        key_pressed_nxt = key_pressed;
        key_code_nxt = key_code;
        state_nxt = state;
        case(state)
            WAIT_CODE:
                if((scan_done_tick == 1'b1) && (scan_out == 8'hF0))
                    state_nxt = BRK_CODE;
                else if(scan_done_tick == 1'b1)
                    state_nxt = MAKE_CODE;
            BRK_CODE:
                if(scan_done_tick == 1'b1) begin
                    code_new_nxt = 0;
                    key_pressed_nxt = 0;
                    key_code_nxt = scan_out;
                    state_nxt = WAIT_CODE;  
                end 
            MAKE_CODE: begin
                code_new_nxt = 1;
                key_pressed_nxt = 1;
                key_code_nxt = scan_out;
                state_nxt = WAIT_CODE;
            end          
        endcase
    end

endmodule