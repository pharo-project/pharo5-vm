debug support
clearLeakMapAndMapAccessibleObjects
	"Perform an integrity/leak check using the heapMap.  Set a bit at each object's header."
	| oop |
	<inline: false>
	self clearHeapMap.
	oop := self firstObject.
	[oop = nil] whileFalse:
		[self heapMapAtWord: (self pointerForOop: oop) Put: 1.
		 oop := self accessibleObjectAfter: oop]