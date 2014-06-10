forwarding
followNonImmediateField: fieldIndex ofObject: anObject
	"Make sure the oop at fieldIndex in anObject is not forwarded (follow the
	 forwarder there-in if so).  Answer the (possibly followed) oop at fieldIndex.
	 N.B. the oop is assumed to be non-immediate."
	| objOop |
	objOop := self fetchPointer: fieldIndex ofObject: anObject.
	self assert: (self isNonImmediate: objOop).
	(self isForwarded: objOop) ifTrue:
		[objOop := self fixFollowedField: fieldIndex ofObject: anObject withInitialValue: objOop].
	^objOop