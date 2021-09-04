`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2021 21:05:47
// Design Name: 
// Module Name: delay_for_xypointer
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


module delay_for_xypointer(
    input wire clk,
    input wire rst,
    input wire [10:0] x_pointer,
    input wire [10:0] y_pointer,
    output reg [10:0] x_pointer_out_d,
    output reg [10:0] y_pointer_out_d
    );
    
    reg [10:0] x_pointer_d, y_pointer_d;
    
    always @(posedge clk) begin
        if(rst) begin
            x_pointer_d <= 0;
            y_pointer_d <= 0;
            x_pointer_out_d <= 0;
            y_pointer_out_d <= 0; 
        end
        else begin
            x_pointer_d <= x_pointer;
            y_pointer_d <= y_pointer;
            
            x_pointer_out_d <= x_pointer_d;
            y_pointer_out_d <= y_pointer_d;
        end
    end 
endmodule
