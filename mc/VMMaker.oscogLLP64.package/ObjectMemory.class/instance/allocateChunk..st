allocation
allocateChunk: byteSize 
	"Allocate a chunk of the given size. Sender must be sure that  the requested size includes enough space for the header  word(s). " 
	"Details: To limit the time per incremental GC, do one every so many allocations. The number is settable via primitiveVMParameter to tune your memory system"
	| enoughSpace newFreeSize newChunk |
	<inline: true>

	allocationCount >= allocationsBetweenGCs
		ifTrue: ["do an incremental GC every so many allocations to  keep pauses short"
			self incrementalGC].

	enoughSpace := self sufficientSpaceToAllocate: byteSize.
	enoughSpace
		ifFalse: ["signal that space is running low, but proceed with allocation if possible"
			signalLowSpace := true.
			lowSpaceThreshold := 0. "disable additional interrupts until lowSpaceThreshold is reset by image"
			self saveProcessSignalingLowSpace.
			self forceInterruptCheck].
	(self oop: (self sizeOfFree: freeBlock) isLessThan: byteSize + self baseHeaderSize)
		ifTrue: [self error: 'out of memory'].

	"if we get here, there is enough space for allocation to  succeed "
	newFreeSize := (self sizeOfFree: freeBlock) - byteSize.
	newChunk := freeBlock.
	freeBlock := freeBlock + byteSize.

	"Assume: client will initialize object header of free chunk, so following is not needed:"
	"self setSizeOfFree: newChunk to: byteSize."
	self setSizeOfFree: freeBlock to: newFreeSize.
	allocationCount := allocationCount + 1.
	^newChunk