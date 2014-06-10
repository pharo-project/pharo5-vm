converting
signed64BitValueOf: oop
	<returnTypeC: #sqLong>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop