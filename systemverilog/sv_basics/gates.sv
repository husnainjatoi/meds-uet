`timescale 1ns / 1ps

module gates(a,b,y_and, y_or, y_xor);

input logic a,b;
output logic y_and, y_or, y_xor;

assign y_and = a & b;    
assign y_or = a | b;
assign y_xor = a ^ b;

endmodule
