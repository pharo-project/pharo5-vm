image segment in/out
markAsCopiedIntoSegment: anObjectInTheHeap
	"This is part of storeImageSegmentInto:outPointers:roots:."
	<inline: true>
	self setIsMarkedOf: anObjectInTheHeap to: true