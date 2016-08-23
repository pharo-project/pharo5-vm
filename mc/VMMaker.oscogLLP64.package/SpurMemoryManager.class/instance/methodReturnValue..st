simulation only
methodReturnValue: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter methodReturnValue: oop