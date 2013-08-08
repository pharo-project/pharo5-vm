internal interpreter access
stackFloatValue: offset
	"In the StackInterpreter stacks grow down."
	<returnTypeC: #double>
	^self floatValueOf: (stackPages longAt: stackPointer + (offset*BytesPerWord))