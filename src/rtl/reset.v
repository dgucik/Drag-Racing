module reset (
    output reg rst,
    input wire locked,
    input wire clk
    );

    localparam CLOCK_TICKS = 5;

    reg [4:0] counter, counter_nxt;

    always @(posedge clk)
        if(counter != CLOCK_TICKS)
            rst <= 1;
        else
            rst <= 0;

    always @(posedge clk, negedge locked)
        if(!locked)
            counter <= 0;
        else
            counter <= counter_nxt;

    always @*
        if(counter != CLOCK_TICKS)
            counter_nxt = counter + 1;
        else
            counter_nxt = counter;
endmodule