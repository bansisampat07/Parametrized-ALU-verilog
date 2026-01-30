`timescale 1ns / 1ps

module alu_tb;

    parameter width = 4;
    reg [width-1:0] A,B;
    reg [2:0] OpCode;
    wire [width-1:0] res;
    wire zero, carry, overflow, neg;
    
    alu #(width) uut (
        .A(A), .B(B), .OpCode(OpCode),
        .res(res), .carry(carry), .overflow(overflow),
        .zero(zero), .neg(neg)
    );
    
    task check;
        input [width-1:0] in_a, in_b;
        input [2:0] in_op;
        input [width-1:0] exp_res;
        input exp_c, exp_v, exp_z, exp_n;
        begin
            A = in_a; B = in_b; OpCode = in_op;
            
            #10;
            
            if(res !== exp_res || carry !== exp_c || overflow !== exp_v) begin
            $display("FAIL: Op=%b, A=%d, B=%d", OpCode, A, B);
            $display("Expected op: Res=%d, C=%b, V=%b, Z=%b, N=%b", exp_res, exp_c, exp_v, exp_z, exp_n);
            $display("Calculated op: Res=%d, C=%b, V=%b, Z=%b, N=%b", res, carry , overflow, zero, neg);
            end else begin
                $display("PASS for A = %d, B = %d, OpCode = %b, Result = %b, C=%b, Z=%b, V=%b, N=%b", A,B,OpCode,res,carry,zero,overflow,neg);
                end
         end
      endtask
      
      initial begin

        check(4'd15, 4'd1, 3'b000, 4'd0, 1, 0, 0, 0);
        check(4'd5, 4'd5, 3'b001, 4'd0, 0, 0, 1, 0);
        check(4'd4, 4'd4, 3'b000, 4'b1000, 0, 1, 0, 1);      
        check(4'd3, 4'd2, 3'b111, 4'd0, 0, 0, 1, 0);      
        check(4'b1010, 4'b1100, 3'b010, 4'b1000, 0, 0, 0, 1);
        check(4'b1010, 4'b1100, 3'b011, 4'b1110, 0, 0, 0, 1);
        check(4'b1010, 4'b1100, 3'b100, 4'b0110, 0, 0, 0, 0);
        check(4'b1010, 4'b0000, 3'b101, 4'b0100, 0, 0, 0, 0);
        
        $finish;
        end
        
endmodule
