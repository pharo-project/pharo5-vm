simulation only
stackFloatValue: offset
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter stackFloatValue: offset