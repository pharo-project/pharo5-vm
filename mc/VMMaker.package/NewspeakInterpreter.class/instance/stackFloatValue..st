internal interpreter access
stackFloatValue: offset
	<returnTypeC: #double>
	^self floatValueOf: (self longAt: stackPointer - (offset*BytesPerWord))