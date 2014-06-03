become implementation
forward: obj1 to: obj2
	self set: obj1 classIndexTo: self isForwardedObjectClassIndexPun formatTo: self forwardedFormat.
	self storePointer: 0 ofForwarder: obj1 withValue: obj2