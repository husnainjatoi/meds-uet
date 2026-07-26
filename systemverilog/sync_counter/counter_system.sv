`timescale 1ns / 1ps

module counter(
    input logic up_down, rst_n, clk,
    output logic [3:0] count
    );
    
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            count <= 4'b0000;
        else begin
            if(up_down)
                count <= count + 1;
            else 
                count <= count - 1;
        end 
    end
endmodule

module rst_sync(
    input logic clk, rst_async,
    output logic rst_sync
    );
    logic q1;
    
    always_ff @(posedge clk or negedge rst_async) begin
        if(!rst_async) begin
            q1 <= 1'b0;
            rst_sync <= 1'b0;
        end
        else begin
            q1 <= 1'b1;
            rst_sync <= q1;
        end
    end
endmodule

module counter_system_top(
    input logic clk, rst_async, up_down,
    output logic [3:0] count
    );
    logic rst_sync;
    
    rst_sync sync_inst (.clk(clk), .rst_async(rst_async), .rst_sync(rst_sync));
    counter count_inst (.clk(clk), .up_down(up_down), .count(count), .rst_n(rst_sync));
endmodule
