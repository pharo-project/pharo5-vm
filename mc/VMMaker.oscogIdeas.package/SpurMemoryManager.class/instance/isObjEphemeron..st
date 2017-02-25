object testing
isObjEphemeron: objOop
	^self isEphemeronFormat: (self formatOf: objOop)