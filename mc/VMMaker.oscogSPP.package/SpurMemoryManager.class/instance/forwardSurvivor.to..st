become implementation
forwardSurvivor: obj1 to: obj2
	"This version of forward:to: can use an unchecked store because it is known that obj1 is young."
	self assert: (self isInNewSpace: obj1).
	self assert: ((self isInFutureSpace: obj2) or: [self isInOldSpace: obj2]).
	self storePointerUnchecked: 0 ofObject: obj1 withValue: obj2.
	self set: obj1 classIndexTo: self isForwardedObjectClassIndexPun formatTo: self forwardedFormat