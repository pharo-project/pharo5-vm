simulation only
pushInteger: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter pushInteger: integerValue