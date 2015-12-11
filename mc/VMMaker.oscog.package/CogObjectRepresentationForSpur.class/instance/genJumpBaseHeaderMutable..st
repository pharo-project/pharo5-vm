compile abstract instructions
genJumpBaseHeaderMutable: baseHeaderReg
	"baseHeader holds at least the least significant 32 bits of the object"
	<returnTypeC: #'AbstractInstruction *'>
	cogit TstCq: objectMemory immutableBitMask R: baseHeaderReg.
	^ cogit JumpZero: 0