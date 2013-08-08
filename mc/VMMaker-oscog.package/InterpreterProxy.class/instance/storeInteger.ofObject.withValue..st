object access
storeInteger: index ofObject: oop withValue: integer
	(self isIntegerValue: integer) 
		ifTrue:[^self storePointer: index ofObject: oop withValue: integer]
		ifFalse:[^self primitiveFail]