generate machine code - concretize
concretizeJumpZero
	| offset |
	offset := self computeJumpTargetOffsetPlus: 12.
	self flag: #BranchRange.
	self machineCodeAt: 0 put: (self beqR: Cmp R: ZR offset: offset).
	self machineCodeAt: 4 put: self nop. "Delay slot"
	^machineCodeSize := 8