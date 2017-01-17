simulation only
booleanValueOf: obj
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter booleanValueOf: obj