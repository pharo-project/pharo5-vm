stack access
stackFloatValue: offset
	"In the StackInterpreter stacks grow down."
	<returnTypeC: #double>
	^objectMemory floatValueOf: (stackPages longAt: stackPointer + (offset*objectMemory wordSize))