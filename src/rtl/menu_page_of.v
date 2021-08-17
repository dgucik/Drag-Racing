`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2021 14:38:24
// Design Name: 
// Module Name: menu_page_of
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


module menu_page_of(
    output reg [2:0] menu_state,
    output reg [1:0] menu_counter,
    input wire [2:0] keyboard_in,
    input wire back_to_main_menu_flag,
    input wire clk,
    input wire rst
    );
    
    localparam Main = 0;
    localparam StartGame = 1;
    localparam Control = 2;
    localparam About = 3;
    localparam Exit = 4;
    
    reg [2:0] state, state_nxt;
    reg [1:0] counter, counter_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            state <= Main;
            counter <= 0;
        end
        else begin
            state <= state_nxt;
            menu_state <= state_nxt;
            counter <= counter_nxt;
            menu_counter <= counter_nxt;
        end
    end
    
    always@* begin
        if(!back_to_main_menu_flag) begin
            case(state)
                Main:
                    begin
                        if(keyboard_in[2]) begin
                            if(counter>0) counter_nxt = counter -1;
                            else counter_nxt = counter;
                            
                            state_nxt = Main;
                        end
                        else if(keyboard_in[1]) begin
                            if(counter<3) counter_nxt = counter +1;
                            else counter_nxt = counter;
                            
                            state_nxt = Main;
                        end
                        else if(keyboard_in[0]) begin
                            if(counter==0) begin
                                state_nxt = StartGame;
                                counter_nxt = 0; end
                            else if(counter==1) begin
                                state_nxt = Control;
                                counter_nxt = 0; end
                            else if(counter==2) begin
                                state_nxt = About;
                                counter_nxt = 0; end
                            else if(counter==3) begin
                                state_nxt = Exit;
                                counter_nxt = 0; end
                            else 
                                state_nxt = Main;
                                counter_nxt = 0;
                        end
                        else begin
                            state_nxt = Main;
                            counter_nxt = counter;
                        end
                    end
                StartGame:
                    begin
                        state_nxt = StartGame;
                        counter_nxt = counter;
                    end
                Control:
                    begin
                        if(keyboard_in[0]) begin
                            state_nxt = Main;
                            counter_nxt = counter;
                        end
                        else begin
                            state_nxt = Control;
                            counter_nxt = counter;
                        end
                    end
                About:
                    begin
                        if(keyboard_in[0]) begin
                            state_nxt = Main;
                            counter_nxt = counter;
                        end
                        else begin
                            state_nxt = About;
                            counter_nxt = counter;
                        end
                    end
                Exit:
                    begin
                        if(keyboard_in[2]) begin
                            counter_nxt = 0;
                            state_nxt = Exit;
                        end
                        else if(keyboard_in[1]) begin
                            counter_nxt = 1; 
                            state_nxt = Exit;
                        end
                        else if(keyboard_in[0]) begin
                            if(counter == 0) begin
                                //set_break_flag
                                state_nxt = Exit;
                                counter_nxt = 0; 
                            end
                            else if(counter == 1) begin
                                state_nxt = Main;
                                counter_nxt = 0; 
                            end
                            else begin
                                state_nxt = Exit;
                                counter_nxt = 0; 
                            end
                        end
                        else begin
                            if(counter > 1) begin
                                state_nxt = Exit;
                                counter_nxt = 0;
                            end
                            else begin
                                state_nxt = Exit;
                                counter_nxt = counter; 
                            end
                        end 
                    end
                default: begin
                    state_nxt = Main;
                    counter_nxt = 0;
                end
            endcase
         end
         else begin
            state_nxt = Main;
            counter_nxt = 0;
         end
    end
endmodule
