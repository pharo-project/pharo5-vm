stack access
stackIntegerValue: offset
	"In the StackInterpreter stacks grow down."
	| integerPointer |
	integerPointer := stackPages longAt: stackPointer + (offset*objectMemory wordSize).
	^self checkedIntegerValueOf: integerPointer