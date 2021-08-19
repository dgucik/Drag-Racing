//WERSJA PROTOTYPOWA DO TESTUF :)
module game_controller(
    input wire reset,
    input wire clk,
    input wire enable_controller_status,
    input wire keyboard_in,
    output reg [31:0] position
);

    reg [31:0] position_nxt;

    always @(posedge clk)
        if(reset)
            position <= 0;
        else
            position <= position_nxt;

    always @* begin
        position_nxt = position + keyboard_in;
    end

endmodule