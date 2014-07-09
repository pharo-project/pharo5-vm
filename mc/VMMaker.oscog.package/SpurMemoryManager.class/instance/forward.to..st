become implementation
forward: obj1 to: obj2
	self set: obj1 classIndexTo: self isForwardedObjectClassIndexPun formatTo: self forwardedFormat.
	self storePointer: 0 ofForwarder: obj1 withValue: obj2.
	"For safety make sure the forwarder has a slot count that includes its contents."
	(self rawNumSlotsOf: obj1) = 0 ifTrue:
		[self setRawNumSlotsOf: obj1 to: 1]