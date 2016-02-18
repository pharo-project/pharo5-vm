internal interpreter access
push: object
	"In the StackInterpreter stacks grow down."
	| sp |
	<inline: true>
	<var: #sp type: #'char *'>
	stackPages longAt: (sp := stackPointer - objectMemory wordSize) put: object.
	stackPointer := sp