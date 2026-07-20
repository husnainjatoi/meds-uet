`timescale 1ns / 1ps

module half_adder1(a, b, sum, carry);
input logic a, b;
output logic sum, carry;

assign sum = a ^ b;
assign carry = a & b;

endmodule

module half_adder2(a, b, sum, carry);
input logic a, b;
output logic sum, carry;

always_comb begin

case({a,b})
    2'b00: begin
        sum = 0;
        carry = 0;
    end
    2'b01: begin
        sum = 1;
        carry = 0;
    end
    2'b10: begin
        sum = 1;
        carry = 0;
    end
    2'b11: begin
        sum = 0;
        carry = 1;
    end
    
    default: begin
        sum = 0;
        carry = 0;
    end
    
endcase
end
endmodule


module full_adder(a, b, sum, cin, cout);
input logic a, b, cin;
output logic sum, cout;

logic sum1, carry1, carry2;

half_adder1 halfadder1(.a(a), .b(b), .carry(carry1), .sum(sum1));
half_adder2 halfadder2(.a(sum1), .b(cin), .sum(sum), .carry(carry2));

assign cout = carry1 | carry2;

endmodule
