module mux2to1(
    input wire D0,
    input wire D1,
    input wire D2,
    input wire S,
    output reg Y1,
    output reg Y2
    );
    
    always @* begin
        if(S) begin
            Y1 = D1;
            Y2 = D2;
        end
        else begin
            Y1 = D0;
            Y2 = D0;
        end
    end  
endmodule
