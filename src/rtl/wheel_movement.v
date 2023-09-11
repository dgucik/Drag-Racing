//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik
// 
// Create Date: 20.07.2021 21:23:01
// Design Name: -
// Module Name: wheel_movement
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is wheel_movement module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module wheel_movement(
    input wire clk,
    input wire reset,
    input wire [31:0] position,
    output wire mov
);

    reg [31:0] position_mem, position_mem_nxt;
    reg mov_reg, mov_nxt;

    always @(posedge clk)
        if(reset) begin
            position_mem <= 0;
            mov_reg <= mov_nxt;
        end
        else begin
            position_mem <= position_mem_nxt;
            mov_reg <= mov_nxt;
        end
    
    always @* begin
        position_mem_nxt = position;
        mov_nxt = (position_mem != position)? ~mov:mov;
    end

    assign mov = mov_reg;

endmodule