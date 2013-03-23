`include "global_def.h"

module Writeback(
  I_CLOCK,
  I_LOCK,
  I_Opcode,
  I_ALUOut,
  I_MemOut,
  I_DestRegIdx,
  I_FetchStall,
  I_DepStall,
  O_WriteBackEnable,
  O_WriteBackRegIdx,
  O_WriteBackData
);

/////////////////////////////////////////
// IN/OUT DEFINITION GOES HERE
/////////////////////////////////////////
//
// Inputs from the memory stage
input I_CLOCK;
input I_LOCK;
input I_FetchStall;
input [`OPCODE_WIDTH-1:0] I_Opcode;
input [3:0] I_DestRegIdx;
input [`REG_WIDTH-1:0] I_ALUOut;
input [`REG_WIDTH-1:0] I_MemOut;
input I_DepStall;

// Outputs to the decode stage
output O_WriteBackEnable;
output [3:0] O_WriteBackRegIdx;
output [`REG_WIDTH-1:0] O_WriteBackData;

/////////////////////////////////////////
// ## Note ##
// - Assign output signals depending on opcode.
// - A few examples are provided.
/////////////////////////////////////////
assign O_WriteBackEnable = 
  ((I_LOCK == 1'b1) && (I_FetchStall == 1'b0)) ? 
    ((I_DepStall == 1'b0) ?
      ((I_Opcode == `OP_ADD_D ) ? (1'b1) :
       (I_Opcode == `OP_ADDI_D) ? (1'b1) :
       (I_Opcode == `OP_MOVI_D) ? (1'b1) :
       /////////////////////////////////////////////
       // TODO: Complete other instructions
       /////////////////////////////////////////////
       (I_Opcode == `OP_JSRR  ) ? (1'b0) : 
       (1'b0)
      ) : (1'b0)
    ) : (1'b0);

assign O_WriteBackRegIdx = 
  ((I_LOCK == 1'b1) && (I_FetchStall == 1'b0)) ? 
    ((I_DepStall == 1'b0) ?
      ((I_Opcode == `OP_ADD_D ) ? (I_DestRegIdx) :
       (I_Opcode == `OP_ADDI_D) ? (I_DestRegIdx) :
       (I_Opcode == `OP_MOVI_D) ? (I_DestRegIdx) :
       /////////////////////////////////////////////
       // TODO: Complete other instructions
       /////////////////////////////////////////////
       (I_Opcode == `OP_LDB   ) ? (I_DestRegIdx) : 
       (4'h0)
      ) : (1'b0)
    ) : (1'b0);

assign O_WriteBackData = 
  ((I_LOCK == 1'b1) && (I_FetchStall == 1'b0)) ? 
    ((I_DepStall == 1'b0) ?
      ((I_Opcode == `OP_ADD_D ) ? (I_ALUOut) :
       (I_Opcode == `OP_ADDI_D) ? (I_ALUOut) :
       (I_Opcode == `OP_MOVI_D) ? (I_ALUOut) :
       /////////////////////////////////////////////
       // TODO: Complete other instructions
       /////////////////////////////////////////////
       (I_Opcode == `OP_LDB   ) ? (I_MemOut) : 
       (16'h0000)
      ) : (1'b0)
    ) : (1'b0);

endmodule // module Writeback
