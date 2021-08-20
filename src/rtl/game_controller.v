//WERSJA PROTOTYPOWA DO TESTUF :)
module game_controller(
    input wire reset,
    input wire clk,
    input wire enable_controller_status,
    input wire reset_status,
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
        position_nxt = (enable_controller_status)? position + keyboard_in:position;
        if(reset_status)
            position_nxt = 0;
    end

endmodule