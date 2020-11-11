`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2020 21:59:14
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] Data1,
    input [31:0] Data2,
    input [3:0] ALU_Op,
    output reg [31:0] ALUResult
    );
always @(Data1 or Data2 or ALU_Op)
    begin
        if(ALU_Op == 4'b0000)                   ///sll
            ALUResult = Data1 << Data2;
        else if(ALU_Op == 4'b0010)            ///srl
            ALUResult = Data1 >> Data2;
        else if(ALU_Op == 4'b1100)             ///AND
            ALUResult = Data1 & Data2;
        else if(ALU_Op == 4'b1000)            ///add
            ALUResult = Data1 + Data2;
        else if(ALU_Op == 4'b1010)           ///sub
            ALUResult = Data1 - Data2;
        else if(ALU_Op == 4'b1101)           ///OR
            ALUResult = Data1 | Data2;
        else ALUResult = 32'b0;

    end
endmodule
