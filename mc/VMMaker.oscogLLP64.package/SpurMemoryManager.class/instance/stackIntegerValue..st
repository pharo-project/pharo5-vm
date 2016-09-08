simulation only
stackIntegerValue: offset
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter stackIntegerValue: offset