//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik
// 
// Create Date:
// Design Name:
// Module Name: rising_edge_detector
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is rising_edge_detector module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module rising_edge_detector #(
    parameter WIDTH = 2
)
(
    input wire clk,
    input wire [ WIDTH - 1 : 0 ] sig_in,
    output wire [ WIDTH - 1 : 0 ] sig_out
);

    reg [ WIDTH - 1: 0 ] sig_d, sig_d_nxt;

    always @(posedge clk)
        sig_d <= sig_d_nxt;

    always @*
        sig_d_nxt = sig_in;

    assign sig_out = sig_in & ~sig_d;
endmodule