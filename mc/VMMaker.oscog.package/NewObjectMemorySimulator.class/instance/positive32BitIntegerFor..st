simulation only
positive32BitIntegerFor: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter positive32BitIntegerFor: integerValue