initialization
ensureNoForwardedLiteralsIn: aMethodObj
	"Ensure there are no forwarded literals in the argument."
	<doNotGenerate>
	objectMemory ensureNoForwardedLiteralsIn: aMethodObj