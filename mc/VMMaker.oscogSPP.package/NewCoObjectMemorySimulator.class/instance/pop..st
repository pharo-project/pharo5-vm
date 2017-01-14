simulation only
pop: nItems
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter pop: nItems