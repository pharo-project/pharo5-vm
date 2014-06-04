testing
methodUsesAlternateBytecodeSet: methodObjOop
	"A negative header selects the alternate bytecode set."
	^(self objectForOop: methodObjOop) signFlag