`define BUS_WIDTH 32
`define REG_WIDTH 16
`define MEM_ADDR_WIDTH 16
`define MEM_DATA_WIDTH 16
`define PC_ADDR_WIDTH 16 

`define INT_REG_NUM 8
`define FP_REG_NUM 8	  

`define INST_ADDR_SIZE 1024 
`define DATA_MEM_SIZE 1024

`define IR_WIDTH 32 

`define OPCODE_WIDTH 8

`define RET_REG_ID 7

`define CC_N 3'b001
`define CC_Z 3'b010
`define CC_P 3'b100

`define FORMAT_IR 3'b000
`define FORMAT_II 3'b001
`define FORMAT_FR 3'b100
`define FORMAT_FI 3'b101
`define FORMAT_VR 3'b010
`define FORMAT_VI 3'b111

`define FORMAT_LDST_B 3'b001
`define FORMAT_LDST_W 3'b010

`define OP_ADD      5'b00000
`define OP_AND      5'b00001
`define OP_MOV      5'b00010
`define OP_CMP      5'b00011
`define OP_VCOMPMOV 5'b00100
`define OP_LD       5'b00101
`define OP_ST       5'b00110
`define OP_BR       5'b11011
`define OP_JMP      5'b11100
`define OP_JSR      5'b11110
`define OP_JSRR     5'b11111

`define OP_SETVERTEX      5'b01000
`define OP_SETCOLOR       5'b01001
`define OP_ROTATE         5'b01010
`define OP_TRANSLATE      5'b01011
`define OP_SCALE          5'b01100
`define OP_PUSHMATRIX     5'b10000
`define OP_POPMATRIX      5'b10001
`define OP_BEGINPRIMITIVE 5'b10010
`define OP_ENDPRIMITIVE   5'b10011
`define OP_LOADIDENTITY   5'b10100
`define OP_FLUSH          5'b10110
`define OP_DRAW           5'b10111
