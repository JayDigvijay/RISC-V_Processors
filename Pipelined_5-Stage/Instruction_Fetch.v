`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2020 13:08:40
// Design Name: 
// Module Name: Instruction_Fetch
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


module Instruction_Fetch(
    input [7:0] PC,
    input reset,
    output reg [7:0] Instruction_Code,
    output reg [1:0] Opcode,
    output reg [2:0] Rd,
    output reg [2:0] Rs,
    output reg [5:0] Partial_Address
    );
    reg [7:0] Mem [0:7];
    always @(PC or reset)begin
    ////// INSTRUCTION MEMORY  ///////
    Mem[0] <= 8'b00011011; // mov R3, R3
    Mem[1] <= 8'b01011011; // add R3, R3
    Mem[2] <= 8'b01010011; // add R2, R3
    Mem[3] <= 8'b11000101; // j L1
    Mem[4] <= 8'b00011010; // mov R3, R2
    Mem[5] <= 8'b01011010; // L1: add R3, R2
    
    ////// INSTRUCTION CODE //////
    
    Instruction_Code = Mem[PC];
    Rs = Instruction_Code[2:0];
    Rd = Instruction_Code[5:3];
    Opcode = Instruction_Code[7:6];
    Partial_Address = Instruction_Code[5:0];
    end
endmodule
