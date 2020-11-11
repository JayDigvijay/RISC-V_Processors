`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2020 19:52:38
// Design Name: 
// Module Name: Main
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


module Main_Processor( input rst,
    input clk,
    output reg [31:0] PC, 
    /////////DATA_LINES
    output wire [5:0] opcode,  funct,
    output wire [4:0] Rd, Rs1, Rs2, Shamt,
    output [20:0] Constant,
    output [31:0] WData, Data1, Data2, ALUResult, Shamt_Ext, Const_Ext, Data2_Final, Instr_C,
    /////////CONTROL_SIGNALS
    output RegWrite, Op_Select, ALU_Src,
    output [3:0] ALU_Op    
    );
/////////Execution
always @(posedge clk) begin
    if(rst == 0)PC <= PC + 4;
    else if (rst == 1)PC <= 0;  
end
InstrFetch IF(rst, clk, PC, opcode, funct, Rd, Rs1, Rs2, Shamt, Constant, Instr_C);
SignExtension_21 SE21 (Constant, Const_Ext);
SignExtension_5 SE5 (Shamt, Shamt_Ext);
MainControlUnit MCU (funct, opcode, ALU_Src, RegWrite, Op_Select, ALU_Op);
RegisterFile RF (Rs1, Rs2, Rd, WData, RegWrite, Data1, Data2); 
MUX2to1 Mux2 (Shamt_Ext, Data2, ALU_Src, Data2_Final);
ALU alu(Data1, Data2_Final, ALU_Op, ALUResult);  
MUX2to1 Mux1 (ALUResult, Const_Ext, Op_Select, WData);
endmodule
