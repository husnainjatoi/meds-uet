`timescale 1ns / 1ps

module fifo_controller #(
    parameter ADDR_WIDTH = 3,
    parameter DATA_WIDTH = 8
    ) 
    (
    input logic clk, rst_n,
    
    input logic wr_en,
    input logic [DATA_WIDTH-1:0] wr_data,
    output logic wr_ready,
    
    input logic rd_en,
    output logic [DATA_WIDTH-1:0] rd_data,
    output logic rd_valid,
    
    output logic full,
    output logic empty,
    output logic [ADDR_WIDTH:0] count
    );
    
    logic rst_sync;
    rst_sync synchronized_rst (.clk(clk), .rst_async(rst_n), .rst_sync(rst_sync));
    
    logic [ADDR_WIDTH:0] wr_ptr, rd_ptr;
    logic [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];
    
    always_ff @(posedge clk or negedge rst_sync) begin
        if(!rst_sync) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
        end
        else begin
            casez ({wr_en, full})
                2'b10: begin 
                    mem[wr_ptr[ADDR_WIDTH-1:0]] <= wr_data;
                    wr_ptr <= wr_ptr + 1;
                end
                default:  ;
            endcase
            
            casez ({rd_en, empty})
                2'b10: begin
                    rd_ptr <= rd_ptr + 1;
                end
                default: ;
            endcase
        end
    end
    
    always_comb begin
        rd_data = mem[rd_ptr[ADDR_WIDTH-1:0]];
        empty = (wr_ptr == rd_ptr);
        full = (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) && (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0]);
        count = wr_ptr - rd_ptr;
        rd_valid = ~empty;
        wr_ready = ~full;
    end
endmodule

module rst_sync(
    input logic rst_async, clk,
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
