simulation only
pushFloat: f
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter pushFloat: f