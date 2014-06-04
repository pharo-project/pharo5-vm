forwarding
followField: fieldIndex ofObject: anObject
	"Make sure the oop at fieldIndex in anObject is not forwarded (follow the
	 forwarder there-in if so).  Answer the (possibly followed) oop at fieldIndex."
	| objOop |
	objOop := self fetchPointer: fieldIndex ofObject: anObject.
	(self isOopForwarded: objOop) ifTrue:
		[objOop := self fixFollowedField: fieldIndex ofObject: anObject withInitialValue: objOop].
	^objOop