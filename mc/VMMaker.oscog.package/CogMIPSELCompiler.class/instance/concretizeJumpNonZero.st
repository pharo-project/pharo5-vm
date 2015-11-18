generate machine code - concretize
concretizeJumpNonZero
	| offset |
	offset := self computeJumpTargetOffsetPlus: 4.
	self flag: #BranchRange.
	self machineCodeAt: 0 put: (self bneR: Cmp R: ZR offset: offset).
	self machineCodeAt: 4 put: self nop. "Delay slot"
	^machineCodeSize := 8