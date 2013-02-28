`include "global_def.h"

module datapath(clk, lock);
	input clk;
	input lock;
	// Define: Architecture Registers
	reg [`REG_WIDTH-1:0] REG_INT[`INT_REG_NUM-1:0];
	reg [`PC_ADDR_WIDTH-1:0] PC;
	reg [`REG_WIDTH-1:0] REG_FP[`FP_REG_NUM-1:0];
	reg [2:0] CC;
	reg [`IR_WIDTH:0] IR;
	// Initialize: Memory
	initial begin
		$readmemh("instructions.hex", INST_Mem);
		$readmemh("datamem.hex", Data_Mem);
	end
	// Define: Instruction Memory and Data Memory
	reg [31:0] INST_Mem[0:`INST_ADDR_SIZE-1];
	reg [15:0] Data_Mem[0:`DATA_MEM_SIZE-1];
	// Define: Signals
	reg [`PC_ADDR_WIDTH-1:0] Next_PC, Branch_PC;
	reg [`IR_WIDTH-1:0] Inst_data;
	reg [15:0] pc_addr;
	reg [4:0] src1_id, src2_id, dst_id;
	reg [15:0] imm, cmp1, cmp2;
	wire [`OPCODE_WIDTH-1:0] opcode;
	reg [15:0] reg_out, src1, src2;
	reg ld_reg; 
	reg set_cc;
	reg IR_branch; 
	reg [15:0] st_mem_addr, data_mem_addr; 
	// Initialize: PC, IR, and Registers
	initial begin
		Next_PC = 0; 
		IR_branch = 0;
		REG_INT[0] = 0;
		REG_INT[1] = 0;
		REG_INT[2] = 0;
		REG_INT[3] = 0;
		REG_INT[4] = 0;
		REG_INT[5] = 0;
		REG_INT[6] = 0;
		REG_INT[7] = 0;
	end
	always @(posedge clk) begin
		if (lock) begin
			// FETCH
			PC = Next_PC;
			pc_addr = (PC & 16'hff) >> 2;
			Inst_data = INST_Mem[pc_addr];
			IR = Inst_data;
			Next_PC = PC + 4;
			// INSTRUCTION DECODE AND REGISTER FETCH
			src1_id = IR[19:16];
			src2_id = IR[11:8];
			dst_id = IR[23:20];
			src1 = REG_INT[src1_id];
			src2 = REG_INT[src2_id];
			imm = IR[15:0];
			// EXECUTE
			case (IR[31:27])
				// add
				`OP_ADD: begin
					if (IR[26:24] == `FORMAT_IR) reg_out = src1 + src2;
					if (IR[26:24] == `FORMAT_II) reg_out = src1 + imm;
					ld_reg = 1;
					// set CC
					cmp1 = reg_out;
					cmp2 = 0;
					set_cc = 1;
					// TODO test
				end
				// and
				`OP_AND: begin
					if (IR[26:24] == `FORMAT_IR) reg_out = src1 & src2;
					if (IR[26:24] == `FORMAT_II) reg_out = src1 & imm;
					ld_reg = 1;
					// set CC
					cmp1 = reg_out;
					cmp2 = 0;
					set_cc = 1;
					// TODO test
				end
				// mov
				`OP_MOV: begin
					if (IR[26:24] == `FORMAT_IR) reg_out = src2;
					if (IR[26:24] == `FORMAT_II) reg_out = imm;
					ld_reg = 1;
					dst_id = src1_id;
					// set CC
					cmp1 = reg_out;
					cmp2 = 0;
					set_cc = 1;
					// TODO test
				end
				// ld
				`OP_LD: begin
					if (IR[26:24] == `FORMAT_LDST_W) reg_out = Data_Mem[src1 + imm];
					ld_reg = 1;
					// set CC
					cmp1 = reg_out;
					cmp2 = 0;
					set_cc = 1;
					// TODO test
				end
				// st
				`OP_ST: begin
					if (IR[26:24] == `FORMAT_LDST_W) Data_Mem[src1 + imm] = REG_INT[dst_id];
					// TODO test
				end
				// br
				`OP_BR: begin
					if (IR[26:24] & CC) Next_PC = Next_PC + imm << 2;
					// TODO test
				end
				// jmp
				`OP_JMP: begin
					Next_PC = src1;
					// TODO test
				end
				// jsr
				`OP_JSR: begin
					reg_out = Next_PC;
					dst_id = `RET_REG_ID;
					ld_reg = 1;
					Next_PC = Next_PC + imm << 2;
					// TODO test
				end
				// jsrr
				`OP_JSRR: begin
					reg_out = Next_PC;
					dst_id = `RET_REG_ID;
					ld_reg = 1;
					Next_PC = src1;
					// TODO test
				end
			endcase
		end
	end
	// STORE
	always @(negedge clk) begin
		// store register values
		if (ld_reg) begin
			REG_INT[dst_id] = reg_out;
			ld_reg = 0;
		end
		// set Condition Code
		if (set_cc) begin
			if (cmp1 < cmp2)
				CC = `CC_N;
			else if (cmp1 > cmp2)
				CC = `CC_P;
			else
				CC = `CC_Z;
			set_cc = 0;
		end
	end
endmodule
