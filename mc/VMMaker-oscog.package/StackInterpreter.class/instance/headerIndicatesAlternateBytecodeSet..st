internal interpreter access
headerIndicatesAlternateBytecodeSet: methodHeader
	<api>
	<inline: true>
	"A negative header selects the alternate bytecode set."
	^methodHeader signedIntFromLong < 0