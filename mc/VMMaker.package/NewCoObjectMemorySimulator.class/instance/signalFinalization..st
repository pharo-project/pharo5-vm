simulation only
signalFinalization: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter signalFinalization: oop