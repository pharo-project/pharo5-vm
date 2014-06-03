simulation only
postGCAction: gcMode
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter postGCAction: gcMode