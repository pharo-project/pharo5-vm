converting
signed32BitValueOf: oop
	<returnTypeC: #int>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop