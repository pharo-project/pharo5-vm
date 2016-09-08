simulation only
checkedIntegerValueOf: intOop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter checkedIntegerValueOf: intOop