module player2_position(
    input wire clk,
    input wire rst,
    input wire reset_status,
    input wire [4:0] d_position,
    output wire [31:0] position
    );
    
    wire clk100Hz;
    
    clk_divide #(.DIVISOR(1000000)) u_timer_100Hz(
        .clk_in(clk),
        .clk_out(clk100Hz)
    );
    
    position_adder u_position_adder(
        .clk10Hz(clk100Hz),
        .rst(rst),
        .reset_status(reset_status),
        .d_position(d_position),
        .position(position)
    );      
endmodule
