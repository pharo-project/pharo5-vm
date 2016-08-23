object access
keyOfMaybeFiredEphemeron: objOop
	"Answer the object the ephemeron guards.  This is its first element."
	self assert: ((self isNonImmediate: objOop) and: [self isMaybeFiredEphemeron: objOop]).
	^self fetchPointer: 0 ofObject: objOop