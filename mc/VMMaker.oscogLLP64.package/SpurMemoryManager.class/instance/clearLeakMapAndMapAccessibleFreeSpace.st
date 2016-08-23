debug support
clearLeakMapAndMapAccessibleFreeSpace
	"Perform an integrity/leak check using the heapMap.  Set a bit at each free chunk's header."
	<inline: false>
	heapMap clearHeapMap.
	self allOldSpaceEntitiesFrom: self firstObject
		do: [:objOop|
			(self isFreeObject: objOop) ifTrue:
				[heapMap heapMapAtWord: (self pointerForOop: objOop) Put: 1]]