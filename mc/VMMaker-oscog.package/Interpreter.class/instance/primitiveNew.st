object access primitives
primitiveNew
	"Allocate a new fixed-size instance. Fail if the allocation would leave less than lowSpaceThreshold bytes free. May cause a GC"

	| class spaceOkay |
	class := self stackTop.
	"The following may cause GC!"
	spaceOkay := self sufficientSpaceToInstantiate: class indexableSize: 0.
	self success: spaceOkay.
	successFlag ifTrue: [ self push: (self instantiateClass: self popStack indexableSize: 0) ]