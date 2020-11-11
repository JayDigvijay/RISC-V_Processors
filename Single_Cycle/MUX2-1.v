`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2020 19:18:19
// Design Name: 
// Module Name: MUX2-1
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


module MUX2to1(
    input [31:0] line0,
    input [31:0] line1,
    input line_select,
    output reg [31:0] out
    );
always @(line0 or line1)
    if(line_select == 1'b0)
        out = line0;
    else if(line_select == 1'b1)
        out = line1;
begin
end
endmodule
