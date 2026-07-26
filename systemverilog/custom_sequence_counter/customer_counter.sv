`timescale 1ns / 1ps

module csc(
    input logic clk, rst,
    output logic [2:0] count
    );
    
    logic [2:0] t;
    
    always_ff @(posedge clk or negedge rst) begin
        if(!rst)
            count <= 3'b000;
        else
            count <= count ^ t;
    end
    
    always_comb begin
        casez(count)
            3'b000: t = 3'b001;
            3'b001: t = 3'b010;
            3'b011: t = 3'b111;
            3'b100: t = 3'b011;
            3'b111: t = 3'b000;
            default: t = count;
        endcase
    end
endmodule
