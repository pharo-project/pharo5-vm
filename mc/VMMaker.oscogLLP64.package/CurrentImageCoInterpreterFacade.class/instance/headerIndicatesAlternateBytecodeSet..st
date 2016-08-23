testing
headerIndicatesAlternateBytecodeSet: methodHeader
	"A negative header selects the alternate bytecode set."
	^(self objectForOop: methodHeader) < 0