//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Patryk Kocinski
// 
// Create Date:
// Design Name:
// Module Name: player2_position
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is player2_position module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

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
