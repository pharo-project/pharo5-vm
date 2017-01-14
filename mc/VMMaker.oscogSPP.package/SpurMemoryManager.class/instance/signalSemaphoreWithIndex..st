simulation only
signalSemaphoreWithIndex: index
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter signalSemaphoreWithIndex: index