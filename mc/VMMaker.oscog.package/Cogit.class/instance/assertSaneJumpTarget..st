debugging
assertSaneJumpTarget: jumpTarget
	<var: #jumpTarget type: #'AbstractInstruction *'>

	self assert: (closedPICSize isNil "don't whinge when producing the PIC prototypes"
			or: [openPICSize isNil
			or: [(self addressIsInInstructions: jumpTarget)
			or: [(jumpTarget asUnsignedInteger
					between: codeBase
					and: methodZone limitZony asInteger + (closedPICSize max: openPICSize))]]])