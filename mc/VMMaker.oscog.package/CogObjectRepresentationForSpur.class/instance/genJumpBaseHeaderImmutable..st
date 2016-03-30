compile abstract instructions
genJumpBaseHeaderImmutable: baseHeaderReg
	"baseHeader holds at least the least significant 32 bits of the object"
	<returnTypeC: #'AbstractInstruction *'>
	<option: #IMMUTABILITY>
	<inline: true>
	cogit TstCq: objectMemory immutableBitMask R: baseHeaderReg.
	^ cogit JumpNonZero: 0