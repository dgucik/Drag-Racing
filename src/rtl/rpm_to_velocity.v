module rpm_to_velocity(
    input wire clk100Hz,
    input wire rst,
    input wire [13:0] rpm,
    input wire [1:0] gear,
    input wire reset_status,
    //output reg [6:0] d_position
    output reg [4:0] d_position
    );
    
    localparam gear_ratio1 = 9;
    localparam gear_ratio2 = 13;
    localparam gear_ratio3 = 18;
    localparam gear_ratio4 = 25;
    
    reg [18:0] velocity;
    //reg [6:0] d_position_nxt;
    reg [4:0] d_position_nxt;
    
    always @(posedge clk100Hz) begin
        if(rst||reset_status) begin
            d_position <= 0;
        end
        else begin
            d_position <= d_position_nxt;
        end
    end
    
    always @* begin
        if(gear==0)  velocity = gear_ratio1 * rpm;
        else if(gear==1) velocity = gear_ratio2 * rpm;
        else if(gear==2) velocity = gear_ratio3 * rpm;
        else if(gear==3) 
            begin
                if((gear_ratio4 * rpm) < 253952) velocity = gear_ratio4 * rpm;
                else velocity = 253952;
            end
        else begin 
            velocity = 0;
        end
        
        d_position_nxt = velocity[18:13];
    end
endmodule
