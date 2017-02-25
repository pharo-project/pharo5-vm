simulation only
stackObjectValue: offset
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter stackObjectValue: offset