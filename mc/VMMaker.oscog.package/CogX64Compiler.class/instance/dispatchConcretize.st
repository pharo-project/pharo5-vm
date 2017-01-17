generate machine code
dispatchConcretize
	"Attempt to generate concrete machine code for the instruction at address.
	 This is the inner dispatch of concretizeAt: actualAddress which exists only
	 to get around the branch size limits in the SqueakV3 (blue book derived)
	 bytecode set."
	<returnTypeC: #void>
	opcode >= CDQ ifTrue:
		[^self dispatchConcretizeProcessorSpecific].
	opcode caseOf: {
		"Noops & Pseudo Ops"
		[Label]				-> [^self concretizeLabel].
		[AlignmentNops]	-> [^self concretizeAlignmentNops].
		[Fill32]				-> [^self concretizeFill32].
		[Nop]				-> [^self concretizeNop].
		"Control"
		[Call]					-> [^self concretizeCall].
		[CallR]					-> [^self concretizeCallR].
		[CallFull]				-> [^self concretizeCallFull].
		[JumpR]					-> [^self concretizeJumpR].
		[JumpFull]				-> [^self concretizeJumpFull].
		[JumpLong]				-> [^self concretizeJumpLong].
		[JumpLongZero]		-> [^self concretizeConditionalJump: 16r4].
		[JumpLongNonZero]	-> [^self concretizeConditionalJump: 16r5].
		[Jump]					-> [^self concretizeJump].
		"Table B-1 Intel 64 and IA-32 Architectures Software Developer's Manual Volume 1: Basic Architecture"
		[JumpZero]				-> [^self concretizeConditionalJump: 16r4].
		[JumpNonZero]			-> [^self concretizeConditionalJump: 16r5].
		[JumpNegative]			-> [^self concretizeConditionalJump: 16r8].
		[JumpNonNegative]		-> [^self concretizeConditionalJump: 16r9].
		[JumpOverflow]			-> [^self concretizeConditionalJump: 16r0].
		[JumpNoOverflow]		-> [^self concretizeConditionalJump: 16r1].
		[JumpCarry]			-> [^self concretizeConditionalJump: 16r2].
		[JumpNoCarry]			-> [^self concretizeConditionalJump: 16r3].
		[JumpLess]				-> [^self concretizeConditionalJump: 16rC].
		[JumpGreaterOrEqual]	-> [^self concretizeConditionalJump: 16rD].
		[JumpGreater]			-> [^self concretizeConditionalJump: 16rF].
		[JumpLessOrEqual]		-> [^self concretizeConditionalJump: 16rE].
		[JumpBelow]			-> [^self concretizeConditionalJump: 16r2].
		[JumpAboveOrEqual]	-> [^self concretizeConditionalJump: 16r3].
		[JumpAbove]			-> [^self concretizeConditionalJump: 16r7].
		[JumpBelowOrEqual]	-> [^self concretizeConditionalJump: 16r6].
		[JumpFPEqual]				-> [^self concretizeConditionalJump: 16r4].
		[JumpFPNotEqual]			-> [^self concretizeConditionalJump: 16r5].
		[JumpFPLess]				-> [^self concretizeConditionalJump: 16r2].
		[JumpFPGreaterOrEqual]	-> [^self concretizeConditionalJump: 16r3].
		[JumpFPGreater]			-> [^self concretizeConditionalJump: 16r7].
		[JumpFPLessOrEqual]		-> [^self concretizeConditionalJump: 16r6].
		[JumpFPOrdered]			-> [^self concretizeConditionalJump: 16rB].
		[JumpFPUnordered]			-> [^self concretizeConditionalJump: 16rA].
		[RetN]						-> [^self concretizeRetN].
		[Stop]						-> [^self concretizeStop].
		"Arithmetic"
		[AddCqR]					-> [^self concretizeArithCqRWithRO: 0 raxOpcode: 15r05].
		[AddCwR]					-> [^self concretizeArithCwR: 16r03].
		[AddRR]						-> [^self concretizeOpRR: 16r03].
		[AddRsRs]					-> [^self concretizeSEEOpRsRs: 16r58].
		[AddRdRd]					-> [^self concretizeSEE2OpRdRd: 16r58].
		[AndCqR]					-> [^self concretizeArithCqRWithRO: 4 raxOpcode: 16r25].
		[AndCwR]					-> [^self concretizeArithCwR: 16r23].
		[AndRR]						-> [^self concretizeOpRR: 16r23].
		[TstCqR]					-> [^self concretizeTstCqR].
		[CmpCqR]					-> [^self concretizeArithCqRWithRO: 7 raxOpcode: 16r3D].
		[CmpCwR]					-> [^self concretizeArithCwR: 16r39].
		[CmpC32R]					-> [^self concretizeCmpC32R].
		[CmpRR]					-> [^self concretizeReverseOpRR: 16r39].
		[CmpRdRd]					-> [^self concretizeCmpRdRd].
		[CmpRsRs]					-> [^self concretizeCmpRsRs].
		[DivRdRd]					-> [^self concretizeSEE2OpRdRd: 16r5E].
		[DivRsRs]					-> [^self concretizeSEEOpRsRs: 16r5E].
		[MulRdRd]					-> [^self concretizeSEE2OpRdRd: 16r59].
		[MulRsRs]					-> [^self concretizeSEEOpRsRs: 16r59].
		[OrCqR]						-> [^self concretizeArithCqRWithRO: 1 raxOpcode: 16r0D].
		[OrCwR]					-> [^self concretizeArithCwR: 16r0B].
		[OrRR]						-> [^self concretizeOpRR: 16r0B].
		[SubCqR]					-> [^self concretizeArithCqRWithRO: 5 raxOpcode: 16r2D].
		[SubCwR]					-> [^self concretizeArithCwR: 16r2B].
		[SubRR]						-> [^self concretizeOpRR: 16r2B].
		[SubRdRd]					-> [^self concretizeSEE2OpRdRd: 16r5C].
		[SubRsRs]					-> [^self concretizeSEEOpRsRs: 16r5C].
		[SqrtRd]					-> [^self concretizeSqrtRd].
		[SqrtRs]					-> [^self concretizeSqrtRs].
		[XorCwR]					-> [^self concretizeArithCwR: 16r33].
		[XorRR]						-> [^self concretizeOpRR: 16r33].
		[XorRdRd]						-> [^self concretizeXorRdRd].
		[XorRsRs]						-> [^self concretizeXorRsRs].
		[NegateR]					-> [^self concretizeNegateR].
		[LoadEffectiveAddressMwrR]	-> [^self concretizeLoadEffectiveAddressMwrR].
		[RotateLeftCqR]				-> [^self concretizeShiftCqRegOpcode: 0].
		[RotateRightCqR]				-> [^self concretizeShiftCqRegOpcode: 1].
		[ArithmeticShiftRightCqR]		-> [^self concretizeShiftCqRegOpcode: 7].
		[LogicalShiftRightCqR]			-> [^self concretizeShiftCqRegOpcode: 5].
		[LogicalShiftLeftCqR]			-> [^self concretizeShiftCqRegOpcode: 4].
		[ArithmeticShiftRightRR]			-> [^self concretizeShiftRegRegOpcode: 7].
		[LogicalShiftLeftRR]				-> [^self concretizeShiftRegRegOpcode: 4].
		"Data Movement"
		[MoveCqR]			-> [^self concretizeMoveCqR].
		[MoveCwR]			-> [^self concretizeMoveCwR].
		[MoveC32R]		-> [^self concretizeMoveC32R].
		[MoveRR]			-> [^self concretizeReverseOpRR: 16r89].
		[MoveAwR]			-> [^self concretizeMoveAwR].
		[MoveA32R]		-> [^self concretizeMoveA32R].
		[MoveRAw]			-> [^self concretizeMoveRAw].
		[MoveRA32]		-> [^self concretizeMoveRA32].
		[MoveAbR]			-> [^self concretizeMoveAbR].
		[MoveRAb]			-> [^self concretizeMoveRAb].
		[MoveMbrR]			-> [^self concretizeMoveMbrR].
		[MoveRMbr]			-> [^self concretizeMoveRMbr].
		[MoveM8rR]		-> [^self concretizeMoveMbrR].
		[MoveRM8r]		-> [^self concretizeMoveRMbr].
		[MoveM16rR]		-> [^self concretizeMoveM16rR].
		[MoveRM16r]		-> [^self concretizeMoveRM16r].
		[MoveM32rR]		-> [^self concretizeMoveM32rR].
		[MoveM32rRs]		-> [^self concretizeMoveM32rRs].
		[MoveM64rRd]		-> [^self concretizeMoveM64rRd].
		[MoveMwrR]		-> [^self concretizeMoveMwrR].
		[MoveXbrRR]		-> [^self concretizeMoveXbrRR].
		[MoveRXbrR]		-> [^self concretizeMoveRXbrR].
		[MoveXwrRR]		-> [^self concretizeMoveXwrRR].
		[MoveRXwrR]		-> [^self concretizeMoveRXwrR].
		[MoveX32rRR]		-> [^self concretizeMoveX32rRR].
		[MoveRX32rR]		-> [^self concretizeMoveRX32rR].
		[MoveRMwr]		-> [^self concretizeMoveRMwr].
		[MoveRM32r]		-> [^self concretizeMoveRM32r].
		[MoveRsM32r]		-> [^self concretizeMoveRsM32r].
		[MoveRdM64r]		-> [^self concretizeMoveRdM64r].
		[MoveRdR]			-> [^self concretizeMoveRdR].
		[MoveRRd]			-> [^self concretizeMoveRRd].
		[MoveRdRd]		-> [^self concretizeMoveRdRd].
		[MoveRsRs]		-> [^self concretizeMoveRsRs].
		[PopR]				-> [^self concretizePopR].
		[PushR]				-> [^self concretizePushR].
		[PushCq]			-> [^self concretizePushCq].
		[PushCw]			-> [^self concretizePushCw].
		[PrefetchAw]		-> [^self concretizePrefetchAw].
		"Conversion"
		[ConvertRRd]		-> [^self concretizeConvertRRd].
		[ConvertRdR]		-> [^self concretizeConvertRdR].
		[ConvertRRs]		-> [^self concretizeConvertRRs].
		[ConvertRsR]		-> [^self concretizeConvertRsR].
		[ConvertRsRd]	-> [^self concretizeConvertRsRd].
		[ConvertRdRs]	-> [^self concretizeConvertRdRs].
			
		[SignExtend8RR]		-> [^self concretizeSignExtend8RR].
		[SignExtend16RR]	-> [^self concretizeSignExtend16RR].
		[SignExtend32RR]	-> [^self concretizeSignExtend32RR].
		
		[ZeroExtend8RR]		-> [^self concretizeZeroExtend8RR].
		[ZeroExtend16RR]	-> [^self concretizeZeroExtend16RR].
		[ZeroExtend32RR]	-> [^self concretizeZeroExtend32RR].
		}