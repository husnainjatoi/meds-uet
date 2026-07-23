`timescale 1ns / 1ps

module leading_zero_counter_tb();

logic [31:0] num;
logic [5:0] count;

leading_zero_counter uut (.num(num), .count(count));

task automatic check(input logic [5:0] actual, expected, string name);
    if(actual !== expected)
        $display("[FAIL] %s: Actual = %0d, Expected = %0d at Time = %0t", name, actual, expected, $time);
    else
        $display("[PASS] %s: Value = %0d at Time = %0t", name, actual, $time);
endtask

function automatic logic [5:0] exp_lzc(input logic [31:0] val);
    logic [5:0] expected_count = 0;
    for(int i=31; i>=0; i--) begin
        if(val[i] == 1) break;
        expected_count++;
    end
    return expected_count;
endfunction

initial begin
    string test_name;

    num = 32'h00000000; #10;
    check(count, exp_lzc(num), "All Zeros (32'h00000000)");

    num = 32'h80000000; #10;
    check(count, exp_lzc(num), "Bit 31 Set (32'h80000000)");

    num = 32'h00008000; #10;
    check(count, exp_lzc(num), "Bit 15 Set (32'h00008000)");

    num = 32'h00000001; #10;
    check(count, exp_lzc(num), "Bit 0 Set (32'h00000001)");

    num = 32'hFFFFFFFF; #10;
    check(count, exp_lzc(num), "All Ones (32'hFFFFFFFF)");
    
    $display("\n--- Running 50 Random Vectors ---");
    
    for(int i=0; i<51; i++) begin
        num = $urandom(); #10;
        test_name = $sformatf("Random vector %0d (32'h%08h)", i+1, num);
        check(count, exp_lzc(num), test_name);
    end
    
    $finish;
    
end
endmodule
