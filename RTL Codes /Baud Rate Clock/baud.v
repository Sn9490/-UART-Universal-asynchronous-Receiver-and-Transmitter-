module baud(
            input clk1,rst,
            input clk2,
            output reg baud1,baud2);
  reg [15:0] counter;
 
 always @(posedge clk1 or posedge rst) begin
        if (!rst) begin
            counter <= 0;
            baud1<=0;
        end 
        else begin
        if(counter==27)
            baud1<=1;
        else
            baud1<=0;
            end
        counter<=counter+1;
   end

   always@(posedge clk2 or posedge rst) begin 
        if(!rst) begin 
            counter<=0;
            baud2<=0;
            end
         else begin 
             if(counter==40)
                 baud2<=1;
             else
                 baud2<=0;
                end
        end
       counter<=counter+1;
    end
endmodule
