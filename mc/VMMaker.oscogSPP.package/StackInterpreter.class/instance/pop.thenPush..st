internal interpreter access
pop: nItems thenPush: oop
	"In the StackInterpreter stacks grow down."
	| sp |
	<inline: true>
	<var: #sp type: #'char *'>
	stackPages longAt: (sp := stackPointer + ((nItems - 1) * objectMemory wordSize)) put: oop.
	stackPointer := sp