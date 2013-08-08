class initialization
initialize
	"Abstract opcodes are a compound of a one word operation specifier and zero or more operand type specifiers.
	 e.g. MoveRR is the Move opcode with two register operand specifiers and defines a move register to
	 register instruction from operand 0 to operand 1.  The operand specifiers are
		R - general purpose register
		Rd - double-precision floating-point register
		Cq  - a quick constant that can be encoded in the minimum space possible.
		Cw - a constant with word size where word is the default operand size for the Smalltalk VM, 32-bits
			 for a 32-bit VM, 64-bits for a 64-bit VM.  The generated constant must occupy the default number
			 of bits.  This allows e.g. a garbage collector to update the value without invalidating the code.
		C32 - a constant with 32 bit size.  The generated constant must occupy 32 bits.
		C64 - a constant with 64 bit size.  The generated constant must occupy 64 bits.
		Aw    - memory word with an absolute address
		Ab    - memory byte with an absolute address
		Mwr  - memory word whose address is at a constant offset from an address in a register
		Mbr  - memory byte whose address is at a constant offset from an address in a register
		M16r  - memory 16-bit halfword whose address is at a constant offset from an address in a register
		M64r  - memory 64-bit doubleword whose address is at a constant offset from an address in a register
		XbrR- memory word whose address is r * byte size away from an address in a register
		X16rR- memory word whose address is r * (2 bytes size) away from an address in a register
		XwrR- memory word whose address is r * word size away from an address in a register

	An alternative would be to decouple opcodes from operands, e.g.
		Move := 1. Add := 2. Sub := 3...
		RegisterOperand := 1. ConstantQuickOperand := 2. ConstantWordOperand := 3...
	But not all combinations make sense and even fewer are used so we stick with the simple compound approach.

	The assumption is that comparison and arithmetic instructions set condition codes and that move instrucions
	leave the condition codes unaffected.  In particular LoadEffectiveAddressMwrR does not set condition codes
	although it can be used to do arithmetic.

	Note that there are no generic division instructions defined, but a processor may define some."

	"CogRTLOpcodes initialize.
	 CogAbstractInstruction allSubclasses do: [:sc| sc initialize]"

	| opcodeNames refs |
	FPReg := -1.
	SPReg := -2.
	ReceiverResultReg := GPRegMax := -3.
	TempReg := -4.
	ClassReg := -5.
	SendNumArgsReg := -6.
	Arg0Reg := -7.
	Arg1Reg := GPRegMin := -8.

	DPFPReg0 := -9.
	DPFPReg1 := -10.
	DPFPReg2 := -11.
	DPFPReg3 := -12.
	DPFPReg4 := -13.
	DPFPReg5 := -14.
	DPFPReg6 := -15.
	DPFPReg7 := -16.
	
	LinkReg := -17.

	opcodeNames := #("Noops & Pseudo Ops"
						Label
						AlignmentNops
						FillBytesFrom	"output operand 0's worth of bytes from the address in operand 1"
						Fill8				"output a byte's worth of bytes with operand 0"
						Fill16			"output two byte's worth of bytes with operand 0"
						Fill32			"output four byte's worth of bytes with operand 0"
						FillFromWord	"output BytesPerWord's worth of bytes with operand 0 + operand 1"
						Nop

						"Control"
						Call
						RetN
						JumpR				"Not a regular jump, i.e. not pc dependent."

						"N.B.  Jumps are contiguous.  Long jumps are contigiuous within them.  See FirstJump et al below"
						JumpLong
						JumpLongZero		"a.k.a. JumpLongEqual"
						JumpLongNonZero	"a.k.a. JumpLongNotEqual"
						Jump
						JumpZero			"a.k.a. JumpEqual"
						JumpNonZero		"a.k.a. JumpNotEqual"
						JumpNegative
						JumpNonNegative
						JumpOverflow
						JumpNoOverflow
						JumpCarry
						JumpNoCarry
						JumpLess			"signed"
						JumpGreaterOrEqual
						JumpGreater
						JumpLessOrEqual
						JumpBelow			"unsigned"
						JumpAboveOrEqual
						JumpAbove
						JumpBelowOrEqual

						JumpFPEqual
						JumpFPNotEqual
						JumpFPLess
						JumpFPLessOrEqual
						JumpFPGreater
						JumpFPGreaterOrEqual
						JumpFPOrdered
						JumpFPUnordered

						"Data Movement; destination is always last operand"
						MoveRR
						MoveAwR
						MoveRAw
						MoveAbR
						MoveMwrR MoveRMwr MoveXwrRR MoveRXwrR
						MoveM16rR MoveRM16r MoveX16rRR MoveRX16rR
						MoveMbrR MoveRMbr MoveXbrRR MoveRXbrR
						MoveCqR MoveCwR MoveC32R MoveC64R
						MoveRdRd MoveM64rRd MoveRdM64r
						PopR PushR PushCw
						PrefetchAw

						"Arithmetic; destination is always last operand except Cmp; CmpXR is SubRX with no update of result"
						LoadEffectiveAddressMwrR "A variant of add"
						NegateR "2's complement negation"
						ArithmeticShiftRightCqR ArithmeticShiftRightRR
						LogicalShiftRightCqR LogicalShiftRightRR
						LogicalShiftLeftCqR LogicalShiftLeftRR

						CmpRR AddRR SubRR AndRR OrRR XorRR MulRR
						CmpCqR AddCqR SubCqR AndCqR OrCqR XorCqR MulCqR
						CmpCwR AddCwR SubCwR AndCwR OrCwR XorCwR MulCwR

						CmpRdRd AddRdRd SubRdRd MulRdRd DivRdRd SqrtRd

						"Conversion"
						ConvertRRd

						LastRTLCode).

	refs := (thisContext method literals select: [:l| l isVariableBinding and: [classPool includesKey: l key]]) collect:
				[:ea| ea key].
	(classPool keys reject: [:k| (opcodeNames includes: k) or: [refs includes: k]]) do:
		[:k|
		Undeclared declare: k from: classPool].
	opcodeNames withIndexDo:
		[:classVarName :value|
		self classPool
			declare: classVarName from: Undeclared;
			at: classVarName put: value].
	FirstJump := JumpLong.
	LastJump := JumpFPUnordered.
	FirstShortJump := Jump