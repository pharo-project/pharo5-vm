generate machine code - concretize
concretizeBrSignedGreaterEqualRR
	| offset leftReg rightReg |
	offset := self computeJumpTargetOffsetPlus: 8. "Relative to delay slot"
	leftReg := operands at: 1.
	rightReg := operands at: 2.
	self assert: leftReg ~= BranchTemp.
	self assert: rightReg ~= BranchTemp.
	self machineCodeAt: 0 put: (self sltR: BranchTemp R: leftReg R: rightReg).
	self machineCodeAt: 4 put: (self beqR: BranchTemp R: ZR offset: offset).
	self machineCodeAt: 8 put: (self nop). "Delay slot"
	^machineCodeSize := 12