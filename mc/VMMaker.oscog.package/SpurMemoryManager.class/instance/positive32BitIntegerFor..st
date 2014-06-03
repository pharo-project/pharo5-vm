simulation only
positive32BitIntegerFor: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter positive32BitIntegerFor: integerValue