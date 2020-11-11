`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2020 13:04:27
// Design Name: 
// Module Name: Main_Processor
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
// A = 3, B = 1, C = 7
// x = 3, y = 3, z = 2

// 
//////////////////////////////////////////////////////////////////////////////////


module Main_Processor(
    input clk, reset,
    output reg [7:0] PC,
    output [7:0] Instruction_Code,Write_Data ,Data1_Final, Data2_Final ,
    output [5:0] Jump_Address, 
    output [2:0] Rs_New, Rd_New, Write_Reg,
    output PC_Src, ALU_Op, Reg_Write, 
    output [1:0] Signal_Forward
    );
    wire [7:0] Data1_Old ,Data2_Old , ALU_Result ,Data1_New ,Data2_New  ;
    wire [2:0] Rs_Old, Rd_Old, Rd_New2;
    wire [1:0] Opcode;
    integer k = 0;
    always @(posedge clk)begin                                                                               // Calculate PC at Positive Edge of Clock
    if(reset == 1)PC <= 0;                                                                                   
    else if(reset == 0)begin
                                                                        
        if(k > 0) PC <= PC + 1;                                                  // If PC_Src == 0 indicating no J-Type instruction, increment PC by 1
        else if (k == 0) PC <= 0;
        if (PC_Src == 1)PC <= {PC[7:6], Jump_Address};                                          //Check for Jump (J-Type) and modify PC Accordingly
      
    end
    k = k + 1;
    end
    Instruction_Fetch IF(PC, reset, Instruction_Code, Opcode, Rd_Old, Rs_Old, Jump_Address);       //Fetch the value of Instruction Code, OpCode, etc. 
    Main_Control_Unit MCU(clk, reset, Opcode, ALU_Op, Reg_Write, PC_Src);                     // Generates required signals- ALU_Op, Reg_Write, PC_Src
    Pipeline_Register IF_ID(clk, reset, , , Rs_Old, Rd_Old, , , Rs_New, Rd_New);                                  //Store in Pipieline Register IF/ID
    Register_File RF(reset, Rs_New, Rd_New, Write_Reg, Write_Data, Reg_Write, Data1_Old, Data2_Old); //Get the values stored in Rs and Rd, write output in Rd (Write_Reg)
    Pipeline_Register ID_EX(clk, reset, Data1_Old, Data2_Old, Rd_New, , Data1_New, Data2_New, Rd_New2, );         //Store in Pipieline Register ID/EX
    DataHazard_Detector Comparator(Rs_New, Rd_New, Rd_New2, Signal_Forward);        //Compares current Rd with next Rd and Rs to check for Data Hazard
    ALU Add(Data1_Final, Data2_Final, ALU_Result, ALU_Op);                                                                      //Execution (Addition)
    Forwarding_Unit FU(ALU_Result, Data1_New, Data2_New, Data1_Final, Data2_Final, Signal_Forward, ALU_Op); // Gives input to ALU depending on Data Hazard
    Pipeline_Register EX_WB(clk, reset, ALU_Result, , Rd_New2, , Write_Data, , Write_Reg, );                      //Store in Pipieline Register ID/EX
    
endmodule
