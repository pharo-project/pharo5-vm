simulation only
positiveMachineIntegerValueOf: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter positiveMachineIntegerValueOf: integerValue