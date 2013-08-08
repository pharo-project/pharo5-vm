internal interpreter access
stackSignedMachineIntegerValue: offset
	<api>
	| integerPointer |
	integerPointer := self longAt: stackPointer - (offset*BytesPerWord).
	^self signedMachineIntegerValueOf: integerPointer