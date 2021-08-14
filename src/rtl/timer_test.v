`timescale 1 ns / 1 ps

module timer_test;

reg clk =0, rst;
reg start,restart;
wire [11:0] seconds;
wire [9:0] miliseconds;

initial begin
    rst = 0;
    #1000000 rst = 1;
    #1000000 rst = 0;
end

always 
    #500000 clk = ~clk;

initial begin 
    start = 0;
    restart = 0;
    #5000000 start = 1; //po 5ms start
    #1200000000 start =0; //po 1,2 sec stop
    #5000000 restart = 1;
    #5000000 start = 1;
    #5000000 restart = 0;
end

timer u_timer(
    .clk1KHz(clk),
    .reset(rst),
    .start(start),
    .restart(restart),
    .seconds(seconds),
    .miliseconds(miliseconds)
);

endmodule