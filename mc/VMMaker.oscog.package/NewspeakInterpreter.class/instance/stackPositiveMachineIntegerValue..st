internal interpreter access
stackPositiveMachineIntegerValue: offset
	<api>
	| integerPointer |
	integerPointer := self longAt: stackPointer - (offset*self wordSize).
	^self positiveMachineIntegerValueOf: integerPointer