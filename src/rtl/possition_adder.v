//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Patryk Kocinski
// 
// Create Date:
// Design Name:
// Module Name: position_adder
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is position_adder module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module position_adder(
    input wire clk10Hz,
    input wire rst,
    input wire [4:0] d_position,
    input wire reset_status,
    output reg [31:0] position
    );
    
    reg [31:0] position_nxt = 0;
    
    always @(posedge clk10Hz) begin
        if(rst) begin
            position <= 0;
        end
        else begin
           position <= position_nxt; 
        end    
    end
    
    always @* begin
        position_nxt = position + d_position;
        if(reset_status)
            position_nxt = 0;
    end
endmodule
