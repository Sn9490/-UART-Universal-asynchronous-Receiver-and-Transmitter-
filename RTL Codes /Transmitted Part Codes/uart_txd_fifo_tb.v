`include "uart_txd_fifo_dut.v"
module uart_txd_fifo_tb;

    reg rst_n;
    reg clk;
    reg[7:0]data_in;
    reg rd_en;
    reg wr_en;
    wire full;
    wire empty;
    wire tx_dout;

    integer count = 1, count_pass = 0, count_fail = 0;

    reg [7:0] temp;

//reg [7:0] data_ref [15:0];
//reg [7:0] tx_ref [15:0];

     uart_txd_fifo_dut txd_fifo(
                            .rst_n(rst_n),
                            .clk(clk),
                            .data_in(data_in),
                            .rd_en(rd_en),
                            .wr_en(wr_en),
                            .full(full),
                            .empty(empty),
                            .tx_dout(tx_dout)
                            );

     initial 
        begin
            clk=0;
            rst_n=0;
            #10
            rst_n=1;
        end


    always #5 clk=~clk;

    task write();
        begin 
            wr_en = 1; rd_en = 0;
            data_in = $random;
            temp = data_in;

            /*BFM
                temp = {0, data_in, ^data_in, 1};

                  data_ref[count-1] = temp;*/

                    if(count < 10)
                        begin
                            $display("The Transmitted [FRAME] [%0d]  = [START] [*PAYLOAD] [PARITY] [STOP]",count);
                            $display("---------------------------- = [  0  ] [%b] [  %b  ] [  1  ]", temp, ^temp);
                        end

                    else
                        begin
                            $display("The Transmitted [FRAME] [%0d] = [START] [*PAYLOAD] [PARITY] [STOP]",count);
                            $display("---------------------------- = [  0  ] [%b] [  %b  ] [  1  ]", temp, ^temp);
                        end
               count = count + 1;
        end
    endtask

    task read();
        begin
            wr_en = 0; rd_en = 1;
            #110;
        end
    endtask

    initial 
        begin
            $display("-------------[DATA]----------------");
            repeat(16)
                begin
                    #10;
                    write;
                end

            repeat(16)
                begin
                    #10; 
                    read;
                end
        end


    /*initial
        begin
            wr_en=1;
            rd_en=0;

            #20;

            rd_en=1;
            wr_en=0;
        end

        initial $monitor("data_in=%b    full=%b   empty=%b    tx_dout=%b   ",data_in,full,empty,tx_dout);*/

        initial #2500 $finish;



endmodule
