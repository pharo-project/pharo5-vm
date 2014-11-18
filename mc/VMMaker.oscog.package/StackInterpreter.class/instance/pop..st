internal interpreter access
pop: nItems
	<inline: true>
	"In the StackInterpreter stacks grow down."
	stackPointer := stackPointer + (nItems*objectMemory wordSize).
	^nil