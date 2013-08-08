contexts
stackIntegerValue: offset
	| integerPointer |
	integerPointer := self longAt: stackPointer - (offset*BytesPerWord).
	^self checkedIntegerValueOf: integerPointer