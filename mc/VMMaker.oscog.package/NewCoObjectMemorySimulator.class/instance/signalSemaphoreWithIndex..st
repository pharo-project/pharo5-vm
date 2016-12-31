simulation only
signalSemaphoreWithIndex: index
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter signalSemaphoreWithIndex: index