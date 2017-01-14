simulation only
primitiveFailFor: reasonCode
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter primitiveFailFor: reasonCode