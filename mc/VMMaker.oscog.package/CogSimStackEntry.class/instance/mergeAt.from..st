compile abstract instructions
mergeAt: baseOffset from: baseRegister
	"Discard type information because of a control-flow merge."
	self assert: spilled.
	type = SSSpill
		ifTrue:
			[self assert: (offset = baseOffset and: [register = baseRegister])]
		ifFalse:
			[type := SSSpill.
			 offset := baseOffset.
			 register := baseRegister]