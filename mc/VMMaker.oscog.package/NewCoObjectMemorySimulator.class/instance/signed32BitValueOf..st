simulation only
signed32BitValueOf: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter signed32BitValueOf: oop