internal interpreter access
stackIntegerValue: offset
	| integerPointer |
	integerPointer := self longAt: stackPointer - (offset*BytesPerWord).
	^self checkedIntegerValueOf: integerPointer