`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2021 05:26:03
// Design Name: 
// Module Name: rpm
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


module rpm(
    input wire clk100Hz, //100kHz
    input wire rst,
    input wire [1:0] gear_in,
    input wire gas_key,
    input wire reset_status,
    output reg [13:0] rpm,
    output reg [1:0] gear_out,
    output reg flag_for_readline_diode_in_cockpit
    );
    
    reg [13:0] rpm_nxt = 0;
    reg [1:0] gear_out_nxt = 0;
    
    always @(posedge clk100Hz) begin
        if(rst||reset_status) begin
            rpm <= 0;
            gear_out <= 0;
        end
        else begin
            rpm <= rpm_nxt;
            gear_out <= gear_out_nxt;
        end
    end
    
    always @* begin
        gear_out_nxt = gear_in;
        
        if(gear_in != gear_out) begin
            if(rpm-5500 < 1000) rpm_nxt = 1000;
            else rpm_nxt = rpm - 5500;
        end
        else begin
            if(gear_in==0) begin
                if(gas_key) begin
                  if( (rpm < 1000) )                        rpm_nxt = 1000;
                  else if( (1000 <= rpm)&&( rpm <= 2000) )  rpm_nxt = rpm+26;
                  else if( (2001 <= rpm)&&( rpm <= 3000) )  rpm_nxt = rpm+27;
                  else if( (3001 <= rpm)&&( rpm <= 4000) )  rpm_nxt = rpm+31;
                  else if( (4001 <= rpm)&&( rpm <= 5000) )  rpm_nxt = rpm+34;
                  else if( (5001 <= rpm)&&( rpm <= 7000) )  rpm_nxt = rpm+36;
                  else if( (7001 <= rpm)&&( rpm <= 9000) )  rpm_nxt = rpm+36;
                  else if( (9001 <= rpm)&&( rpm < 11000) )  rpm_nxt = rpm+36;
                  else if( (rpm >= 11000) )                 rpm_nxt = 11000;
                  else rpm_nxt = 1000;
                end
                else begin
                    if(rpm > 1000) rpm_nxt = rpm - 10;
                    else rpm_nxt = 0;
                end
            end
            else if(gear_in==1) begin
                if(gas_key) begin
                    if( (1000 <= rpm)&&( rpm <= 3000) )       rpm_nxt = rpm+7;
                    else if( (3001 <= rpm)&&( rpm <= 4000) )  rpm_nxt = rpm+8;
                    else if( (4001 <= rpm)&&( rpm <= 5000) )  rpm_nxt = rpm+10;
                    else if( (5001 <= rpm)&&( rpm <= 7000) )  rpm_nxt = rpm+15;
                    else if( (7001 <= rpm)&&( rpm <= 9000) )  rpm_nxt = rpm+16;
                    else if( (9001 <= rpm)&&( rpm <= 11000) ) rpm_nxt = rpm+17;
                    else if( (rpm >= 11000) ) rpm_nxt = 11000;
                    else rpm_nxt = 1000;
                end
                else begin
                    if(rpm > 1000) rpm_nxt = rpm - 10;
                    else rpm_nxt = 1000;
                end
            end 
            else if(gear_in==2) begin
                if(gas_key) begin
                    if( (1000 <= rpm)&&( rpm <= 3000) )       rpm_nxt = rpm+2;
                    else if( (3001 <= rpm)&&( rpm <= 4000) )  rpm_nxt = rpm+4;
                    else if( (4001 <= rpm)&&( rpm <= 5000) )  rpm_nxt = rpm+8;
                    else if( (5001 <= rpm)&&( rpm <= 7000) )  rpm_nxt = rpm+12;
                    else if( (7001 <= rpm)&&( rpm <= 9000) )  rpm_nxt = rpm+13;
                    else if( (9001 <= rpm)&&( rpm <= 11000) ) rpm_nxt = rpm+13;
                    else if( (rpm >= 11000) ) rpm_nxt = 11000;
                    else rpm_nxt = 1000;
                end 
                else begin
                    if(rpm > 1000) rpm_nxt = rpm - 10;
                    else rpm_nxt = 1000;
                end
            end  
            else if(gear_in==3)
                if(gas_key) begin
                    if( (1000 <= rpm)&&( rpm <= 3000) )       rpm_nxt = rpm+2;
                    else if( (3001 <= rpm)&&( rpm <= 4000) )  rpm_nxt = rpm+4;
                    else if( (4001 <= rpm)&&( rpm <= 5000) )  rpm_nxt = rpm+8;
                    else if( (5001 <= rpm)&&( rpm <= 7000) )  rpm_nxt = rpm+12;
                    else if( (7001 <= rpm)&&( rpm <= 9000) )  rpm_nxt = rpm+13;
                    else if( (9001 <= rpm)&&( rpm <= 11000) ) rpm_nxt = rpm+13;
                    else if( (rpm >= 11000) ) rpm_nxt = 11000;
                    else rpm_nxt = 1000;
                end
                else begin
                    if(rpm > 1000) rpm_nxt = rpm - 10;
                    else rpm_nxt = 1000;
                end
            else
                rpm_nxt = 1000;
        end
    end
endmodule
