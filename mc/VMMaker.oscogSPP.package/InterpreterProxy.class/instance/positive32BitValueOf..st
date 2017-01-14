converting
positive32BitValueOf: oop
	<returnTypeC: #usqInt>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	oop < 0 
		ifTrue:[self primitiveFail. ^0]
		ifFalse:[^oop]