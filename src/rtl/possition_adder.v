module position_adder(
    input wire clk10Hz,
    input wire rst,
    input wire [6:0] d_position,
    input wire reset_status,
    output reg [31:0] position
    );
    
    reg [31:0] position_nxt = 0;
    
    always @(posedge clk10Hz) begin
        if(rst||reset_status) begin
            position <= 0;
        end
        else begin
           position <= position_nxt; 
        end    
    end
    
    always @* begin
        position_nxt = position + d_position;
    end
endmodule
