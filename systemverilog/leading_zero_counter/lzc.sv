`timescale 1ns / 1ps

module leading_zero_counter(
    input logic [31:0] num,
    output logic [5:0] count);

    logic [3:0] left_count, right_count;
    logic left_allzero, right_allzero;
    
    lzc_16bit left_lzc(.in(num[31:16]), .count(left_count), .allzero(left_allzero));
    lzc_16bit right_lzc(.in(num[15:0]), .count(right_count), .allzero(right_allzero));
    
    logic [4:0] temp_count;

    always_comb begin
    
    if(left_allzero == 1'b1)
        temp_count = {1'b1, right_count};
    else
        temp_count = {1'b0, left_count};
    
    if(left_allzero & right_allzero)
        count = 6'b100000;
    else
        count = {1'b0, temp_count};

end
endmodule

module lzc_2bit(
    input logic [1:0] in,
    output logic count, allzero);

always_comb begin
    count = 1'b0;
    allzero = 1'b0;
    
    if(in[1] == 1'b1)
        count = 1'b0;
    else if (in[0] == 1'b1)
        count = 1'b1;
    else
        allzero = 1'b1;
end
endmodule

module lzc_4bit (
    input  logic [3:0] in,
    output logic [1:0] count,
    output logic       allzero
);

    logic left_count, right_count;
    logic left_allzero, right_allzero;
    
    lzc_2bit left_lzc(.in(in[3:2]), .count(left_count), .allzero(left_allzero));
    lzc_2bit right_lzc(.in(in[1:0]), .count(right_count), .allzero(right_allzero));
    
    always_comb begin
    
    if(left_allzero == 1'b1)
        count = {1'b1, right_count};
    else
        count = {1'b0, left_count};
    allzero = left_allzero & right_allzero;
    
    end
endmodule

module lzc_8bit (
    input  logic [7:0] in,
    output logic [2:0] count,
    output logic       allzero
);

    logic [1:0] left_count, right_count;
    logic left_allzero, right_allzero;
    
    lzc_4bit left_lzc(.in(in[7:4]), .count(left_count), .allzero(left_allzero));
    lzc_4bit right_lzc(.in(in[3:0]), .count(right_count), .allzero(right_allzero));
    
    always_comb begin
    
    if(left_allzero == 1'b1)
        count = {1'b1, right_count};
    else
        count = {1'b0, left_count};
    allzero = left_allzero & right_allzero;
    
    end
endmodule

module lzc_16bit (
    input  logic [15:0] in,
    output logic [3:0] count,
    output logic       allzero
);

    logic [2:0] left_count, right_count;
    logic left_allzero, right_allzero;
    
    lzc_8bit left_lzc(.in(in[15:8]), .count(left_count), .allzero(left_allzero));
    lzc_8bit right_lzc(.in(in[7:0]), .count(right_count), .allzero(right_allzero));
    
    always_comb begin
    
    if(left_allzero == 1'b1)
        count = {1'b1, right_count};
    else
        count = {1'b0, left_count};
    allzero = left_allzero & right_allzero;
    
    end
endmodule
