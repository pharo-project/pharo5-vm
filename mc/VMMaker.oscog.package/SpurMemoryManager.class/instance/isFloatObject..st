simulation only
isFloatObject: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter isFloatObject: oop