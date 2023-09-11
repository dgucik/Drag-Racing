//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik
// 
// Create Date:
// Design Name:
// Module Name: clk_divide
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is clk_divide module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module clk_divide
    #(
        parameter DIVISOR = 1000000
    )
    (
    output reg clk_out,
    input wire clk_in
    );

    reg [$clog2(DIVISOR) + 1:0] counter = 0;

    always @(posedge clk_in) begin
        clk_out <= (counter < DIVISOR/2) ? 1 : 0;
        if(counter == (DIVISOR-1))
            counter <= 0;
        else
            counter <= counter + 1;
    end
endmodule