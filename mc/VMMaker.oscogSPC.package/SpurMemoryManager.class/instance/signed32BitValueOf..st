simulation only
signed32BitValueOf: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter signed32BitValueOf: oop