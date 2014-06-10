primitive support
allObjects
	"Attempt to answer an array of all objects, excluding those that may
	 be garbage collected as a side effect of allocating the result array.
	 If no memory is available answer the number of objects as a SmallInteger.
	 Since objects are at least 4 bytes big, and the largest SmallInteger covers
	 1/4 of the address space, the count can never overflow."
	| count obj resultArray newCount |
	"Count the currently accessible objects"
	count := 0.
	self allObjectsDo:
		[:ign| count := count + 1].
	"Allocate result array, may cause GC"
	resultArray := self instantiateClass: self classArray indexableSize: count.
	"Store all objects in result array, excluding any reference to the result array itself,
	 as may happen if garbage collection occurred during allocation of the array. No store
	 check is necessary; the result array will be the last object in memory and hence new."
	newCount := 0.
	obj := self firstObject.
	[obj < resultArray] whileTrue:
		[(self isFreeObject: obj) ifFalse:
			[newCount := newCount + 1.
			 resultArray == nil ifFalse:
				[self storePointerUnchecked: newCount ofObject: resultArray withValue: obj]].
		 obj := self objectAfter: obj].
	resultArray == nil ifTrue:
		[^self integerObjectOf: count].
	"If GC occurred during result array allocation, truncate unused portion of result array"
	newCount < count ifTrue:
		[self shorten: resultArray toIndexableSize: newCount].
	^resultArray