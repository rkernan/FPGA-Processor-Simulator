
`include "global_def.h"

module datapath(clk, lock);

input clk;
input lock;



/* architecture registers */ 


reg [`REG_WIDTH-1:0] REG_INT[`INT_REG_NUM-1:0];
reg [`PC_ADDR_WIDTH-1:0] PC;
reg [`REG_WIDTH-1:0] REG_FP[`FP_REG_NUM-1:0];
reg [2:0] CC; 
reg [`IR_WIDTH:0] IR; 


/* initialize memories */ 

initial 
begin 
	$readmemh("instructions.hex", INST_Mem);
	$readmemh("datamem.hex", Data_Mem);
end

/* instruction Memory  & Data Memory */ 
reg [31:0] INST_Mem[0:`INST_ADDR_SIZE-1];
reg [15:0] Data_Mem[0:`DATA_MEM_SIZE-1];

	/* internal signals */
	
	reg [`PC_ADDR_WIDTH-1:0] Next_PC, Branch_PC; 
	reg [`IR_WIDTH-1:0] Inst_data; 
	reg [15:0] pc_addr; 
	
	reg [4:0]src1_id,
				src2_id,
				dst_id; 
				 
	wire [`OPCODE_WIDTH-1:0] opcode; 
	
	reg [15:0] reg_out,
				  src1,
				  src2;
	
	
	reg ld_reg; 
	
	reg IR_branch; 
	
	reg [15:0] st_mem_addr, data_mem_addr; 
	
	/* initialization */
	
	initial 
	begin 
		Next_PC = 0; 
		IR_branch = 0;
		REG_INT[0] = 0;
		
		REG_INT[0] = 0;
		REG_INT[1] = 0;
		REG_INT[2] = 0;
		REG_INT[3] = 0; 
		REG_INT[4] = 0;
		REG_INT[5] = 0;
		REG_INT[6] = 0;
		REG_INT[7] = 0; 
	end 
	
	
	/* instruction access */ 
	

	/* fetch_stage */ 
	always @(posedge clk)
	begin 
	
		if (lock) begin 
			PC = Next_PC;
			pc_addr = (PC & 16'hff) >> 2; // (32-bit addressible))
				
			Inst_data = INST_Mem[pc_addr];
			IR = Inst_data; 

	
			Next_PC = PC+4;
		
		
	
	
	
		/* decode stage */
		/* read source values */ 
		
		src1_id = IR[19:16];
		src2_id = IR[11:8];
		dst_id = IR[23:20];
		
		
		src1 = REG_INT[src1_id];
		src2 = REG_INT[src2_id];
		

		/* execution */ 
		case(IR[31:27]) 
				
			`OP_ADD: begin
				reg_out = src1 + src2; 
				ld_reg=1; 
			end
			/* need to complete other instructions */
			
			
		endcase
	end
end
	

		
	
	
	
endmodule



