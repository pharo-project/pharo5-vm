object enumeration
firstAccessibleObject
	"Return the first accessible object in the heap."
	| obj |
	obj := self firstObject.
	[self oop: obj isLessThan: freeStart] whileTrue:
		[(self isFreeObject: obj) ifFalse: [^obj].
		 obj := self objectAfter: obj].
	self error: 'heap is empty'.
	^nil