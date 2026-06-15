module rec (

            input clk,  // global signal
			input rst,  // global signal
         	input rx,  // receiver

			output reg[7:0]data_out,
            output reg flag

           );
     
	 reg[7:0]mem;
	 reg w;  // variable which stores one value
	 reg p;  // check the parity

 parameter IDLE		=	0;
 parameter START	=	1;	
 parameter BIT_1	=	2;
 parameter BIT_2	=	3;
 parameter BIT_3	=	4;
 parameter BIT_4	=	5;
 parameter BIT_5	=	6;
 parameter BIT_6	=	7;
 parameter BIT_7	=	8;
 parameter BIT_8	=	9;
 parameter PARITY	=	10;
 parameter STOP		=	11;
 parameter VALID	=	12;

	reg[3:0]cs,ns;   

 always @(posedge clk or negedge rst)
      begin
	  if (!rst)
	  		begin
	  		    cs<=0;
			    data_out<=0;
                flag    <=  0; 
                mem <= 0;
			end
	  else
			cs<=ns;
	  end

 always @(cs)
 	begin
		case(cs)
		  IDLE		:	begin
		  					ns=START;
                            flag = 0;
		  				end
		  START		:	begin
		  					if(rx==0)
								ns=BIT_1;
						    else
								ns=IDLE;
		  				end
		  BIT_1		:	begin
		  					mem[0]=rx;
							ns=BIT_2;	
		  				end
		  BIT_2		:	begin
		  					mem[1]=rx;
							ns=BIT_3;
		  				end
		  BIT_3		:	begin
		  					mem[2]=rx;
							ns=BIT_4;
		  				end
		  BIT_4		:	begin
		  					mem[3]=rx;
							ns=BIT_5;
		  				end
		  BIT_5		:	begin
		  					mem[4]=rx;
							ns=BIT_6;
		  				end
		  BIT_6		:	begin
		  					mem[5]=rx;
							ns=BIT_7;
		  				end	
		  BIT_7		:	begin
		  					mem[6]=rx;
							ns=BIT_8;
		  				end
		  BIT_8		:	begin
		  					mem[7]=rx;
							ns=PARITY;
						end
		  PARITY	:	begin
		  					w=rx;
							p=^mem;
                            if( w == p)
                                begin
                                    ns = STOP;
                                end
                            else
                                begin
							        ns = IDLE;
                                end
		  				end
		  STOP		:	begin
		  					if(rx==1)
                                begin
								    data_out = mem;
                                    ns = IDLE;
                                    flag = 1;
                                end
							else
								ns=IDLE;
		  				end
		  /*VALID		:	begin
		  					if(w==p)
                                begin
								    data_out=mem;
                                    flag = 1;
                                    ns = IDLE;
                                end
							else
								ns=IDLE;
		  				end */


		endcase
	end


endmodule
