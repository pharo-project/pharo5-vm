simulation only
positive64BitIntegerFor: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter positive64BitIntegerFor: integerValue