simulation only
doesNotUnderstand: aMessage
	(aMessage selector beginsWith: 'print') ifTrue:
		[(coInterpreter respondsTo: aMessage selector) ifTrue:
			[^aMessage lookupClass: nil; sentTo: coInterpreter].
		(methodZone respondsTo: aMessage selector) ifTrue:
			[^aMessage lookupClass: nil; sentTo: methodZone].
		(objectMemory respondsTo: aMessage selector) ifTrue:
			[^aMessage lookupClass: nil; sentTo: objectMemory]].
	^super doesNotUnderstand: aMessage