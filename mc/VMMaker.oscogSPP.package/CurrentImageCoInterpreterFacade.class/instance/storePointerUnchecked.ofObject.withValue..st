accessing
storePointerUnchecked: zeroRelativeIndex ofObject: targetOop withValue: valueOop
	(self objectForOop: targetOop) at: zeroRelativeIndex + 1 put: (self objectForOop: valueOop)