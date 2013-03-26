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
  O_DepStall <= I_DepStall;

  if (I_LOCK == 1'b1)  begin
    /////////////////////////////////////////////
    // TODO: Complete here 
    /////////////////////////////////////////////
    if (!I_DepStall & !I_FetchStall) begin
      // send Opcode on
      O_Opcode <= I_Opcode;
      // execute IR
      case (I_Opcode)
        `OP_ADD_D: begin
          // add
          O_ALUOut <= I_Src1Value + I_Src2Value;
          // pass values on
          O_DestRegIdx <= I_DestRegIdx;
        end
        `OP_ADDI_D: begin
          // add immediate
          O_ALUOut <= I_Src1Value + I_Imm;
          // pass values in
          O_DestRegIdx <= I_DestRegIdx;
        end
        `OP_AND_D: begin
          // and
          O_ALUOut <= I_Src1Value & I_Src2Value;
          // pass values on
          O_DestRegIdx <= I_DestRegIdx;
        end
        `OP_ANDI_D: begin
          // and immediate
          O_ALUOut <= I_Src1Value & I_Imm;
          // pass values on
          O_DestRegIdx <= I_DestRegIdx;
        end
        `OP_MOV: begin
          // move
          O_ALUOut <= I_Src1Value;
          // pass values on
          O_DestRegIdx <= I_DestRegIdx;
        end
        `OP_MOVI_D: begin
          // move immediate
          O_ALUOut <= I_Src1Value;
          // pass values on
          O_DestRegIdx <= I_DestRegIdx;
        end
        `OP_LDW: begin
          // calculate memory address
          O_ALUOut <= I_Src1Value + I_Imm;
          // pass values on
          O_DestRegIdx <= I_DestRegIdx;
        end
        `OP_STW: begin
          // calculate memory address
          O_ALUOut <= I_Src1Value + I_Imm;
          // pass values on
          O_DestValue <= I_DestValue;
        end
        `OP_BRN, `OP_BRZ, `OP_BRP, `OP_BRNZ, `OP_BRNP, `OP_BRZP, `OP_BRNZP: begin
          // When should the branch be handled?
          // TODO Implement branch.
        end
        `OP_JMP: begin
          // When should the branch be handled?
          // TODO Implement branch.
        end
        `OP_JSR: begin
          // pass values on
          O_ALUOut <= I_Src1Value;
          O_DestRegIdx <= I_DestRegIdx;
          // When should the branch be handled?
          // TODO Implement branch.
        end
        `OP_JSRR: begin
          // pass values on
          O_ALUOut <= I_Src1Value;
          O_DestRegIdx <= I_DestRegIdx;
          // When should the branch be handled?
          // TODO Implement branch.
        end
      endcase
    end
  end // if (I_LOCK == 1'b1)
end // always @(negedge I_CLOCK)

endmodule // module Execute
