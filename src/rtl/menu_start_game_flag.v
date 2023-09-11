//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Patryk Kocinski
// 
// Create Date:
// Design Name:
// Module Name: menu_start_game_flag
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is menu_start_game_flag module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module menu_start_game_flag(
    input wire clk,
    input wire rst,
    input wire [2:0] menu_state,
    output reg start_game
    );
    
    reg start_game_nxt;
    
    always @(posedge clk) begin
        if(rst) begin 
            start_game <= 0;
        end 
        else begin
            start_game <= start_game_nxt;
        end
    end
    
    always @* begin
        if(menu_state == 1) start_game_nxt = 1;
        else start_game_nxt = 0;
    end  
endmodule
