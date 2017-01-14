generate machine code - concretize
concretizeJumpFull
	| jumpTargetInstruction jumpTargetAddr |
	<var: #jumpTargetInstruction type: #'AbstractInstruction *'>
	jumpTargetInstruction := self longJumpTargetAddress.
	jumpTargetAddr := jumpTargetInstruction asUnsignedInteger.
	self machineCodeAt: 0 put: (self luiR: TargetReg C: (self high16BitsOf: jumpTargetAddr)).
	self machineCodeAt: 4 put: (self oriR: TargetReg R: TargetReg C: (self low16BitsOf: jumpTargetAddr)).
	self machineCodeAt: 8 put: (self jR: TargetReg).
	self machineCodeAt: 12 put: self nop. "Delay slot"
	^machineCodeSize := 16