initialization
initializeMemoryFirstFree: firstFree 
	"Initialize endOfMemory to the top of oop storage space, reserving some space
	 for forwarding blocks, and set freeStart from which space is allocated."
	"Note: The amount of space reserved for forwarding blocks should be chosen to
	  ensure that incremental compactions can usually be done in a single pass.
	  However, there should be enough forwarding blocks so a full compaction can be done
	  in a reasonable number of passes, say ten. (A full compaction requires N object-moving
	  passes, where N = number of non-garbage objects / number of forwarding blocks).

	di 11/18/2000 Re totalObjectCount: Provide a margin of one byte per object to be
	 used for forwarding pointers at GC time. Since fwd blocks are 8 bytes, this means
	 an absolute worst case of 8 passes to compact memory. In most cases it will be
	 adequate to do compaction in a single pass. "
	| fwdBlockBytes totalReserve |
	"reserve space for forwarding blocks and the interpreter.  We can sacrifice
	 forwarding block space at the cost of slower compactions but we cannot
	 safely sacrifice interpreter allocation headroom."
	fwdBlockBytes := totalObjectCount bitAnd: WordMask - self wordSize + 1.
	totalReserve := fwdBlockBytes + self interpreterAllocationReserveBytes.
	(self oop: memoryLimit - totalReserve isLessThan: firstFree + self baseHeaderSize) ifTrue:
		["reserve enough space for a minimal free block of BaseHeaderSize bytes.
		  We are apparently in an emergency situation here because we have no space
		  for reserve and forwarding blocks.  But a full GC will occur immediately in	
		  sufficientSpaceAfterGC: which will grow memory and restore the reserve."
		 fwdBlockBytes := memoryLimit - (firstFree  + self baseHeaderSize)].

	"set endOfMemory reserveStart and freeStart"
	self setEndOfMemory: memoryLimit - fwdBlockBytes.
	reserveStart := endOfMemory - self interpreterAllocationReserveBytes.
	freeStart := firstFree. "bytes available for oops"
	scavengeThreshold := freeStart + edenBytes min: reserveStart.
	self maybeFillWithAllocationCheckFillerFrom: freeStart to: scavengeThreshold.

	self assert: (self oop: freeStart isLessThan: reserveStart).
	"We would like to assert this but can't because in GC situations it may be false.  It is
	established by sufficientSpaceToAllocate: and sufficientSpaceAfterGC:"
	false ifTrue: [self assert: (self oop: reserveStart isLessThan: endOfMemory)].
	self assert: (self oop: endOfMemory isLessThan: memoryLimit)