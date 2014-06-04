simulation only
positive32BitValueOf: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter positive32BitValueOf: oop