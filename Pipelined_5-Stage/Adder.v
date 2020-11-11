`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2020 20:04:20
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
    input [7:0] Data1_Final,
    input [7:0] Data2_Final,
    output reg [7:0] ALU_Result,
    input ALU_Op
    );
// If ALU_Op is 0 (denoting a mov operation), Output is (Data-1)
// If ALU_Op is 1 (denoting an add operation), Output is (Dara-1 + Data-2)
always @(Data1_Final or Data2_Final or ALU_Op)begin
    if(ALU_Op == 1) ALU_Result <= (Data1_Final + Data2_Final);
    else if (ALU_Op == 0) ALU_Result <= Data1_Final;
end
endmodule
