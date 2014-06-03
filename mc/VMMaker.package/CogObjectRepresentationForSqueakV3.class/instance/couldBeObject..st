garbage collection
couldBeObject: oop
	"Note this version filters-out compact class indices via the >= nilObj clause"
	^(objectMemory isNonIntegerObject: oop)
	  and: [self oop: oop isGreaterThanOrEqualTo: objectMemory nilObject]