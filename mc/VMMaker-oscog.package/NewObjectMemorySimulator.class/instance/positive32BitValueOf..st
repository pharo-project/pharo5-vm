simulation only
positive32BitValueOf: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter positive32BitValueOf: oop