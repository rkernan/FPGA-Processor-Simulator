`include "global_def.h"

module Execute(
  I_CLOCK,
  I_LOCK,
  I_PC,
  I_Opcode,
  I_Src1Value,
  I_Src2Value,
  I_DestRegIdx,
  I_Imm,
  I_DestValue,
  I_FetchStall,
  I_DepStall,
  O_LOCK,
  O_ALUOut,
  O_Opcode,
  O_DestRegIdx,
  O_DestValue,
  O_FetchStall,
  O_DepStall
);

/////////////////////////////////////////
// IN/OUT DEFINITION GOES HERE
/////////////////////////////////////////
//
// Inputs from the decode stage
input I_CLOCK;
input I_LOCK;
input [`PC_WIDTH-1:0] I_PC;
input [`OPCODE_WIDTH-1:0] I_Opcode;
input [3:0] I_DestRegIdx;
input [`REG_WIDTH-1:0] I_Src1Value;
input [`REG_WIDTH-1:0] I_Src2Value;
input [`REG_WIDTH-1:0] I_Imm;
input [`REG_WIDTH-1:0] I_DestValue;
input I_FetchStall;
input I_DepStall;

// Outputs to the memory stage
output reg O_LOCK;
output reg [`REG_WIDTH-1:0] O_ALUOut;
output reg [`OPCODE_WIDTH-1:0] O_Opcode;
output reg [3:0] O_DestRegIdx;
output reg [`REG_WIDTH-1:0] O_DestValue;
output reg O_FetchStall;
output reg O_DepStall;

/////////////////////////////////////////
// WIRE/REGISTER DECLARATION GOES HERE
/////////////////////////////////////////
//

/////////////////////////////////////////
// ALWAYS STATEMENT GOES HERE
/////////////////////////////////////////
//

/////////////////////////////////////////
// ## Note ##
// - Do the appropriate ALU operations.
/////////////////////////////////////////
always @(negedge I_CLOCK) begin
  O_LOCK <= I_LOCK;
  O_FetchStall <= I_FetchStall;

  if (I_LOCK == 1'b1)  begin
    /////////////////////////////////////////////
    // TODO: Complete here 
    /////////////////////////////////////////////
//    OP_ADD_D
//    OP_ADDI_D
//    OP_ADD_F
//    OP_ADDI_F
//    OP_VADD
//    OP_AND_D
//    OP_ANDI_D
//    OP_MOV
//    OP_MOVI_D
//    OP_MOVI_F
//    OP_VMOV
//    OP_VMOVI
//    OP_CMP
//    OP_CMPI
//    OP_VCOMPMOV
//    OP_VCOMPMOVI
//    OP_LDB
//    OP_LDW
//    OP_STB
//    OP_STW
//    OP_SETVERTEX
//    OP_SETCOLOR
//    OP_ROTATE
//    OP_TRANSLATE
//    OP_SCALE
//    OP_PUSHMATRIX
//    OP_POPMATRIX
//    OP_BEGINPRIMITIVE
//    OP_ENDPRIMITIVE
//    OP_LOADIDENTITY
//    OP_FLUSH
//    OP_DRAW
//    OP_BRN
//    OP_BRZ
//    OP_BRP
//    OP_BRNZ
//    OP_BRNP
//    OP_BRZP
//    OP_BRNZP
//    OP_JMP
//    OP_RET
//    OP_JSR
//    OP_JSRR
  end // if (I_LOCK == 1'b1)
end // always @(negedge I_CLOCK)

endmodule // module Execute
