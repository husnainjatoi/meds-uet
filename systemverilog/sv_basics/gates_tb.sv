`timescale 1ns / 1ps

module gates_tb();
logic a,b,y_and, y_or, y_xor;
int i;
logic [1:0] ab;

gates uut (.a(a), .b(b), .y_and(y_and), .y_or(y_or), .y_xor(y_xor));

task automatic check(input logic actual, expected, string name);
    if(actual !== expected)
        $display("[FAIL] %s: Expected = %0b Actual = %0b at Time = %0t", name, expected, actual, $time);
    else
        $display("[PASS] %s: Value = %0b at Time = %0t", name, actual, $time);
endtask

function automatic logic expected_and(input logic a,b);
    return a & b;
endfunction

function automatic logic expected_or(input logic a,b);
    return a | b;
endfunction

function automatic logic expected_xor(input logic a,b);
    return a ^ b;
endfunction

initial begin
    $display("--- Starting Self-Checking Exhaustive Test ---");
    
    $dumpfile("dump.vcd");
    $dumpvars(0, gates_tb);
    
    for(i=0; i<4; i++) begin
    ab = i[1:0];
    {a, b} = ab;
    
    #5;
    
    check(y_and, expected_and(a, b), $sformatf("AND (ab=%02b)", ab));
    check(y_or, expected_or(a,b), $sformatf("OR (ab=%02b)", ab));
    check(y_xor, expected_xor(a,b), $sformatf("XOR (ab=%02b)", ab));
    #5;
    
    end
    $display("--- Test Complete ---");
$finish;
end
endmodule
