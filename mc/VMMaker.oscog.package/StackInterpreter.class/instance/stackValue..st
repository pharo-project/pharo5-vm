internal interpreter access
stackValue: offset
	<api>
	"In the StackInterpreter stacks grow down."
	^stackPages longAt: stackPointer + (offset*BytesPerWord)