become implementation
forwardUnchecked: obj1 to: obj2
	"This version of forward:to: can use an unchecked store because it is known that both obj1 and obj2 are old."
	self assert: ((self isInOldSpace: obj1) and: [self isInOldSpace: obj2]).
	self storePointerUnchecked: 0 ofObject: obj1 withValue: obj2.
	self set: obj1 classIndexTo: self isForwardedObjectClassIndexPun formatTo: self forwardedFormat