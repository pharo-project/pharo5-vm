cog jit support
ensureNoForwardedLiteralsIn: aMethodObj
	"Ensure there are no forwarded literals in the argument."
	<api>
	self followForwardedObjectFields: aMethodObj toDepth: 0