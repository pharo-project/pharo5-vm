internal interpreter access
stackIntegerValue: offset
	"In the StackInterpreter stacks grow down."
	| integerPointer |
	integerPointer := stackPages longAt: stackPointer + (offset*BytesPerWord).
	^self checkedIntegerValueOf: integerPointer