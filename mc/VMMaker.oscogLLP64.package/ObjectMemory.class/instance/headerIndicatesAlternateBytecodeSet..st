method access
headerIndicatesAlternateBytecodeSet: methodHeader
	"A negative header selects the alternate bytecode set."
	<api>
	<inline: true>
	^methodHeader signedIntFromLong < 0