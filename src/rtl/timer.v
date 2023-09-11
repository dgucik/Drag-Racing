//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik
// 
// Create Date:
// Design Name:
// Module Name: timer
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is timer module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module timer(
    input wire clk1KHz,
    input wire reset,
    input wire restart,
    input wire start,
    output reg [11:0] seconds,
    output reg [9:0] miliseconds
);

    reg [11:0] seconds_nxt;
    reg [9:0] miliseconds_nxt;

    always @(posedge clk1KHz)
        if(reset) begin
            seconds <= 0;
            miliseconds <= 0;
        end
        else begin
            seconds <= seconds_nxt;
            miliseconds <= miliseconds_nxt;
        end

    always @* begin
        if(restart) begin
            seconds_nxt = 0;
            miliseconds_nxt = 0;
        end
        else if(start) begin
            seconds_nxt = (miliseconds == 999)? seconds + 1: seconds;
            miliseconds_nxt = (miliseconds == 999)? 0:miliseconds + 1;   
        end
        else begin
            seconds_nxt = seconds;
            miliseconds_nxt = miliseconds;
        end   
    end
endmodule