`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2020 00:28:22
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input [4:0] Rs1,
    input [4:0] Rs2,
    input [4:0] Rd,
    input [31:0] WData,
    input RegWrite,
    output reg [31:0] Data1,
    output reg [31:0] Data2
    );
reg [31:0] Register [0:31];
integer i;

initial begin
for(i = 0; i < 32; i = i+1)
    Register[i] <= 32'b0;
end
always @(Rs1 or Rs2 or RegWrite or Rd or WData)
begin
     
    Data1 = Register[Rs1];
    Data2 = Register[Rs2];
    Register[Rd] = WData;
     
    
end    
endmodule
