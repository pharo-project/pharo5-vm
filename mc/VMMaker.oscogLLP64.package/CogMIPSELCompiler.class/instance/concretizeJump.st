generate machine code - concretize
concretizeJump
	| offset |
	offset := self computeJumpTargetOffsetPlus: 4.
	self flag: #BranchRange.
	self machineCodeAt: 0 put: (self beqR: ZR R: ZR offset: offset).
	self machineCodeAt: 4 put: self nop. "Delay slot"
	^machineCodeSize := 8