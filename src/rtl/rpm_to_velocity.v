`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2021 05:26:39
// Design Name: 
// Module Name: rpm_to_velocity
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rpm_to_velocity(
    input wire clk100Hz,
    input wire rst,
    input wire [13:0] rpm,
    input wire [1:0] gear,
    input wire reset_status,
    output reg [6:0] d_position
    );
    
    localparam gear_ratio1 = 1;
    localparam gear_ratio2 = 2;
    localparam gear_ratio3 = 3;
    localparam gear_ratio4 = 5;
    
    reg [15:0] velocity;
    reg [6:0] d_position_nxt;
    
    always @(posedge clk100Hz) begin
        if(rst||reset_status) begin
            d_position <= 0;
        end
        else begin
            d_position <= d_position_nxt;
        end
    end
    
    always @* begin
        if(gear==0)  velocity = gear_ratio1 * rpm;
        else if(gear==1) velocity = gear_ratio2 * rpm;
        else if(gear==2) velocity = gear_ratio3 * rpm;
        else if(gear==3) velocity = gear_ratio4 * rpm;
        else begin 
            velocity = 0;
        end
        
        d_position_nxt = velocity[15:9];
    end
endmodule
