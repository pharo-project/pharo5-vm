simulation only
signed32BitIntegerFor: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter signed32BitIntegerFor: integerValue