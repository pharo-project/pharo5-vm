simulation only
preGCAction: gcMode
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter preGCAction: gcMode