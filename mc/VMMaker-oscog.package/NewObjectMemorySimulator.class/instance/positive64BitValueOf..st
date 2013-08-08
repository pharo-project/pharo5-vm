simulation only
positive64BitValueOf: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter positive64BitValueOf: oop