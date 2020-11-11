`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2020 18:16:15
// Design Name: 
// Module Name: Register
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


module Pipeline_Register(
    input clk, reset,
    input [7:0] Old_Data1, Old_Data2,
    input [2:0] Old_Reg1, Old_Reg2,
    output reg [7:0] New_Data1, New_Data2,
    output reg [2:0] New_Reg1, New_Reg2
    );
    always@(posedge clk)begin
        if(reset == 1)begin
            New_Reg1 <= 3'b0;
            New_Reg2 <= 3'b0;
            New_Data1 <= 8'b0;
            New_Data2 <= 8'b0;
        end
        else if (reset == 0)begin
            New_Reg1 <= Old_Reg1;
            New_Reg2 <= Old_Reg2;
            New_Data1 <= Old_Data1;
            New_Data2 <= Old_Data2;
        end
    end
endmodule
