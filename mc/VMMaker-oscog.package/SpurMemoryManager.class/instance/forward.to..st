become implementation
forward: obj1 to: obj2
	self setFormatOf: obj1 to: self forwardedFormat.
	self setClassIndexOf: obj1 to: self isForwardedObjectClassIndexPun.
	self storePointer: 0 ofForwarder: obj1 withValue: obj2