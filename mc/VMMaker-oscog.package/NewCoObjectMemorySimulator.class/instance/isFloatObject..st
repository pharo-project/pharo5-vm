simulation only
isFloatObject: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter isFloatObject: oop