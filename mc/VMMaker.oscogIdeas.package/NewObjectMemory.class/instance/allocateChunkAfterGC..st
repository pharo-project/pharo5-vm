allocation
allocateChunkAfterGC: byteSize 
	"Garbage collect and then allocate a chunk of the given size. Sender must be sure
	 that the requested size includes enough space for the header word(s)."
	| newChunk enoughSpace |
	<inline: true>
	<var: #newChunk type: #usqInt>
	enoughSpace := self sufficientSpaceToAllocate: byteSize.
	enoughSpace ifFalse:
		["signal that space is running low, but proceed with allocation if possible"
		 self setSignalLowSpaceFlagAndSaveProcess].
	(self oop: freeStart + byteSize isGreaterThan: reserveStart) ifTrue:
		[^0 "Allocation failed.  Client should e.g. fail the primtive"].

	"if we get here, there is enough space for allocation to succeed "
	newChunk := freeStart.
	freeStart := freeStart + byteSize.
	^self oopForPointer: newChunk