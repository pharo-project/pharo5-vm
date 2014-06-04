object access
keyOfEphemeron: objOop
	"Answer the object the ephemeron guards.  This is its first element."
	self assert: ((self isNonImmediate: objOop) and: [self isEphemeron: objOop]).
	^self fetchPointer: 0 ofObject: objOop