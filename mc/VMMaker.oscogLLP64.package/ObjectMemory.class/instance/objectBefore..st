object enumeration
objectBefore: address 
	"Return the object or start of free space immediately preceding the given
	 address, object or free chunk in memory. If none, return 0.  This is for debugging only."
	| obj nextObj sz |
	<api>
	obj := self oopFromChunk: ((self oop: address isGreaterThan: youngStart)
								ifTrue: [youngStart]
								ifFalse: [self startOfMemory]).
	[self oop: obj isLessThan: address] whileTrue:
		[(self isFreeObject: obj)
			ifTrue: [sz := self sizeOfFree: obj]
			ifFalse: [sz := self sizeBitsOf: obj].
		 nextObj := self oopFromChunk: obj + sz.
		 (self oop: nextObj isGreaterThanOrEqualTo: address) ifTrue:
			[^obj].
		 obj := nextObj].
	^0