object testing
isEphemeron: objOop
	self assert: (self isNonImmediate: objOop).
	^self isEphemeronFormat: (self formatOf: objOop)