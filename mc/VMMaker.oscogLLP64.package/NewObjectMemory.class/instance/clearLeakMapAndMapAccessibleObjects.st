debug support
clearLeakMapAndMapAccessibleObjects
	"Perform an integrity/leak check using the heapMap.  Set a bit at each object's header."
	| obj sz nextHeader |
	<inline: false>
	<var: #obj type: #usqInt>
	<var: #sz type: #usqInt>
	<var: #nextHeader type: #usqInt>
	heapMap clearHeapMap.
	obj := self firstObject.
	[self oop: obj isLessThan: freeStart] whileTrue:
		[(self isFreeObject: obj)
			ifTrue:
				[sz := self sizeOfFree: obj]
			ifFalse:
				[heapMap heapMapAtWord: (self pointerForOop: obj) Put: 1.
				 sz := self sizeBitsOf: obj].
		nextHeader := obj + sz.
		obj := self oopFromChunk: nextHeader].