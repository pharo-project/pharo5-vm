forwarding
followObjField: fieldIndex ofObject: anObject
	"Make sure the obj at fieldIndex in anObject is not forwarded (follow the
	 forwarder there-in if so).  Answer the (possibly followed) obj at fieldIndex."
	| objOop |
	objOop := self fetchPointer: fieldIndex ofObject: anObject.
	self assert: (self isNonImmediate: objOop).
	(self isForwarded: objOop) ifTrue:
		[objOop := self fixFollowedField: fieldIndex ofObject: anObject withInitialValue: objOop].
	^objOop