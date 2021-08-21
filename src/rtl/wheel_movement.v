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