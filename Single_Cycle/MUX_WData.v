`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2020 16:43:38
// Design Name: 
// Module Name: MUX_WData
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


module MUX_WData(
    input [31:0] ALU_Result,
    input [31:0] Const_Ext,
    input  Op_Select,
    output reg [31:0] WData
    );
always @(ALU_Result or Const_Ext)begin
    if(Op_Select == 0) WData = ALU_Result;
    else if(Op_Select == 1) WData = Const_Ext;
end
endmodule
