simulation only
pop: nItems thenPush: oop
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	<doNotGenerate>
	^coInterpreter pop: nItems thenPush: oop