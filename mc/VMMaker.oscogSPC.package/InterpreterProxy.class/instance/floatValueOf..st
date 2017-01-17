converting
floatValueOf: oop
	<returnTypeC:'double'>
	oop isFloat
		ifTrue:[^oop]
		ifFalse:[self primitiveFail. ^0.0].