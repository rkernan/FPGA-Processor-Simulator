`include "global_def.h"

module Memory(
  I_CLOCK,
  I_LOCK,
  I_ALUOut,
  I_Opcode,
  I_DestRegIdx,
  I_DestValue,
  I_FetchStall,
  I_DepStall,
  O_LOCK,
  O_ALUOut,
  O_Opcode,
  O_MemOut,
  O_DestRegIdx,
  O_BranchPC,
  O_BranchAddrSelect,
  O_FetchStall,
  O_DepStall
);

/////////////////////////////////////////
// IN/OUT DEFINITION GOES HERE
/////////////////////////////////////////
//
// Inputs from the execute stage
input I_CLOCK;
input I_LOCK;
input [`REG_WIDTH-1:0] I_ALUOut;
input [`OPCODE_WIDTH-1:0] I_Opcode;
input [3:0] I_DestRegIdx;
input [`REG_WIDTH-1:0] I_DestValue;
input I_FetchStall;
input I_DepStall;

// Outputs to the writeback stage
output reg O_LOCK;
output reg [`REG_WIDTH-1:0] O_ALUOut;
output reg [`OPCODE_WIDTH-1:0] O_Opcode;
output reg [3:0] O_DestRegIdx;
output reg [`REG_WIDTH-1:0] O_MemOut;
output reg O_FetchStall;
output reg O_DepStall;

// Outputs to the fetch stage
output reg [`PC_WIDTH-1:0] O_BranchPC;
output reg O_BranchAddrSelect;

/////////////////////////////////////////
// WIRE/REGISTER DECLARATION GOES HERE
/////////////////////////////////////////
//
reg[`DATA_WIDTH-1:0] DataMem[0:`INST_MEM_SIZE-1];

/////////////////////////////////////////
// INITIAL STATEMENT GOES HERE
/////////////////////////////////////////
//
initial 
begin
  $readmemh("data.hex", DataMem);
end

/////////////////////////////////////////
// ALWAYS STATEMENT GOES HERE
/////////////////////////////////////////
//

/////////////////////////////////////////
// ## Note ##
// 1. Do the appropriate memory operations.
// 2. Provide Branch Target Address and Selection Signal to the fetch stage.
/////////////////////////////////////////
always @(negedge I_CLOCK)
begin
  O_LOCK <= I_LOCK;
  O_FetchStall <= I_FetchStall;

  if (I_LOCK == 1'b1)
  begin
    /////////////////////////////////////////////
    // TODO: Complete here 
    /////////////////////////////////////////////
  end else // if (I_LOCK == 1'b1)
  begin
    O_BranchAddrSelect <= 1'b0;
  end // if (I_LOCK == 1'b1)
end // always @(negedge I_CLOCK)

endmodule // module Memory
