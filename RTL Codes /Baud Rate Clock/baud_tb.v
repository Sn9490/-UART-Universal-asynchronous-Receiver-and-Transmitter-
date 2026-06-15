module baud_tb;
      reg clk1,rst;
      reg clk2;
      wire baud1,baud2;

    baud dut(clk1,rst,clk2,baud1,baud2) 

    initial begin  
             clk1=0;
       forever 
