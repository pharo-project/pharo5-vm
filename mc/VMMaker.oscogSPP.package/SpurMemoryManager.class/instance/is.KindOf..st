simulation only
is: oop KindOf: classNameString
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter is: oop KindOf: classNameString