`timescale 1ns / 1ps

module leading_zero_counter(
    input logic [31:0] num,
    output logic [5:0] count);

always_comb begin
    count = 0;
    for(int i=31; i>=0; i--) begin
    if(num[i] == 1)
        break;
    else
        count++; 
    end
end
endmodule
