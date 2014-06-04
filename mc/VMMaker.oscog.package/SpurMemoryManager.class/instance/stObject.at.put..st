simulation only
stObject: objOop at: indexOop put: valueOop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter stObject: objOop at: indexOop put: valueOop