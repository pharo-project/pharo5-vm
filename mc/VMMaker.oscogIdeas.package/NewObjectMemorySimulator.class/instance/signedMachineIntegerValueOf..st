simulation only
signedMachineIntegerValueOf: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter signedMachineIntegerValueOf: oop