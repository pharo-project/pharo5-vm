disassembly
doesNotUnderstand: aMessage
	(InstructionClient includesSelector: aMessage selector) ifFalse:
		[^super doesNotUnderstand: aMessage].
	aMessage lookupClass: nil.
	instructions at: thePC put: aMessage