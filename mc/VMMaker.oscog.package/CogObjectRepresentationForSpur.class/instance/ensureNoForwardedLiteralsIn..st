initialization
ensureNoForwardedLiteralsIn: aMethodObj
	"Ensure there are no forwarded literals in the argument."
	<inline: true>
	objectMemory
		followForwardedObjectFields: aMethodObj
		toDepth: 0