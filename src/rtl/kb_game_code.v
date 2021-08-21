module kb_game_code #(
    parameter WIDTH = 4
)
(
    input wire clk,
    input wire reset,
    input wire key_pressed,
    input wire [7:0] key_code,
    output wire [ WIDTH - 1 : 0 ] kb_key_pressed
);

/////////////// TO TYLKO PRZYKLAD, POZMIENIAC KLAWISZE W POZNIEJSZEJ FAZIE ROZWOJU GRY //////////////////
    localparam  W_code      = 8'h1D,
                S_code      = 8'h1B,
                K_code      = 8'h42,
                Shift_code  = 8'h12,
                Enter_code  = 8'h5A;

    reg W_pressed, S_pressed, K_pressed, Shift_pressed, Enter_pressed;
    reg W_pressed_nxt, S_pressed_nxt, K_pressed_nxt, Shift_pressed_nxt, Enter_pressed_nxt;

    always @(posedge clk, posedge reset)
        if(reset) begin
            W_pressed <= 0;
            S_pressed <= 0;
            K_pressed <= 0;
            Shift_pressed <= 0;
            Enter_pressed <= 0;
        end
        else begin
            W_pressed <= W_pressed_nxt;
            S_pressed <= S_pressed_nxt;
            K_pressed <= K_pressed_nxt;
            Shift_pressed <= Shift_pressed_nxt;
            Enter_pressed <= Enter_pressed_nxt;
        end


    always @* begin
        W_pressed_nxt = W_pressed;
        S_pressed_nxt = S_pressed;
        K_pressed_nxt = K_pressed;
        Shift_pressed_nxt = Shift_pressed;
        Enter_pressed_nxt = Enter_pressed;
        case(key_code)
            W_code:
                W_pressed_nxt = (key_pressed)? 1:0;
            S_code:
                S_pressed_nxt = (key_pressed)? 1:0;
            K_code:
                K_pressed_nxt = (key_pressed)? 1:0;
            Shift_code:
                Shift_pressed_nxt = (key_pressed)? 1:0;
            Enter_code:
                Enter_pressed_nxt = (key_pressed)? 1:0;
        endcase
    end

    assign kb_key_pressed = {W_pressed,S_pressed,K_pressed,Shift_pressed,Enter_pressed};
endmodule