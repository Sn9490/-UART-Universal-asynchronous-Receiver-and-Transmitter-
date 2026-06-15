`include "fifo_dut.v"
`include "uart_txd_dut.v"
module uart_txd_fifo_dut(
                            input rst_n,
                            input clk,
                            input [7:0]data_in,
                            input rd_en,
                            input wr_en,
                            output full,
                            output empty,
                            //output [7:0]data_out,
                            output tx_dout
                            );

        wire flag_wire;
        wire [7:0] fifo_out_to_tx_din;
  

    fifo_dut fifo(
                    .clk(clk),
                    .rst_n(rst_n), 
                    .data_in(data_in),
                    .rd_en(rd_en),
                    .wr_en(wr_en),
                    .full(full),
                    .flag(flag_wire),
                    .empty(empty),
                    .fifo_out(fifo_out_to_tx_din)

                 );

     uart_txd tx(
                    .clk(clk),
                    .rst_n(rst_n),
                    .tx_din(fifo_out_to_tx_din),      //this connected from fifo output to transmitter input
                    .flag(flag_wire),
                    .tx_dout(tx_dout)
                    
              );


endmodule
