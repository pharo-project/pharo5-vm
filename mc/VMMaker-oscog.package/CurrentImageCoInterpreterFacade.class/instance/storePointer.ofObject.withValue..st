testing
storePointer: index ofObject: objOop withValue: valueOop 
	(self objectForOop: objOop)
		at: index + 1
		put: (self objectForOop: valueOop)