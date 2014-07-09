assembling
doesNotUnderstand: aMessage
	(InstructionClient includesSelector: aMessage selector) ifFalse:
		[^super doesNotUnderstand: aMessage].
	aMessage lookupClass: nil.
	self ensureInstructions addLast: aMessage