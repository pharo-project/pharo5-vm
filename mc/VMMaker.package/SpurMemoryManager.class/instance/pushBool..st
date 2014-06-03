simulation only
pushBool: trueOrFalse
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter pushBool: trueOrFalse