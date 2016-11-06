converting
signedMachineIntegerValueOf: oop
	<returnTypeC: #'sqIntptr_t'>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop