simulation only
positive64BitIntegerFor: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter positive64BitIntegerFor: integerValue