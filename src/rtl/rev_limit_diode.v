module rev_limit_diode(
    input wire [13:0] rpm,
    output reg diode
    
    );
    always @* begin
        if(rpm >= 10800) diode = 1;
        else diode = 0;
    end
endmodule
