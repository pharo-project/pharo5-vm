simulation
headerIndicatesAlternateBytecodeSet: methodHeader
	"this is here only for in-image compilation"
	<doNotGenerate>
	"A negative header selects the alternate bytecode set."
	^methodHeader signedIntFromLong < 0