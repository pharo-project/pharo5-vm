testing
instructionIsBLX: instr
"is this a BLX <targetReg> instruction? We DO NOT support the BLX immed version"
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"See ARM DDI0406A p A8-60"
 	^(instr bitAnd: 16r0FFFFFF0) = 16r12FFF30