forwarding
followForwardedObjectFields: objOop toDepth: depth
	"Follow pointers in the object to depth.
	 Answer if any forwarders were found.
	 How to avoid cyclic structures?? A temproary mark bit?"
	<api>
	<inline: false>
	| oop found |
	found := false.
	self assert: ((self isPointers: objOop) or: [self isOopCompiledMethod: objOop]).
	0 to: (self numPointerSlotsOf: objOop) - 1 do:
		[:i|
		 oop := self fetchPointer: i ofObject: objOop.
		 (self isNonImmediate: oop) ifTrue:
			[(self isForwarded: oop) ifTrue:
				[found := true.
				 oop := self followForwarded: oop.
				 self storePointer: i ofObject: objOop withValue: oop].
			(depth > 0
			 and: [(self hasPointerFields: oop)
			 and: [self followForwardedObjectFields: oop toDepth: depth - 1]]) ifTrue:
				[found := true]]].
	^found