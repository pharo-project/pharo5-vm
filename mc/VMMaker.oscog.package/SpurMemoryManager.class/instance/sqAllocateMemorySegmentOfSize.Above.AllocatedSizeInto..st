simulation only
sqAllocateMemorySegmentOfSize: segmentSize Above: minAddress AllocatedSizeInto: allocSizePtrOrBlock
	<doNotGenerate>
	"Simulate heap growth by growing memory by segmentSize + a delta.
	 To test bridges alternate the delta between 0 bytes and 1M bytes
	 depending on the number of segments.
	 The delta will be the distance between segments to be bridged."
	| delta newMemory start |
	delta := segmentManager numSegments odd ifTrue: [1024 * 1024] ifFalse: [0].
	"A previous shrink may have freed up memory.  Don't bother to grow if there's already room."
	segmentManager lastSegment segLimit + segmentSize + delta <= (memory size * 4) ifTrue:
		[allocSizePtrOrBlock value: segmentSize.
		 ^minAddress + delta].
	start := memory size * 4 + delta.
	newMemory := memory class new: memory size + (segmentSize + delta / 4).
	newMemory replaceFrom: 1 to: memory size with: memory startingAt: 1.
	memory := newMemory.
	allocSizePtrOrBlock value: segmentSize.
	^start