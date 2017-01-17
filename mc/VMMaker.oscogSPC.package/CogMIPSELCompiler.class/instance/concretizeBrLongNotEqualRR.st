generate machine code - concretize
concretizeBrLongNotEqualRR
	| jumpTargetInstruction jumpTargetAddr leftReg rightReg |
	<var: #jumpTargetInstruction type: #'AbstractInstruction *'>
	jumpTargetInstruction := self longJumpTargetAddress.
	self flag: #todo. "Check not crossing 256MB block."
	jumpTargetAddr := jumpTargetInstruction asUnsignedInteger bitAnd: 16rFFFFFFF.
	leftReg := operands at: 1.
	rightReg := operands at: 2.

	self machineCodeAt: 0 put: (self beqR: leftReg R: rightReg offset: 12).
	self machineCodeAt: 4 put: (self nop). "Delay slot"
	self machineCodeAt: 8 put: (self jA: jumpTargetAddr).
	self machineCodeAt: 12 put: self nop. "Delay slot"
	^machineCodeSize := 16