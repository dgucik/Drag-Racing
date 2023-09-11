//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Patryk Kocinski
// 
// Create Date:
// Design Name:
// Module Name: mux2to1
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is mux2to1 module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module mux2to1(
    input wire D0,
    input wire D1,
    input wire D2,
    input wire S,
    output reg Y1,
    output reg Y2
    );
    
    always @* begin
        if(S) begin
            Y1 = D1;
            Y2 = D2;
        end
        else begin
            Y1 = D0;
            Y2 = D0;
        end
    end  
endmodule
