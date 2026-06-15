module fifo_dut #(parameter DATA_WIDTH=8, DEPTH=16)
            (
                input                       clk,
                input                       rst_n,
                input [DATA_WIDTH-1:0]      data_in,
                input                       wr_en,
                input                       rd_en,
				input                      flag,
                output reg                  full,
                output reg                  empty,
                output reg [DATA_WIDTH-1:0] fifo_out
            );

    reg [DATA_WIDTH-1:0] fifo [DEPTH-1:0];

    reg [$clog2(DEPTH)-1:0] wr_ptr,rd_ptr;
    reg [$clog2(DEPTH):0] count;

    always@(negedge clk)
        begin
            empty=(count==0);
            full=(count==(DEPTH));
        end

    always @(posedge clk or negedge rst_n) 
        begin
            if(!rst_n)
                begin
                    fifo_out<=0;
                    wr_ptr<=0;
                    rd_ptr<=0;
                    count<=0;
					
                end
            else        //rst_n=0
                begin
                    if(wr_en  &&  !rd_en  &&  !full)        //WRITE OPERATION
                        begin
                            fifo[wr_ptr]<=data_in;
                            wr_ptr<=wr_ptr+1;
                            count<=count+1;
                            //flag = 0;
                        end

                    else if(!wr_en  && rd_en  &&  !empty && flag)   //READ OPERATION
                        begin
                            fifo_out<=fifo[rd_ptr];
                            rd_ptr<=rd_ptr+1;
                            count<=count-1;
							
                        end

                  /*  else if(wr_en  && rd_en   &&  !full )   //WRITE AND READ
                        begin
                            fifo[wr_ptr]<=data_in;
                            fifo_out<=fifo[rd_ptr];
                            count<=count;
                        end*/
                end
        end
endmodule
