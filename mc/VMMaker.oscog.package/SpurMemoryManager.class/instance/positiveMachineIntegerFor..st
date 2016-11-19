simulation only
positiveMachineIntegerFor: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter positiveMachineIntegerFor: integerValue