module rpm(
    input wire clk100Hz, //100kHz
    input wire rst,
    input wire [1:0] gear_in,
    input wire gas_key,
    input wire reset_status,
    output reg [13:0] rpm,
    output reg [1:0] gear_out
    );
    
    reg flag_for_readline_diode_in_cockpit_nxt;
    
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
            if(gear_in==1) begin
                //if(rpm-3390 < 1140) rpm_nxt = 1140;
                if(rpm < 4530) rpm_nxt = 1140;
                else rpm_nxt = rpm - 3390;
            end
            else if(gear_in==2) begin
                //if(rpm-3060 < 1140) rpm_nxt = 1140;
                if(rpm < 4200) rpm_nxt = 1140;
                else rpm_nxt = rpm - 3060;            
            end 
            else if(gear_in==3) begin
                //if(rpm-3080 < 1140) rpm_nxt = 1140;
                if(rpm < 4220) rpm_nxt = 1140;
                else rpm_nxt = rpm - 3080;            
            end
            else begin
                rpm_nxt = rpm;
            end
        end
        else begin
            if(gear_in==0) begin
                if(gas_key) begin
                  if( (rpm < 1140) )                          rpm_nxt = 1140;
                  else if( (1140 <= rpm)&&( rpm < 11000) )    rpm_nxt = rpm+50;
                  //else if( (rpm >= 11000) ) rpm_nxt = 11000;
                  else rpm_nxt = 11000;
                end
                else begin
                    if(rpm > 1140) rpm_nxt = rpm - 10;
                    //else rpm_nxt = 1140;
                    else rpm_nxt = 0;
                end
            end
            else if(gear_in==1) begin
                if(gas_key) begin
                    if( (rpm < 1140) )                          rpm_nxt = 1140;
                    else if( (1140 <= rpm)&&( rpm <= 4000) )       rpm_nxt = rpm+10;
                    else if( (4001 <= rpm)&&( rpm <= 6999) )  rpm_nxt = rpm+14;
                    else if( (7000 <= rpm)&&( rpm < 11000) )  rpm_nxt = rpm+17;
                    //else if( (rpm >= 11000) )                 rpm_nxt = 11000;
                    else rpm_nxt = 11000;
                end
                else begin
                    if(rpm > 1140) rpm_nxt = rpm - 10;
                    //else rpm_nxt = 1140;
                    else rpm_nxt = 0;
                end
            end 
            else if(gear_in==2) begin
                if(gas_key) begin
                    if( (rpm < 1140) )                          rpm_nxt = 1140;
                    else if( (1140 <= rpm)&&( rpm <= 4000) )       rpm_nxt = rpm+4;
                    else if( (4001 <= rpm)&&( rpm <= 6999) )  rpm_nxt = rpm+8;
                    else if( (7000 <= rpm)&&( rpm < 11000) )  rpm_nxt = rpm+12;
                    else if( (rpm >= 11000) )                 rpm_nxt = 11000;
                    else rpm_nxt = 1140;
                end 
                else begin
                    if(rpm > 1140) rpm_nxt = rpm - 10;
                    //else rpm_nxt = 1140;
                    else rpm_nxt = 0;
                end
            end  
            else if(gear_in==3)
                if(gas_key) begin
                    if( (rpm < 1140) )                          rpm_nxt = 1140;
                    else if( (1140 <= rpm)&&( rpm <= 4000) )       rpm_nxt = rpm+4;
                    else if( (4001 <= rpm)&&( rpm <= 6999) )  rpm_nxt = rpm+8;
                    else if( (7000 <= rpm)&&( rpm < 11000) )  rpm_nxt = rpm+12;
                    else if( (rpm >= 11000) )                 rpm_nxt = 11000;
                    else rpm_nxt = 1140;
                end
                else begin
                    if(rpm > 1140) rpm_nxt = rpm - 10;
                    //else rpm_nxt = 1140;
                    else rpm_nxt = 0;
                end
            else
                rpm_nxt = 1140;
        end
    end
endmodule
