generate machine code - concretize
concretizeConditionalJumpLong: conditionCode
	"Will get inlined into concretizeAt: switch."
	"Sizing/generating jumps.
		Jump targets can be to absolute addresses or other abstract instructions.
		Generating initial trampolines instructions may have no maxSize and be to absolute addresses.
		Otherwise instructions must have a machineCodeSize which must be kept to."
	<inline: true>
	| jumpTarget |
	<var: #jumpTarget type: #'AbstractInstruction *'>
	jumpTarget := self longJumpTargetAddress.
	self at: 0 moveCw: jumpTarget intoR: RISCTempReg.
	"add pc, r3, #<byte 0>"
	self machineCodeAt: 12 put: (self c: conditionCode t: 1 o: 4 s: 0 rn: RISCTempReg rd: PC shifterOperand: (jumpTarget bitAnd: 16rFF)).
	^machineCodeSize := 16