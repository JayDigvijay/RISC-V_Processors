`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2020 21:21:17
// Design Name: 
// Module Name: InstrFetch
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


module InstrFetch(
input reset,
input clk,
input [31:0] PC,
output reg [5:0] opcode,  funct,
output reg [4:0] Rd, Rs1, Rs2, Shamt,
output reg [20:0] Constant,
output reg [31:0] Instruction_Code
);
reg [7:0] Mem [0:19];
always @(PC or posedge clk)begin
Mem[3] <= 8'hfc; Mem[2] <= 8'h00; Mem[1] <= 8'h00; Mem[0] <= 8'h08;
Mem[7] <= 8'h00; Mem[6] <= 8'h20; Mem[5] <= 8'h00; Mem[4] <= 8'h42;
Mem[11] <= 8'h00; Mem[10] <= 8'h40; Mem[9] <= 8'h00; Mem[8] <= 8'h80;
Mem[15] <= 8'h00; Mem[14] <= 8'h62; Mem[13] <= 8'h00; Mem[12] <= 8'h22;
Mem[19] <= 8'h00; Mem[18] <= 8'h02; Mem[17] <= 8'h08; Mem[16] <= 8'h24;
   Instruction_Code = {Mem[PC+3], Mem[PC+2], Mem[PC+1], Mem[PC+0]};
   Constant <= Instruction_Code[20:0];
   funct <= Instruction_Code[5:0];
   Shamt <= Instruction_Code[10:6];
   Rs2 <= Instruction_Code[15:11];
   Rs1 <= Instruction_Code[20:16];
   Rd <= Instruction_Code[25:21];
   opcode <= Instruction_Code[31:26];
end
endmodule
