simulation only
stackIntegerValue: offset
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter stackIntegerValue: offset