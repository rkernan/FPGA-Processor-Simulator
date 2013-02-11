#ifndef __SIMULATOR_H
#define __SIMULATOR_H

#include <string>

#define PC_IDX 15
#define LR_IDX 7

#define NUM_VECTOR_ELEMENTS 4
#define MEMORY_SIZE (1024*1024)

#define NUM_SCALAR_REGISTER 16
#define NUM_VECTOR_REGISTER 64

#define NUM_OPS 43

enum OpCodes {
  OP_ADD_D = 0,
  OP_ADDI_D = 1,
  OP_ADD_F = 4,
  OP_ADDI_F = 5,
  OP_VADD = 2,
  OP_AND_D = 8,
  OP_ANDI_D = 9,
  OP_MOV = 16,
  OP_MOVI_D = 17,
  OP_MOVI_F = 21,
  OP_VMOV = 18,
  OP_VMOVI = 23,
  OP_CMP = 24,
  OP_CMPI = 25,
  OP_VCOMPMOV = 34,
  OP_VCOMPMOVI = 39,
  OP_LDB = 41,
  OP_LDW = 42,
  OP_STB = 49,
  OP_STW = 50,
  OP_SETVERTEX = 66,
  OP_SETCOLOR = 74,
  OP_ROTATE = 82,
  OP_TRANSLATE = 90,
  OP_SCALE = 98,
  OP_PUSHMATRIX = 128,
  OP_POPMATRIX = 136,
  OP_BEGINPRIMITIVE = 145,
  OP_ENDPRIMITIVE = 152,
  OP_LOADIDENTITY = 160,
  OP_FLUSH = 176,
  OP_DRAW = 184,
  OP_BRN = 220,
  OP_BRZ = 218,
  OP_BRP = 217,
  OP_BRNZ = 222,
  OP_BRNP = 221,
  OP_BRZP = 219,
  OP_BRNZP = 223,
  OP_JMP = 224,
  OP_RET = 224,
  OP_JSR = 240,
  OP_JSRR = 248,
};

////////////////////////////////////////////////////////////////////////
// 1. int_value field is for integer scalar registers: R0 - R6, R7, R15
// 2. float_value field is for floating-point scalar registers: R8 - R14
////////////////////////////////////////////////////////////////////////
typedef struct ScalarRegister_ {
	int int_value; 
	float float_value;
} ScalarRegister;

////////////////////////////////////////////////////////////////////////
// In this course we will use vector registers only for graphics operations.
// Do not bother to use int_value field.
////////////////////////////////////////////////////////////////////////
typedef struct VectorRegister_ {
	ScalarRegister element[NUM_VECTOR_ELEMENTS]; 
} VectorRegister;

////////////////////////////////////////////////////////////////////////
// 1. opcode
// 2. scalar_registers: If instruction has dest, src1, src2 registers
//											then each register's index will be stored in scalar_registers
// 3. vector_registers: 
// 4. idx: This field is for VCOMPMOV instruction
// 5. primitive_type: This field is for BEGINPRIMITIVE instruction
// 6. int_value: This field is for integer immediate value 
// 7. float_value: This field is for floating-point immediate value 
////////////////////////////////////////////////////////////////////////
typedef struct TraceOp_ {
	int16_t opcode;
	int16_t scalar_registers[3];
	int64_t vector_registers[3];
	int idx;
	int primitive_type;
	int int_value;
	float float_value;
} TraceOp;

#endif // __SIMULATOR_H
