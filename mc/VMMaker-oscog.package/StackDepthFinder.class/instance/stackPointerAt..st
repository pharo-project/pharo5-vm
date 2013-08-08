accessing
stackPointerAt: aPC 
	[pc < aPC] whileTrue:
		[self interpretNextInstructionFor: self].
	^pc = aPC ifTrue: [stackp]