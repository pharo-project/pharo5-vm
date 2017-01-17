simulation only
checkedIntegerValueOf: intOop
	<doNotGenerate>
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter checkedIntegerValueOf: intOop