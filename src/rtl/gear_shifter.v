module gear_shifter(
    input wire clk,
    input wire rst,
    input wire reset_status,
    input wire keyboard_in_posedge,
    output reg [1:0] gear
    );
    
    reg [1:0] gear_nxt = 0;
    
    always @(posedge clk) begin
        if(rst||reset_status) begin
            gear <= 0;
        end
        else begin
            gear <= gear_nxt;
        end    
    end
    
    always @*
        if( (keyboard_in_posedge) && (gear<3) ) gear_nxt = gear+1;
        else gear_nxt = gear;
endmodule
