contexts
stackFloatValue: offset
	<returnTypeC: #double>
	^self floatValueOf: (self longAt: stackPointer - (offset*self wordSize))