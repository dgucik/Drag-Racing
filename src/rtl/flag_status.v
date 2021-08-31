module flag_status(
    input wire clk,
    input wire reset,
    input wire clear,
    input wire set,
    output reg status
);
    
    reg status_nxt;

    always @(posedge clk)
        if(reset)
            status <= 0;
        else
            status <= status_nxt;
    
    always @* begin
        status_nxt = status;
        if(clear == 1)
            status_nxt = 0;
        else if(set == 1)
            status_nxt = 1;
    end
      
endmodule