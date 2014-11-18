internal interpreter access
stackSignedMachineIntegerValue: offset
	<api>
	| integerPointer |
	integerPointer := self longAt: stackPointer - (offset*self wordSize).
	^self signedMachineIntegerValueOf: integerPointer