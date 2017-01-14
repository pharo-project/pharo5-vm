object enumeration
objectExactlyBefore: oop 
	"Return the object or start of free space immediately preceding the given
	 object or free chunk in memory. If none, return 0.  This is for debugging only."
	| obj nextObj sz |
	<api>
	obj := self oopFromChunk: ((self oop: oop isGreaterThan: youngStart)
								ifTrue: [youngStart]
								ifFalse: [self startOfMemory]).
	[self oop: obj isLessThan: obj] whileTrue:
		[(self isFreeObject: obj)
			ifTrue: [sz := self sizeOfFree: obj]
			ifFalse: [sz := self sizeBitsOf: obj].
		 nextObj := self oopFromChunk: obj + sz.
		 nextObj = oop ifTrue:
			[^obj].
		 obj := nextObj].
	^0