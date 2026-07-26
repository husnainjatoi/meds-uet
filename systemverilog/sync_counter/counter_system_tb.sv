`timescale 1ns / 1ps

module counter_tb();
    
    logic up_down, rst_n;
    logic clk = 0;
    logic [3:0] count;
    
    counter_system_top uut (.up_down(up_down), .rst_async(rst_n), .clk(clk), .count(count));
    
    always #5 clk = ~clk;
    
    initial begin

            rst_n = 0;
            up_down = 1;
            #12; 
            
            rst_n = 1; 
            #33; 

            rst_n = 0; 
            #15; 

            @(posedge clk); 
            rst_n = 1; 

            up_down = 1; 
            #200;
            
            up_down = 0; 
            #200;
            
            $finish;
        end
endmodule
