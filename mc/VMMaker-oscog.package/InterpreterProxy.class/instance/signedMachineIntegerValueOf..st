converting
signedMachineIntegerValueOf: oop
	<returnTypeC: #'long'>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop