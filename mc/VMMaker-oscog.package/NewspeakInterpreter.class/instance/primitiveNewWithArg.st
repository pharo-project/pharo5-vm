object access primitives
primitiveNewWithArg
	"Allocate a new indexable instance. Fail if the allocation would leave less than lowSpaceThreshold bytes free."
	| size class spaceOkay |
	size := self positive32BitValueOf: self stackTop.
	class := self stackValue: 1.
	self success: size >= 0.
	self successful
		ifTrue: ["The following may cause GC!"
			spaceOkay := self sufficientSpaceToInstantiate: class indexableSize: size.
			self success: spaceOkay.
			class := self stackValue: 1].
	self successful ifTrue: [self pop: 2 thenPush: (self instantiateClass: class indexableSize: size)]