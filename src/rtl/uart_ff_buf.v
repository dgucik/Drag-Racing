//Listing 8.4
module uart_ff_buf
   #( // Default setting:
      // 19,200 baud, 8 data bits, 1 stop bit, 2^2 FIFO
      parameter DBIT = 8,     // # data bits
                SB_TICK = 16, // # ticks for stop bits, 16/24/32
                              // for 1/1.5/2 stop bits
                //DVSR = 163,   // baud rate divisor
                              // DVSR = 50M/(16*baud rate)
                
                DVSR = 212,   // baud rate divisor
                            // DVSR = 65M/(16*baud rate)
                DVSR_BIT = 8 // # bits of DVSR
   )
   (
    input wire clk, reset,
    input wire rd_uart, wr_uart, rx,
    input wire [7:0] w_data,
    output wire tx_full, rx_empty, tx,
    output wire [7:0] r_data
   );

   // signal declaration
   wire tick, rx_done_tick, tx_done_tick;
   wire rx_flag, tx_flag;
   wire [7:0] tx_buf_out, rx_data_out;

   //body
   mod_m_counter #(.M(DVSR), .N(DVSR_BIT)) baud_gen_unit (.
        clk(clk),
        .reset(reset),
        .q(),
        .max_tick(tick)
    );

   uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_rx_unit (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .s_tick(tick),
        .rx_done_tick(rx_done_tick),
        .dout(rx_data_out)
    );

    flag_buf #(.W(DBIT)) flag_buf_rx_unit (
        .clk(clk),
        .reset(reset),
        .clr_flag(rd_uart),
        .set_flag(rx_done_tick),
        .din(rx_data_out),
        .flag(rx_flag),
        .dout(r_data)
    );

    flag_buf #(.W(DBIT)) flag_buf_tx_unit (
        .clk(clk),
        .reset(reset),
        .clr_flag(tx_done_tick),
        .set_flag(wr_uart),
        .din(w_data),
        .flag(tx_flag),
        .dout(tx_buf_out)
    );

   uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_tx_unit (
        .clk(clk),
        .reset(reset),
        .tx_start(tx_flag),
        .s_tick(tick),
        .din(tx_buf_out),
        .tx_done_tick(tx_done_tick),
        .tx(tx)
    );

    assign rx_empty = ~rx_flag;
    assign tx_full = tx_flag;

endmodule