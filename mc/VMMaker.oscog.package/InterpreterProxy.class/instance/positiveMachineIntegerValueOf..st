converting
positiveMachineIntegerValueOf: oop
	<returnTypeC: #'usqIntptr_t'>
	oop isInteger ifFalse:[self error: 'Not an integer object'].
	^oop < 0 
		ifTrue: [self primitiveFail. 0]
		ifFalse: [oop]