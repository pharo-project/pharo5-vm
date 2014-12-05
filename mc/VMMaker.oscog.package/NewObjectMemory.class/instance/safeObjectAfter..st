object enumeration
safeObjectAfter: oop 
	"Return the object or start of free space immediately following the 
	 given object or free chunk in memory. Return freeStart when
	 enumeration is complete.  This is for assertion checking only."
	| sz |
	(self isFreeObject: oop)
		ifTrue: [sz := self sizeOfFree: oop]
		ifFalse: [sz := self sizeBitsOf: oop].
	^(oop + sz) asUnsignedInteger >= freeStart
		ifTrue: [freeStart asInteger]
		ifFalse: [self oopFromChunk: oop + sz]