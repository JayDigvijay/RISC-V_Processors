`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2020 22:49:54
// Design Name: 
// Module Name: SignExtension_5
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


module SignExtension_5(
    input [4:0] shamt,
    output reg [31:0] shamt_extended
    );
always @(shamt)
begin
if(shamt[4] == 0)
    shamt_extended <= {27'b0, shamt};
else
    shamt_extended <= {27'b1, shamt};
end
endmodule
