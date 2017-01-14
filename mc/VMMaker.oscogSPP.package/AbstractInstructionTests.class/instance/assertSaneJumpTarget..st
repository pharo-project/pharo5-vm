cogit compatibility
assertSaneJumpTarget: jumpTarget
	<var: #jumpTarget type: #'AbstractInstruction *'>

	self assert: (self addressIsInInstructions: jumpTarget)