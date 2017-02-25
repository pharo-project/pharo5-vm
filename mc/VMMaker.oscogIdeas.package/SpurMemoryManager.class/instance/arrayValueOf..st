simulation only
arrayValueOf: arrayOop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter arrayValueOf: arrayOop