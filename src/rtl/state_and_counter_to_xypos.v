//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Patryk Kocinski
// 
// Create Date:
// Design Name:
// Module Name: state_and_counter_to_xypos
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is state_and_counter_to_xypos module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module state_and_counter_to_xypos(
    input wire clk,
    input wire rst,
    input wire [2:0] menu_state,
    input wire [1:0] menu_counter,
    output reg [10:0] x_pointer,
    output reg [10:0] y_pointer    
    );                              
    
    localparam Main = 0;
    localparam StartGame = 1;
    localparam Control = 2;
    localparam About = 3;
    localparam Exit = 4;    
    
    reg [10:0] x_pointer_nxt = 0, y_pointer_nxt = 0;
    
    always @(posedge clk) begin
        if(rst) begin
            x_pointer <= 0;
            y_pointer <= 0;
        end
        else begin
            x_pointer <= x_pointer_nxt;
            y_pointer <= y_pointer_nxt;
        end
    end
    
    always @* begin
        case(menu_state)
            Main: begin
                if(menu_counter == 0) begin
                    x_pointer_nxt = 451;
                    y_pointer_nxt = 228; 
                end
                else if(menu_counter == 1) begin
                    x_pointer_nxt = 451;
                    y_pointer_nxt = 260;
                end
                else if(menu_counter == 2) begin
                    x_pointer_nxt = 451;
                    y_pointer_nxt = 292;
                end
                else if(menu_counter == 3) begin
                    x_pointer_nxt = 451;
                    y_pointer_nxt = 324;
                end
                else begin 
                    x_pointer_nxt = 1024;
                    y_pointer_nxt = 0;
                end
            end
            
            StartGame: begin
                x_pointer_nxt = 1024;
                y_pointer_nxt = 0;
            end
            
            Control: begin
                x_pointer_nxt = 523;
                y_pointer_nxt = 340;
            end
            
            About: begin
                x_pointer_nxt = 523;
                y_pointer_nxt = 340;
            end
            
            Exit: begin
                if(menu_counter == 0) begin
                    x_pointer_nxt = 435;
                    y_pointer_nxt = 244;
                end
                else if(menu_counter == 1) begin
                    x_pointer_nxt = 435;
                    y_pointer_nxt = 276;
                end
                else begin 
                    x_pointer_nxt = 1024;
                    y_pointer_nxt = 0;
                end
            end
            default: begin
                x_pointer_nxt = 1024;
                y_pointer_nxt = 0;
            end
        endcase
    end    
endmodule
