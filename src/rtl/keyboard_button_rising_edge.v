module keyboard_button_rising_edge(
    input wire [3:0] key_pressed,
    input wire clk,
    output reg [3:0] key_pressed_posedge
    );
    
    reg [3:0] key_pressed_nxt, key_pressed_nxt_d = 4'b0000;
    
    always @(posedge clk) begin
        key_pressed_nxt_d <= key_pressed_nxt;
    end
    
    always @(posedge clk) begin
        if((~key_pressed_nxt_d[3] && key_pressed_nxt[3])==1) key_pressed_posedge[3] <= 1;
        else key_pressed_posedge[3] <= 0;
        
        if((~key_pressed_nxt_d[2] && key_pressed_nxt[2])==1) key_pressed_posedge[2] <= 1;
        else key_pressed_posedge[2] <= 0;
        
        if((~key_pressed_nxt_d[1] && key_pressed_nxt[1])==1) key_pressed_posedge[1] <= 1;
        else key_pressed_posedge[1] <= 0;
        
        if((~key_pressed_nxt_d[0] && key_pressed_nxt[0])==1) key_pressed_posedge[0] <= 1;
        else key_pressed_posedge[0] <= 0;
    end
    
    always @* begin
        key_pressed_nxt = key_pressed;
    end
    
endmodule
