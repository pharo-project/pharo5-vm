simulation only
is: oop KindOf: classNameString
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter is: oop KindOf: classNameString