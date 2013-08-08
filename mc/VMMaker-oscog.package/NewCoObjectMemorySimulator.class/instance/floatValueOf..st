simulation only
floatValueOf: obj
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter floatValueOf: obj