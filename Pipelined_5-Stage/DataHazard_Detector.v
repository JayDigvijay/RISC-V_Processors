module DataHazard_Detector(
    input [2:0] In0,
    input [2:0] In1,
    input [2:0] InRef,
    output reg [1:0] Signal_Forward
    );
    reg [1:0] Signal_Forward1;
// Signal_Forward has 2 bits:
// Bit-0 = 0 iff Rs of next instruction = Rd of current instruction, and vice versa
// Bit-1 = 1 iff Rd of next instruction = Rd of current instrcution, and vice versa
always @(In1 or In0 or InRef)begin
    if(In0 == InRef) Signal_Forward[0] <= 1;
    else if (InRef != In0) Signal_Forward[0] <= 0;
    if(In1 == InRef) Signal_Forward[1] <= 1;
    else if (InRef != In1) Signal_Forward[1] <= 0;
   
end
endmodule