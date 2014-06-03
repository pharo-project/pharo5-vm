internal interpreter access
stackPositiveMachineIntegerValue: offset
	<api>
	| integerPointer |
	integerPointer := self longAt: stackPointer - (offset*BytesPerWord).
	^self positiveMachineIntegerValueOf: integerPointer