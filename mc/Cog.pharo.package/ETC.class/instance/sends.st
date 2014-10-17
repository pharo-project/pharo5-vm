results
sends
	[scanner atEnd] whileFalse:
		[scanner interpretNextInstructionFor: self].
	^sends