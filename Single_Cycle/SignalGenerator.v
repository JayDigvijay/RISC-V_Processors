`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2020 20:28:28
// Design Name: 
// Module Name: SignalGenerator
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


module MainControlUnit(
    input [5:0] funct,
    input [5:0] opcode,
    output reg ALU_Src,
    output reg RegWrite,
    output reg Op_Select,
    output reg [3:0] ALU_Op
    );
    
 always @(opcode or funct)begin 
 Op_Select <= opcode;
 ALU_Src <= funct[5];
 ALU_Op <= {funct[5], funct[2:0]};
 RegWrite <= 1;
end

endmodule
