internal interpreter access
stackSignedMachineIntegerValue: offset
	<api>
	"In the StackInterpreter stacks grow down."
	| integerPointer |
	integerPointer := stackPages longAt: stackPointer + (offset*BytesPerWord).
	^self signedMachineIntegerValueOf: integerPointer