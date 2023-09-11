//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik
// 
// Create Date:
// Design Name:
// Module Name: flag_status
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is flag_status module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module flag_status(
    input wire clk,
    input wire reset,
    input wire clear,
    input wire set,
    output reg status
);
    
    reg status_nxt;

    always @(posedge clk)
        if(reset)
            status <= 0;
        else
            status <= status_nxt;
    
    always @* begin
        status_nxt = status;
        if(clear == 1)
            status_nxt = 0;
        else if(set == 1)
            status_nxt = 1;
    end     
endmodule