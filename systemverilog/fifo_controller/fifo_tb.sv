`timescale 1ns / 1ps

module fifo_controller_tb();

    parameter ADDR_WIDTH = 3;
    parameter DATA_WIDTH = 8;
    logic clk = 0, rst_n;
    
    logic wr_en;
    logic [DATA_WIDTH-1:0] wr_data;
    logic wr_ready;
    
    logic rd_en;
    logic [DATA_WIDTH-1:0] rd_data;
    logic rd_valid;
    
    logic full;
    logic empty;
    logic [ADDR_WIDTH:0] count;
    
    fifo_controller #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) uut (.clk(clk), .rst_n(rst_n), .wr_en(wr_en), .wr_data(wr_data), .wr_ready(wr_ready),
                         .rd_en(rd_en), .rd_data(rd_data), .rd_valid(rd_valid), .full(full), .empty(empty),
                         .count(count));
    
    task automatic check(input int actual, input int expected, input string name);
        if(actual !== expected)
            $display("[FAIL] %s: Actual = %0d, Expected = %0d at Time = %0t", name, actual, expected, $time);
        else
        $display("[PASS] %s: Value = %0d at Time = %0t", name, actual, $time);
    endtask
    
    task automatic write_data(input logic [DATA_WIDTH-1:0] data);
        @(negedge clk) #1;
        wr_en = 1;
        wr_data = data;
        @(negedge clk) #1;
        wr_en = 0;
    endtask
    
    task automatic read_data();
        @(negedge clk) #1;
        rd_en = 1;
        @(negedge clk) #1;
        rd_en = 0;
    endtask
    
    always #5 clk = ~clk;
    initial begin
        rd_en = 0;
        wr_en = 0;
        rst_n = 0;
        #10;
        
        rst_n = 1;
        repeat(3) @(negedge clk); #1;
        
        check(empty, 1, "Init: Empty flag");
        check(count, 0, "Init: Count = 0");
        
        for(int i=0; i<8; i++) begin
            write_data(i+10);
        end
        check(full, 1, "Write: Full flag asserted");
        check(wr_ready, 0, "Write: wr_ready dropped");
        check(count, 8, "Write: Count is 8");
        
        write_data(99);
        check(count, 8, "Overflow: Count remained 8");
        
        for(int i=0; i<8; i++) begin
            check(rd_data, i + 10, "Read: True FIFO ordering");
            read_data();
        end
        check(empty, 1, "Read: Empty flag asserted");
        check(rd_valid, 0, "Read: rd_valid dropped");
        check(count, 0, "Read: Count is 0");
        
        read_data();
        check(count, 0, "Underflow: Count remained 0");
        
        for(int i=0; i<4; i++) begin
            write_data(i+20);
        end
        check(count, 4, "Partial Fill: Count is 4");
        
        @(negedge clk) #1;
        wr_en = 1;
        rd_en = 1;
        wr_data = 88;
        
        @(negedge clk) #1;
        wr_en = 0;
        rd_en = 0;
        check(count, 4, "Simultaneous: Count remained 4");
        
        #20; $finish;
    end
endmodule
