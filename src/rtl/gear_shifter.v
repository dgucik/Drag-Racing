//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Patryk Kocinski
// 
// Create Date:
// Design Name:
// Module Name: gear_shifter
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is gear_shifter module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module gear_shifter(
    input wire clk,
    input wire rst,
    input wire reset_status,
    input wire keyboard_in_posedge,
    output reg [1:0] gear
    );
    
    reg [1:0] gear_nxt = 0;
    
    always @(posedge clk) begin
        if(rst) begin
            gear <= 0;
        end
        else begin
            gear <= gear_nxt;
        end    
    end
    
    always @* begin
        if(reset_status)
            gear_nxt = 0;
        else begin
            if( (keyboard_in_posedge) && (gear<3) ) gear_nxt = gear+1;
            else gear_nxt = gear;
        end
    end
endmodule
