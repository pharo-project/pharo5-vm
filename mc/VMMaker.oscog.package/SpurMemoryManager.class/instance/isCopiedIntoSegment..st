image segment in/out
isCopiedIntoSegment: anObjectInTheHeap
	"This is part of storeImageSegmentInto:outPointers:roots:."
	<inline: true>
	^self isMarked: anObjectInTheHeap