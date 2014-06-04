internal interpreter access
stackPositiveMachineIntegerValue: offset
	<api>
	"In the StackInterpreter stacks grow down."
	| integerPointer |
	integerPointer := stackPages longAt: stackPointer + (offset*BytesPerWord).
	^self positiveMachineIntegerValueOf: integerPointer