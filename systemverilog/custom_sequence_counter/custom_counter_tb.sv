`timescale 1ns / 1ps

module csc_tb();

    logic clk = 0, rst;
    logic [2:0] count;
    csc uut (.clk(clk), .rst(rst), .count(count));
    
    always #5 clk = ~clk;
    
    task automatic check(input int actual, input int expected, input string name);
        if(actual !== expected)
            $display("[FAIL] %s: Actual = %0d, Expected = %0d at Time = %0t", name, actual, expected, $time);
        else
            $display("[PASS] %s: Value = %0d at Time = %0t", name, actual, $time);
    endtask
    
    initial begin
        rst = 0;
        @(posedge clk) #1;
        rst = 1; 
        
        for (int i = 1; i <= 3; i++) begin
            $display("--- Starting Cycle %0d ---", i);
            check(count, 0, "State 0");
            @(posedge clk) #1;
            check(count, 1, "State 1");
            @(posedge clk) #1;
            check(count, 3, "State 3");
            @(posedge clk) #1;
            check(count, 4, "State 4");
            @(posedge clk) #1;
            check(count, 7, "State 7");
            @(posedge clk) #1;
        end
        $finish;
    end
endmodule
