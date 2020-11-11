`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2020 18:20:53
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input reset,
    input [2:0] Rs, Rd, Write_Reg, 
    input [7:0] Write_Data,
    input Reg_Write,
    output reg [7:0] Data1, Data2
    );
    reg [7:0] Register [0:7]; 
    integer k = 0;
    initial begin
    for(k = 0; k < 8; k = k + 1)                             // Initially, R1 = 1, R2 = 2, R3 = 3 and so on
         Register[k] <= k;   
    end
    always @( Rs or Rd or Write_Reg or Write_Data)begin
       if (reset == 1)begin                                  // If reset is activated, load default values R1 = 1, R2 = 2, R3 = 3 and so on
       for(k = 0; k < 8; k = k + 1)
         Register[k] <= k;
       end 
       else if (reset == 0 && Reg_Write == 1)begin           // If reset not activated, perform normal write operation
            Register[Write_Reg] = Write_Data; 
       end
       if(Rs == Write_Reg)Data1 = Write_Data;
       if(Rd == Write_Reg)Data2 = Write_Data;
       else begin
       Data1 <= Register[Rs];                                // Performs read operation
       Data2 <= Register[Rd];
       end
    end
        
endmodule
