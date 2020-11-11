`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2020 22:19:15
// Design Name: 
// Module Name: Signal_Generator
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


module Main_Control_Unit(
    input clk,
    input reset,
    input [1:0] Opcode,
    output reg ALU_Op, Reg_Write, PC_Src
    );
   
    reg ALUOp1, RegWrite1, RegWrite2, ALUOp2, RegWrite3;  
    always @(Opcode)begin
    if(reset == 1) PC_Src <= 0;
    else PC_Src <= Opcode[1];
    end
    always @(posedge clk)begin
    if(reset == 1) begin
        ALUOp1 <= 0;
        RegWrite1 <= 0;
        RegWrite2 <= 0;
        Reg_Write <= 0;
        RegWrite3 <= 0;
        ALUOp2 <= 0;
        ALU_Op <= 0;
    end
    else begin
        ALUOp1 <= Opcode[0];                             // ALU_Op is 0 for mov, 1 for add
        ALUOp2 <= ALUOp1;                               // Reg_Write is 1 for mov and add, 0 for J-type
        RegWrite1 <= ~(Opcode[0] & Opcode[1]);          // PC_Src is 1 for J-type, 0 for mov and add
        RegWrite2 <= RegWrite1;
        RegWrite3 <= RegWrite2;
        Reg_Write <= RegWrite2;
        ALU_Op <= ALUOp1;
    end
    end
endmodule
