simulation only
superclassOf: classPointer
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter superclassOf: classPointer