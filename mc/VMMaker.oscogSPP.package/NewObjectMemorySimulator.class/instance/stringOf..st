simulation only
stringOf: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter stringOf: oop