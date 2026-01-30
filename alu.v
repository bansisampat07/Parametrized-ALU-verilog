`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2026 12:37:06
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu #(parameter width = 4)(
    input [width-1:0] A,
    input [width-1:0] B,
    input [2:0] OpCode,
    output reg [width-1:0] res,
    output reg zero,
    output reg carry,
    output reg overflow,
    output reg neg
);

always @(*) begin
    carry = 0;
    overflow = 0;
    
    case(OpCode)
        3'b000: begin //ADD
            {carry, res} = A + B;
            overflow = ~(A[width-1]^B[width-1]) & (A[width-1]^res[width-1]);
            end
        3'b001: begin //SUB
            {carry, res} = A - B;
            overflow = (A[width-1]^B[width-1]) & (A[width-1]^res[width-1]);
            end
        3'b010: res = A & B; //AND
        3'b011: res = A | B; //OR
        3'b100: res = A ^ B; //XOR
        3'b101: res = A << 1; //Left shift
        3'b110: res = A >> 1; //Right shift
        3'b111: res = A < B; //Compare
        default res = 0;
     endcase
        
        zero = (res == 0);
        neg = res[width-1];
    end  
    
endmodule
