//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik
// 
// Create Date:
// Design Name:
// Module Name: reset
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is reset module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module reset (
    output reg rst,
    input wire locked,
    input wire clk
    );

    localparam CLOCK_TICKS = 5;

    reg [4:0] counter, counter_nxt;

    always @(posedge clk)
        if(counter != CLOCK_TICKS)
            rst <= 1;
        else
            rst <= 0;

    always @(posedge clk, negedge locked)
        if(!locked)
            counter <= 0;
        else
            counter <= counter_nxt;

    always @*
        if(counter != CLOCK_TICKS)
            counter_nxt = counter + 1;
        else
            counter_nxt = counter;
endmodule