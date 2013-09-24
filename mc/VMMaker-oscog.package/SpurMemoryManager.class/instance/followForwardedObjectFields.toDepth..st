become api
followForwardedObjectFields: objOop toDepth: depth
	"follow pointers in the object to depth.
	 How to avoid cyclic structures?? A temproary mark bit?"
	| oop |
	self assert: (self isPointers: objOop).
	0 to: (self numSlotsOf: objOop) - 1 do:
		[:i|
		oop := self fetchPointer: i ofObject: objOop.
		((self isNonImmediate: oop)
		 and: [self isForwarded: oop]) ifTrue:
			[oop := self followForwarded: oop.
			self storePointer: i ofObject: objOop withValue: oop].
		depth > 0 ifTrue:
			[self followForwardedObjectFields: objOop toDepth: depth - 1]]