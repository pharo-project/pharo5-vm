debug support
clearLeakMapAndMapAccessibleObjects
	"Perform an integrity/leak check using the heapMap.  Set a bit at each object's header."
	<inline: false>
	heapMap clearHeapMap.
	self allObjectsDo:
		[:oop| heapMap heapMapAtWord: (self pointerForOop: oop) Put: 1]