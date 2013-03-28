`include "global_def.h"

module Fetch(
  I_CLOCK,
  I_LOCK,
  I_BranchPC,
  I_BranchAddrSelect,
  I_BranchStallSignal,
  I_DepStallSignal,
  O_LOCK,
  O_PC,
  O_IR,
  O_FetchStall
);

/////////////////////////////////////////
// IN/OUT DEFINITION GOES HERE
/////////////////////////////////////////
//
// Inputs from high-level module (lg_highlevel)
input I_CLOCK;
input I_LOCK;

// Inputs from the memory stage 
input [`PC_WIDTH-1:0] I_BranchPC; // Branch Target Address
input I_BranchAddrSelect; // Asserted only when Branch Target Address resolves

// Inputs from the decode stage
input I_BranchStallSignal; // Asserted from when branch instruction is decode to when Branch Target Address resolves 
input I_DepStallSignal; // Asserted when register dependency is detected

// Outputs to the decode stage
output reg O_LOCK;
output reg [`PC_WIDTH-1:0] O_PC;
output reg [`IR_WIDTH-1:0] O_IR;

/////////////////////////////////////////
// ## Note ##
// O_FetchStall: Asserted when fetch stage is not updating FE/DE latch. 
// - The instruction with O_FetchStall == 1 will be treated as NOP in the following stages
/////////////////////////////////////////
output reg O_FetchStall; 
 
/////////////////////////////////////////
// WIRE/REGISTER DECLARATION GOES HERE
/////////////////////////////////////////
//
reg[`INST_WIDTH-1:0] InstMem[0:`INST_MEM_SIZE-1];
reg[`PC_WIDTH-1:0] PC;  

/////////////////////////////////////////
// INITIAL/ASSIGN STATEMENT GOES HERE
/////////////////////////////////////////
//
initial begin
//  $readmemh("test0.hex", InstMem);
  $readmemh("grading_asm.hex", InstMem);
  PC = 16'h0;
  O_LOCK = 1'b0;
  O_PC = 16'h4;
  O_IR = 32'hFF000000;
end

/////////////////////////////////////////
// ALWAYS STATEMENT GOES HERE
/////////////////////////////////////////
//

/////////////////////////////////////////
// ## Note ##
// 1. Update output values (O_FetchStall, O_PC, O_IR) and PC.
// 2. You should be careful about STALL signals.
/////////////////////////////////////////
always @(negedge I_CLOCK) begin
  O_LOCK <= I_LOCK;
  
  if (I_LOCK == 0) begin
    PC <= 0;
    O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
    O_PC <= 16'h4;
  end else begin // if (I_LOCK == 0)
    /////////////////////////////////////////////
    // TODO: Complete here
    /////////////////////////////////////////////
    $display("");
    O_FetchStall <= ((I_BranchStallSignal == 1 && I_BranchAddrSelect != 1) || I_DepStallSignal == 1) ? (1'b1) : (1'b0);
    if ((I_BranchStallSignal == 1  && I_BranchAddrSelect != 1) || I_DepStallSignal == 1) begin
      //nop
    end else begin
      if (I_DepStallSignal == 1) begin
        // don't increment PC
        $display("IF: PC = PC");
        O_PC <= PC + 16'h4;
        O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
      end else begin
        if (I_BranchAddrSelect == 1) begin
          $display("IF: PC = BranchPC + (1 << 2)");
          O_PC <= I_BranchPC + 16'h4;
          O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
          PC <= I_BranchPC;
        end else begin
          $display("IF: PC = PC + (1 << 2)");
          O_PC <= PC + 16'h8;
          O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
          PC <= PC + 16'h4;
        end
      end
    end
  end // if (I_LOCK == 0)
end // always @(negedge I_CLOCK)

endmodule // module Fetch
