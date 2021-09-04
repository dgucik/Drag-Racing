module p1_and_p2_data(
    input wire clk,
    input wire rst,
    //player1_inputs_and_outputs
    input wire [7:0] p1_in_data,
    input wire tx_full,
    output reg [7:0] p1_out_data,
    output reg wr_uart,
    //player2_inputs_and_outputs
    input wire [7:0] p2_in_data,
    input wire rx_empty,
    output reg [7:0] p2_out_data,
    output reg rd_uart
    );   
    
    reg [7:0] p1_out_data_nxt = 0;
    reg [7:0] p2_out_data_nxt = 0;
    reg rd_uart_nxt, wr_uart_nxt;
    
    localparam reciving = 2'b00,
               stop_reciving_start_sending = 2'b01,
               sending = 2'b10;
               //sending = 2'b11;
    
    reg [1:0] state, state_nxt;
    
    always @(posedge clk) begin
        if(rst) begin
            p1_out_data <= 1'b0;
            p2_out_data <= 1'b0;
            rd_uart <= 1'b1;
            wr_uart <= 1'b0;
            state <= 0;
        end
        else begin
            p1_out_data <= p1_out_data_nxt;
            p2_out_data <= p2_out_data_nxt;
            rd_uart <= rd_uart_nxt;
            wr_uart <= wr_uart_nxt;
            state <= state_nxt;
        end
    end

    always @* begin
        wr_uart_nxt = 1'b0;
        rd_uart_nxt = 1'b0;
        p1_out_data_nxt = p1_out_data;
        p2_out_data_nxt = p2_out_data;
        state_nxt = state;
        case(state)
            reciving:
                begin
                    if(rx_empty) begin
                        state_nxt = reciving;
                        p1_out_data_nxt = p1_in_data;
                        rd_uart_nxt = 1'b0; 
                    end
                    else begin
                        state_nxt = stop_reciving_start_sending;
                        p1_out_data_nxt = p1_in_data;
                        p2_out_data_nxt = p2_in_data;
                        rd_uart_nxt = 1'b1;
                    end
                end
            stop_reciving_start_sending:
                begin
                    wr_uart_nxt = 1'b1;
                    if(~tx_full) begin
                        state_nxt = sending;
                    end
                end
            sending:
                begin
                    p1_out_data_nxt = p1_in_data;
                    if(~tx_full) begin
                        state_nxt = reciving; 
                    end
                end
        endcase
    end
endmodule
