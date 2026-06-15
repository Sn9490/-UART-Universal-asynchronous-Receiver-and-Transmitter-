module uart_txd(
                    input clk,
                    input rst_n,
                    input [7:0] tx_din,
                    output reg flag,
                    output reg tx_dout
                                 );

        //reg [7:0] temp_tx;

        //reg load=1;

    parameter IDLE       =  0;
    parameter START      =  1;
    parameter BIT_0      =  2;
    parameter BIT_1      =  3;
    parameter BIT_2      =  4;
    parameter BIT_3      =  5;
    parameter BIT_4      =  6;
    parameter BIT_5      =  7;
    parameter BIT_6      =  8;
    parameter BIT_7      =  9;
    parameter PARITY_BIT =  10;
    parameter STOP       =  11;

    reg [3:0] cs,ns;
    reg p;


    always @(posedge clk or negedge rst_n)
        begin
            if(!rst_n)
                begin
                  tx_dout<=1;
                    cs<=0;
                    p<=0;
                   flag<=0;
                end
            else
                cs<=ns;
        end

     always @(cs)
        begin
            case(cs)
                IDLE  :begin
                        //if(tx_din==0)
                        //begin
                            ns=START;
                            //load=0;
                            flag=1;
                       //end
                        //else
                            //ns=IDLE;
                       end
                START :begin
                        tx_dout=0;
                        ns=BIT_0;
                        flag = 0;
                       end

                BIT_0 :begin
                        tx_dout=tx_din[0];
                        ns=BIT_1;
                       end

                BIT_1 :begin
                        tx_dout=tx_din[1];
                        ns=BIT_2;
                       end

                BIT_2 :begin
                        tx_dout=tx_din[2];
                        ns=BIT_3;
                       end

                BIT_3 :begin
                        tx_dout=tx_din[3];
                        ns=BIT_4;
                       end
                
                BIT_4 :begin
                        tx_dout=tx_din[4];
                        ns=BIT_5;
                       end
        
                
                BIT_5 :begin
                        tx_dout=tx_din[5];
                        ns=BIT_6;
                       end

                BIT_6 :begin
                        tx_dout=tx_din[6];
                        ns=BIT_7;
                       end

                BIT_7 :begin
                        tx_dout=tx_din[7];
                        ns=PARITY_BIT;
                        end

                PARITY_BIT :begin
                            p=^tx_din;
                            tx_dout=p;
                            ns=STOP;
                            end


                STOP : begin
                            tx_dout=1;
                            ns=IDLE;
                            //flag=0;
                       end
                //take another state for assign total output  

                endcase

                      
            end



endmodule
