internal interpreter access
popStack
	"In the StackInterpreter stacks grow down."
	<api>
	| top |
	<inline: true>
	top := stackPages longAt: stackPointer.
	stackPointer := stackPointer + objectMemory wordSize.
	^top