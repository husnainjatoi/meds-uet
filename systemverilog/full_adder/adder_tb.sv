`timescale 1ns / 1ps

module adder_tb();
logic a, b, cin, cout, sum, sum1, carry1, sum2, carry2;

int i;

half_adder1 uut_ha1 (.a(a), .b(b), .sum(sum1), .carry(carry1));
half_adder2 uut_ha2 (.a(a), .b(b), .sum(sum2), .carry(carry2));
full_adder uut_fa (.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));

task automatic check (input logic [1:0] actual, expected, string name); 
    if(actual !== expected)
        $display("[FAIL] %s: Actual = %02b , Expected = %02b at Time = %0t", name, actual, expected, $time);
    else
        $display("[PASS] %s: Value = %02b at Time = %0t", name, actual, $time);
endtask

function automatic logic [1:0] exp_fa(input logic a,b,cin);
    return a + b + cin;
endfunction


initial begin
    
    $dumpfile("dump.vcd"); 
    $dumpvars(0, adder_tb);
    
    $display("--- Starting Half Adder Tests ---");
    for(i = 0; i < 4; i++) begin
        {a, b} = i; #5;
        check({carry2, sum2}, {carry1, sum1}, "Half Adder");
    end
        
    $display("--- Starting Full Adder Tests ---");
    for(i=0; i<8; i++) begin
        {a,b,cin} = i; #5;
        check({cout, sum}, exp_fa(a,b,cin), "Full Adder");
    end
$finish;
end
endmodule
