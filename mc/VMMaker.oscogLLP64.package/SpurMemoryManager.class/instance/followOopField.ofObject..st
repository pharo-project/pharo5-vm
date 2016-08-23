forwarding
followOopField: fieldIndex ofObject: anObject
	"Make sure the oop at fieldIndex in anObject is not forwarded (follow the
	 forwarder there-in if so).  Answer the (possibly followed) oop at fieldIndex."
	| oop |
	oop := self fetchPointer: fieldIndex ofObject: anObject.
	(self isOopForwarded: oop) ifTrue:
		[oop := self fixFollowedField: fieldIndex ofObject: anObject withInitialValue: oop].
	^oop