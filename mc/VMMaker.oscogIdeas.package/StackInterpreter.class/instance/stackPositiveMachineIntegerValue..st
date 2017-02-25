stack access
stackPositiveMachineIntegerValue: offset
	<api>
	<returnTypeC: #'usqIntptr_t'>
	"In the StackInterpreter stacks grow down."
	| integerPointer |
	integerPointer := stackPages longAt: stackPointer + (offset*objectMemory wordSize).
	^self positiveMachineIntegerValueOf: integerPointer