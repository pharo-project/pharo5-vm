object enumeration
objectAfter: oop 
	"Return the object or free chunk immediately following the 
	given object or free chunk in memory. Return endOfMemory 
	when enumeration is complete."
	| sz |
	<api>
	<inline: true>
	DoAssertionChecks
		ifTrue: [(self oop: oop isGreaterThanOrEqualTo:endOfMemory)
					ifTrue: [self error: 'no objects after the end of memory']].
	(self isFreeObject: oop)
		ifTrue: [sz := self sizeOfFree: oop]
		ifFalse: [sz := self sizeBitsOf: oop].
	^ self oopFromChunk: oop + sz