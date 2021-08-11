module clk_divide
    #(
        parameter DIVISOR = 1000000
    )
    (
    output reg clk_out,
    input wire clk_in
    );

    reg [$clog2(DIVISOR) + 1:0] counter = 0;

    always @(posedge clk_in) begin
        clk_out <= (counter < DIVISOR/2) ? 1 : 0;
        if(counter == (DIVISOR-1))
            counter <= 0;
        else
            counter <= counter + 1;
    end
endmodule