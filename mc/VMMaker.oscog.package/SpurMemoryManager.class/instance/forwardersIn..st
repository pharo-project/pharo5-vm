debug support
forwardersIn: anObject
	"Answer if anObject is itself forwarded, or is a pointer object containing any references to forwarded objects."
	(self isForwarded: anObject) ifTrue:
		[^true].
	0 to: (self numPointerSlotsOf: anObject) - 1 do:
		[:i| | oop |
		 oop := self fetchPointer: i ofMaybeForwardedObject: anObject.
		 ((self isNonImmediate: oop)
		  and: [self isForwarded: oop]) ifTrue:
			[^true]].
	^false