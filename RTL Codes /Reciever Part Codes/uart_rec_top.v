`include"fifo.v"
`include"rec.v"
module uart_rec_top (
                     input clk,
					 input rst_n,
                     input RXD,
					 //input [7:0]
					 input wr_en,
					 input rd_en,
					 //output full,
					 //output empty,
              		 output [7:0]fifo_out
                     );
      //wire   // for fifo and receiver connection 

      wire [7:0]dodin_w; //this is connecting from rx o/p to fifo datain

      wire int_flag_w;
				

				fifo tf(
                         
						  .clk(clk),
                          .rst_n(rst_n),
                          .data_in(dodin_w),
                          .wr_en(wr_en),
                          .rd_en(rd_en),
                          //.full(full),
		                  //.flag(w),
                          //.empty(empty),
                          .fifo_out(fifo_out),
                          .flag(int_flag_w)
			            );
          
		      rec r1 (

                          .clk(clk),
						  .rst(rst_n),
						  .rx(RXD),
						  .data_out(dodin_w),
                          .flag(int_flag_w)
			  );









endmodule	
