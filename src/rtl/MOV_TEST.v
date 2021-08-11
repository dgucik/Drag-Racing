module MOV_TEST(
    input wire clk,
    input wire rst,
    input wire key,
    output reg [31:0] pos

);

    always @(posedge clk)
        if(rst)
            pos <= 0;
        else
            pos <= pos + key;

endmodule