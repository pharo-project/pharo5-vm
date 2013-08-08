garbage collection
couldBeObject: oop
	^(objectMemory isNonIntegerObject: oop)
	  and: [self oop: oop isGreaterThanOrEqualTo: objectMemory nilObject]