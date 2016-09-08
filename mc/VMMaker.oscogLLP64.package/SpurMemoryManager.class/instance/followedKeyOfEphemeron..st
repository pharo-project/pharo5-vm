object access
followedKeyOfEphemeron: objOop
	"Answer the object the ephemeron guards.  This is its first element."
	self assert: ((self isNonImmediate: objOop) and: [self isEphemeron: objOop]).
	^self followOopField: 0 ofObject: objOop