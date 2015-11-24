generate machine code - concretize
concretizeBrLongNotEqualRR
	| jumpTarget leftReg rightReg |
	<var: #jumpTarget type: #'AbstractInstruction *'>
	jumpTarget := self longJumpTargetAddress.
	self flag: #todo. "Check not crossing 256MB block."
	jumpTarget := jumpTarget bitAnd: 16rFFFFFFF.
	leftReg := self concreteRegister: (operands at: 1).
	rightReg := self concreteRegister: (operands at: 2).

	self machineCodeAt: 0 put: (self beqR: leftReg R: rightReg offset: 12).
	self machineCodeAt: 4 put: (self nop). "Delay slot"
	self machineCodeAt: 8 put: (self jA: jumpTarget).
	self machineCodeAt: 12 put: self nop. "Delay slot"
	^machineCodeSize := 16