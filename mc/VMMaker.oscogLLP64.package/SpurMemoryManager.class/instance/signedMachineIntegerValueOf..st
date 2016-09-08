simulation only
signedMachineIntegerValueOf: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter signedMachineIntegerValueOf: oop