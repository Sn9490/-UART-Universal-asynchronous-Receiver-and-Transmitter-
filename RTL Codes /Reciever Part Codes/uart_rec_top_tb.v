`include "uart_rec_top.v"

module uart_rec_top_tb;

                       reg clk;
					   reg rst_n;
					   //reg[7:0]data_in;
					   reg wr_en;
					   reg rd_en;
                       reg RXD;
					   //wire full;
					   //wire empty;
                      
					   wire [7:0]fifo_out; 
                       integer i,j,k;

                       reg [7:0] temp;

                       integer count = 1, count_pass = 0, count_fail = 0;

reg [7:0] tx_ref [15:0];
reg [7:0] rx_ref [15:0];

	uart_rec_top urt (

                        .clk(clk),
						.rst_n(rst_n),
						//data_in
						.wr_en(wr_en),
						.rd_en(rd_en),
                        .RXD(RXD),
						//.full(full),
						//.empty(empty),
						.fifo_out(fifo_out)
	);	
     
	always #5 clk=~clk;
	initial clk=1;

	initial 
			begin
			rst_n=0;
			#5;
			rst_n=1;
			end
              
		 task write;
			  begin
                    temp = $urandom_range(11,99);
                    #10 RXD = 0; // START BIT
                    
                    #10 RXD = temp[0];
                    #10 RXD = temp[1];
                    #10 RXD = temp[2];
                    #10 RXD = temp[3];
                    #10 RXD = temp[4];
                    #10 RXD = temp[5];
                    #10 RXD = temp[6];
                    #10 RXD = temp[7];

                    #10 RXD = ^temp; // PARITY BIT
                    #10 RXD = 1; // STOP BIT

                    tx_ref[count-1] = temp;

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


			  	    wr_en=1;rd_en=0;
                    count = count + 1;
			   end
		 
		 endtask
		


		task read;
			begin
					wr_en=0;rd_en=1;

			end
	

	    endtask

		initial begin
                   $display("-------------[TXD]----------------");
                   repeat(16)
                        begin
					        write;
					        #10;
                        end

#10;
$display("============================================================================================");
count = 1;

                    $display("--------------[RXD]----------------");


                    repeat(16)
                        begin
					        read;
					        #10;
                            if(count < 10)
                                begin
                                    $display("[%0d]  [RECEIVED DATA FROM FIFO] = [%b]", count, fifo_out);
              
                                end

                            else
                                begin
                                    $display("[%0d] [RECEIVED DATA FROM FIFO] = [%b]", count, fifo_out);
                                end

                                rx_ref[count-1] = fifo_out;

                                count = count + 1;

                        end

$display("============================================================================================");

for(k=0; k<15; k=k+1)
    begin
        if(tx_ref[k] == rx_ref[k])
            begin
                count_pass = count_pass + 1;
            end
        else
            begin
                count_fail = count_fail + 1;
            end

         end


        $display("[PASS_COUNT] = [%0d]", count_pass);
        $display("[FAIL_COUNT] = [%0d]", count_fail);


		end


		initial #2500 $finish;

endmodule
