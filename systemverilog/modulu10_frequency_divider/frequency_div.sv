`timescale 1ns / 1ps

module t_ff(
    input logic t, clk, rst,
    output logic q
    );
    
    always_ff @(posedge clk) begin
        if(!rst)
            q <= 1'b0;
        else if(t)
            q <= ~q;
        else 
            q <= q;
    end
endmodule

module mod10_divider(
    input logic clk, rst,
    output logic div_out);
    logic q0, q1, q2, q3;
    logic t0, t1, t2, t3;

    assign t0 = 1'b1;
    assign t1 = q0 & ~q3;
    assign t2 = q0 & q1;
    assign t3 = (q0 & q1 & q2) | (q0 & q3);
    assign div_out = q3 & q0;
    
    t_ff ff1 (.q(q0), .t(t0), .clk(clk), .rst(rst));
    t_ff ff2 (.q(q1), .t(t1), .clk(clk), .rst(rst));
    t_ff ff3 (.q(q2), .t(t2), .clk(clk), .rst(rst));
    t_ff ff4 (.q(q3), .t(t3), .clk(clk), .rst(rst));

endmodule
