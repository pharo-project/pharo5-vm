simulation only
signed32BitIntegerFor: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter signed32BitIntegerFor: integerValue