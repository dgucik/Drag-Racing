//Source: https://www.chipverify.com/verilog/verilog-positive-edge-detector
module rising_edge_detector #(
    parameter WIDTH = 2
)
(
    input wire clk,
    input wire [ WIDTH - 1 : 0 ] sig_in,
    output wire [ WIDTH - 1 : 0 ] sig_out
);

    reg [ WIDTH - 1: 0 ] sig_d;

    always @(posedge clk)
        sig_d <= sig_in;

    assign sig_out = sig_in & ~sig_d;
endmodule