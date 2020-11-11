`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2020 19:50:03
// Design Name: 
// Module Name: SignExtension_21
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


module SignExtension_21(
    input [20:0] const,
    output reg [31:0] const_extended
    );
always @(const)
begin
if(const[20] == 0)
    const_extended <= {11'b0, const};
else
    const_extended <= {11'b1, const};
end
endmodule
