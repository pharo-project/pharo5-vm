generate machine code - concretize
concretizeJumpLongZero
	| jumpTarget |
	<var: #jumpTarget type: #'AbstractInstruction *'>
	jumpTarget := self longJumpTargetAddress.
	self flag: #todo. "Check not crossing 256MB block."
	jumpTarget := jumpTarget bitAnd: 16rFFFFFFF.
	self machineCodeAt: 0 put: (self bneR: Cmp R: ZR offset: 12).
	self machineCodeAt: 4 put: self nop. "Delay slot"
	self machineCodeAt: 8 put: (self jA: jumpTarget).
	self machineCodeAt: 12 put: self nop. "Delay slot"
	^machineCodeSize := 16