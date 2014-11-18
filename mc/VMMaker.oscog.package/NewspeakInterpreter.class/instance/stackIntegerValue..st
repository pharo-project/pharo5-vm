internal interpreter access
stackIntegerValue: offset
	| integerPointer |
	integerPointer := self longAt: stackPointer - (offset*self wordSize).
	^self checkedIntegerValueOf: integerPointer