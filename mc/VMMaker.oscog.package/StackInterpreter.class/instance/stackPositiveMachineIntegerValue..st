stack access
stackPositiveMachineIntegerValue: offset
	<api>
	"In the StackInterpreter stacks grow down."
	| integerPointer |
	integerPointer := stackPages longAt: stackPointer + (offset*objectMemory wordSize).
	^self positiveMachineIntegerValueOf: integerPointer