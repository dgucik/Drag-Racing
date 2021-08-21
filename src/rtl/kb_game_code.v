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
    localparam  W_code = 8'h1D,
                A_code = 8'h1C,
                S_code = 8'h1B,
                D_code = 8'h23;

    reg W_pressed, A_pressed, S_pressed, D_pressed;
    reg W_pressed_nxt, A_pressed_nxt, S_pressed_nxt, D_pressed_nxt;

    always @(posedge clk, posedge reset)
        if(reset) begin
            W_pressed <= 0;
            A_pressed <= 0;
            S_pressed <= 0;
            D_pressed <= 0;
        end
        else begin
            W_pressed <= W_pressed_nxt;
            A_pressed <= A_pressed_nxt;
            S_pressed <= S_pressed_nxt;
            D_pressed <= D_pressed_nxt;
        end


    always @* begin
        W_pressed_nxt = W_pressed;
        A_pressed_nxt = A_pressed;
        S_pressed_nxt = S_pressed;
        D_pressed_nxt = D_pressed;
        case(key_code)
            W_code:
                W_pressed_nxt = (key_pressed)? 1:0;
            A_code:
                A_pressed_nxt = (key_pressed)? 1:0;
            S_code:
                S_pressed_nxt = (key_pressed)? 1:0;
            D_code:
                D_pressed_nxt = (key_pressed)? 1:0;
        endcase
    end

    assign kb_key_pressed = {W_pressed,A_pressed,S_pressed,D_pressed};
endmodule