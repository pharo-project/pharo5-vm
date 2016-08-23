primitive support
allInstancesOf: aClass
	"Attempt to answer an array of all objects, excluding those that may
	 be garbage collected as a side effect of allocating the result array.
	 If no memory is available answer the number of instances as a SmallInteger.
	 Since objects are at least 16 bytes big, and the largest SmallInteger covers
	 1/4 of the address space, the count can never overflow."
	| count theClass resultArray newCount |
	"Count the currently accessible objects"
	count := 0.
	self allObjectsDo:
		[:obj|
		(self fetchClassOfNonImm: obj) = aClass ifTrue:
			[count := count + 1]].
	"Allocate result array, may cause GC"
	self pushRemappableOop: aClass.
	resultArray := self instantiateClass: self classArray indexableSize: count.
	theClass := self popRemappableOop.
	newCount := 0.
	self allObjectsDo:
		[:obj|
		 (self fetchClassOfNonImm: obj) = theClass ifTrue:
			[newCount := newCount + 1.
			 resultArray == nil ifFalse:
				[self storePointerUnchecked: newCount ofObject: resultArray withValue: obj]]].
	resultArray == nil ifTrue:
		[^self integerObjectOf: newCount].
	"If GC occurred during result array allocation, truncate unused portion of result array"
	newCount < count ifTrue:
		[self shorten: resultArray toIndexableSize: newCount].
	^resultArray