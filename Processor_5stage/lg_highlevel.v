`include "global_def.h"

`timescale 1ns / 1ps

module lg_highlevel(
  CLOCK_27, 
  CLOCK_50,
  LEDR, LEDG,
  HEX0, HEX1, HEX2, HEX3 
);

/////////////////////////////////////////
// INPUT/OUTPUT DEFINITION GOES HERE
////////////////////////////////////
//
input	 [1:0] CLOCK_27;
input	 CLOCK_50;
output [9:0] LEDR;
output [7:0] LEDG;
output [6:0] HEX0, HEX1, HEX2, HEX3;

/////////////////////////////////////////
// TESTBENCH SIGNAL DECLARATION GOES HERE
/////////////////////////////////////////
//
reg test_clock;
initial begin
  test_clock = 1;
  #10000 $finish;
end

always begin 
  #20 test_clock = ~test_clock;
end

/////////////////////////////////////////
// WIRE/REGISTER DECLARATION GOES HERE
/////////////////////////////////////////
//

wire pll_c0;
wire pll_locked;

pll pll0(
  .inclk0 ( CLOCK_50 ),
  .c0     ( pll_c0 ),
  .locked ( pll_locked )
);

reg clk; // 1 Hz

reg [31:0] counter;
always @(posedge pll_c0) begin
  if (pll_locked == 0) begin
    counter <= 0;
    clk <= 0;
  end else begin 
    counter <= counter + 1;
    if (counter == 32'd10000000) begin
      counter <= 0;
      clk <= ~clk;
    end
  end
end

wire LOCK_FD;
wire [`PC_WIDTH-1:0] PC_FD;
wire [`IR_WIDTH-1:0] IR_FD;

wire [`PC_WIDTH-1:0] BranchPC_FM;
wire BranchAddrSelect_FM;
wire DepStallSignal_FD;
wire BranchStallSignal_FD;
wire FetchStall_FD;

Fetch Fetch0(
  .I_CLOCK(clk),
  .I_LOCK(pll_locked),
  .I_BranchPC(BranchPC_FM),
  .I_BranchAddrSelect(BranchAddrSelect_FM),
  .I_BranchStallSignal(BranchStallSignal_FD),
  .I_DepStallSignal(DepStallSignal_FD),
  .O_LOCK(LOCK_FD),
  .O_FetchStall(FetchStall_FD),
  .O_PC(PC_FD),
  .O_IR(IR_FD)
);

wire WritebackEnable_WD;
wire [3:0] WriteBackRegIdx_WD;
wire [`REG_WIDTH-1:0] WritebackData_WD;

wire LOCK_DE;
wire [`PC_WIDTH-1:0] PC_DE;
wire [`OPCODE_WIDTH-1:0] Opcode_DE;
wire [`REG_WIDTH-1:0] Src1Value_DE;
wire [`REG_WIDTH-1:0] Src2Value_DE;
wire [3:0] DestRegIdx_DE;
wire [`REG_WIDTH-1:0] DestValue_DE;
wire [`REG_WIDTH-1:0] Imm_DE;
wire FetchStall_DE;
wire DepStall_DE;

Decode Decode0(
  .I_CLOCK(clk),
  .I_LOCK(LOCK_FD),
  .I_FetchStall(FetchStall_FD),
  .I_PC(PC_FD),
  .I_IR(IR_FD),
  .I_WriteBackEnable(WritebackEnable_WD),
  .I_WriteBackRegIdx(WriteBackRegIdx_WD),
  .I_WriteBackData(WritebackData_WD),
  .O_DepStallSignal(DepStallSignal_FD),
  .O_BranchStallSignal(BranchStallSignal_FD),
  .O_LOCK(LOCK_DE),
  .O_FetchStall(FetchStall_DE),
  .O_PC(PC_DE),
  .O_Opcode(Opcode_DE),
  .O_DepStall(DepStall_DE),
  .O_Src1Value(Src1Value_DE),
  .O_Src2Value(Src2Value_DE),
  .O_DestRegIdx(DestRegIdx_DE),
  .O_DestValue(DestValue_DE),
  .O_Imm(Imm_DE)
);

wire LOCK_EM;
wire [`REG_WIDTH-1:0] ALUOut_EM;
wire [`OPCODE_WIDTH-1:0] Opcode_EM;
wire [3:0] DestRegIdx_EM;
wire [`REG_WIDTH-1:0] DestValue_EM;
wire FetchStall_EM;
wire DepStall_EM;

Execute Execute0(
  .I_CLOCK(clk),
  .I_LOCK(LOCK_DE),
  .I_FetchStall(FetchStall_DE),
  .I_PC(PC_DE),
  .I_Opcode(Opcode_DE),
  .I_Src1Value(Src1Value_DE),
  .I_Src2Value(Src2Value_DE),
  .I_DestRegIdx(DestRegIdx_DE),
  .I_DestValue(DestValue_DE),
  .I_Imm(Imm_DE),
  .I_DepStall(DepStall_DE),
  .O_LOCK(LOCK_EM),
  .O_FetchStall(FetchStall_EM),
  .O_ALUOut(ALUOut_EM),
  .O_Opcode(Opcode_EM),
  .O_DestRegIdx(DestRegIdx_EM),
  .O_DestValue(DestValue_EM),
  .O_DepStall(DepStall_EM)
);

wire LOCK_MW;
wire [`REG_WIDTH-1:0] ALUOut_MW;
wire [`OPCODE_WIDTH-1:0] Opcode_MW;
wire [`REG_WIDTH-1:0] MemOut_MW;
wire [3:0] DestRegIdx_MW;
wire FetchStall_MW;
wire DepStall_MW;

Memory Memory0(
  .I_CLOCK(clk),
  .I_LOCK(LOCK_EM),
  .I_FetchStall(FetchStall_EM),
  .I_ALUOut(ALUOut_EM),
  .I_Opcode(Opcode_EM),
  .I_DestRegIdx(DestRegIdx_EM),
  .I_DestValue(DestValue_EM),
  .I_DepStall(DepStall_EM),
  .O_BranchPC(BranchPC_FM),
  .O_BranchAddrSelect(BranchAddrSelect_FM),
  .O_LOCK(LOCK_MW),
  .O_FetchStall(FetchStall_MW),
  .O_ALUOut(ALUOut_MW),
  .O_Opcode(Opcode_MW),
  .O_MemOut(MemOut_MW),
  .O_DestRegIdx(DestRegIdx_MW),
  .O_DepStall(DepStall_MW),
  .O_LEDR(LEDR),
  .O_LEDG(LEDG),
  .O_HEX0(HEX0),
  .O_HEX1(HEX1),
  .O_HEX2(HEX2),
  .O_HEX3(HEX3)
);

Writeback Writeback0(
  .I_CLOCK(clk),
  .I_LOCK(LOCK_MW),
  .I_FetchStall(FetchStall_MW),
  .I_ALUOut(ALUOut_MW),
  .I_Opcode(Opcode_MW),
  .I_MemOut(MemOut_MW),
  .I_DestRegIdx(DestRegIdx_MW),
  .I_DepStall(DepStall_MW),
  .O_WriteBackEnable(WritebackEnable_WD),
  .O_WriteBackRegIdx(WriteBackRegIdx_WD),
  .O_WriteBackData(WritebackData_WD)
);

endmodule // module lg_highlevel
