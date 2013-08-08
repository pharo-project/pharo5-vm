converting
signed64BitIntegerFor: integerValue
	<var: 'integerValue' type: #sqLong>
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue