simulation only
stackFloatValue: offset
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter stackFloatValue: offset