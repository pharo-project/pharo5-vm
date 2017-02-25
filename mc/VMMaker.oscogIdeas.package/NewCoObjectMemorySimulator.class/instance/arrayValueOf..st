simulation only
arrayValueOf: arrayOop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter arrayValueOf: arrayOop