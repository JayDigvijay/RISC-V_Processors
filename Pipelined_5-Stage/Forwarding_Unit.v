module Forwarding_Unit(
    input [7:0] ALU_Result,
    input [7:0] Data1_New,
    input [7:0] Data2_New,
    output reg [7:0] Data1_Final,
    output reg [7:0] Data2_Final,
    input [1:0] Signal_Forward,
    input ALU_Op
    );
// Takes Signal_Forward as Input, and according to it's value, 
// the value of ALU_Result is used as Input-1 or Input-2 or both to ALU (Adder)
always @(Data1_New or Data2_New or ALU_Op)begin
    if(Signal_Forward == 2'b01)begin 
        Data1_Final <= ALU_Result;
        Data2_Final <= Data2_New;
    end
    else if(Signal_Forward == 2'b10)begin 
        Data2_Final <= ALU_Result;
        Data1_Final <= Data1_New;
    end
    else if(Signal_Forward == 2'b11)begin 
        Data2_Final <= ALU_Result;
        Data1_Final <= ALU_Result;
    end
    else begin 
        Data2_Final <= Data2_New;
        Data1_Final <= Data1_New;
    end
end
endmodule