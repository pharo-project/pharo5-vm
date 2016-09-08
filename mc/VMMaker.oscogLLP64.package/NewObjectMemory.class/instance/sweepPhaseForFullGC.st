garbage collection
sweepPhaseForFullGC
	"Sweep memory from youngStart through the end of memory. Free all
	 inaccessible objects and coalesce adjacent free chunks. Clear the mark
	 bits of accessible objects. Compute the starting point for the first pass
	 of incremental compaction (compStart). Return the number of surviving
	 objects.  Unlike sweepPhase this always leaves compStart pointing at the
	 first free chunk."
	| survivors freeChunk firstFree oop oopHeader oopHeaderType hdrBytes oopSize freeChunkSize endOfMemoryLocal |
	<inline: false>
	<var: #oop type: #usqInt>
	<var: #endOfMemoryLocal type: #usqInt>
	self fwdTableInit: self wordSize*2.
	survivors := 0.
	freeChunk := nil.
	firstFree := nil.
	"will be updated later"
	endOfMemoryLocal := endOfMemory.
	oop := self oopFromChunk: youngStart.
	[oop < endOfMemoryLocal]
		whileTrue: ["get oop's header, header type, size, and header size"
			statSweepCount := statSweepCount + 1.
			oopHeader := self baseHeader: oop.
			oopHeaderType := oopHeader bitAnd: TypeMask.
			hdrBytes := headerTypeBytes at: oopHeaderType.
			(oopHeaderType bitAnd: 1) = 1
				ifTrue: [oopSize := oopHeader bitAnd: SizeMask]
				ifFalse: [oopHeaderType = HeaderTypeSizeAndClass
						ifTrue: [oopSize := (self sizeHeader: oop) bitAnd: LongSizeMask]
						ifFalse: [self assert: (oopHeader bitAnd: MarkBit) = 0.
								oopSize := oopHeader bitAnd: LongSizeMask]].
			(oopHeader bitAnd: MarkBit) = 0
				ifTrue: ["object is not marked; free it"
					"<-- Finalization support: We need to mark each oop chunk as free -->"
					self longAt: oop - hdrBytes put: HeaderTypeFree.
					freeChunk ~= nil
						ifTrue: ["enlarge current free chunk to include this oop"
							freeChunkSize := freeChunkSize + oopSize + hdrBytes]
						ifFalse: ["start a new free chunk"
							freeChunk := oop - hdrBytes.
							"chunk may start 4 or 8 bytes before oop"
							freeChunkSize := oopSize + (oop - freeChunk).
							"adjust size for possible extra header bytes"
							firstFree = nil ifTrue: [firstFree := freeChunk]]]
				ifFalse: ["object is marked; clear its mark bit and possibly adjust 
					the compaction start"
					self longAt: oop put: (oopHeader bitAnd: AllButMarkBit).
					"<-- Finalization support: Check if we're running about a weak class -->"
					(self isWeakNonImm: oop) ifTrue: [self finalizeReference: oop].
					freeChunk ~= nil
						ifTrue: ["record the size of the last free chunk"
							self longAt: freeChunk put: ((freeChunkSize bitAnd: LongSizeMask) bitOr: HeaderTypeFree).
							freeChunk := nil].
					survivors := survivors + 1].
			oop := self oopFromChunk: oop + oopSize].
	freeChunk ~= nil
		ifTrue: ["record size of final free chunk"
			self longAt: freeChunk put: ((freeChunkSize bitAnd: LongSizeMask) bitOr: HeaderTypeFree)].
	oop = endOfMemory
		ifTrue: [freeStart := endOfMemory]
		ifFalse: [self error: 'sweep failed to find exact end of memory'].
	firstFree = nil
		ifTrue: [self error: 'expected to find at least one free object']
		ifFalse: [compStart := firstFree].

	^ survivors