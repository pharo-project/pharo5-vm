simulation only
floatValueOf: obj
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter floatValueOf: obj