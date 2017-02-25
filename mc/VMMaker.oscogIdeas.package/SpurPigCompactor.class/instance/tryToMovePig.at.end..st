compaction
tryToMovePig: pigObj at: pigStart end: pigEnd
	"Try to move a pig (a largish object) to a free chunk in low memory.
	 Answer the freeChunk that was used to house the moved pig, or
	 0 if no free chunk could be found."
	| freeChunk prevFree prevPrevFree pigBytes nextNext |
	prevPrevFree := prevFree := 0.
	freeChunk := firstFreeChunk.
	pigBytes := pigEnd - pigStart.
	[freeChunk ~= 0 and: [freeChunk < pigObj]] whileTrue:
		[| next dest chunkBytes newChunk |
		 next			:= self nextInSortedFreeListLink: freeChunk given: prevFree.
		 dest			:= manager startOfObject: freeChunk.
		 chunkBytes	:= (manager addressAfter: freeChunk) - dest.
		 "N.B. *must* add allocationUnit, not subtract, to avoid unsigned arithmetic issues when chunkBytes = 0"
		 (chunkBytes = pigBytes
		  or: [chunkBytes > (pigBytes + manager allocationUnit)]) ifTrue:
			[manager mem: dest asVoidPointer cp: pigStart asVoidPointer y: pigBytes.
			 manager forwardUnchecked: pigObj to: dest + (pigObj - pigStart).
			 next ~= 0 ifTrue:
				[nextNext  := self nextInSortedFreeListLink: next given: freeChunk].
			 "now either shorten the chunk, or remove it, adjusting the links to keep the list sorted."
			 pigBytes < chunkBytes "if false, filled entire free chunk"
				ifTrue:
					[newChunk := manager initFreeChunkWithBytes: chunkBytes - pigBytes at: dest + pigBytes.
					 self inSortedFreeListLink: prevFree to: newChunk given: prevPrevFree.
					 self inSortedFreeListLink: newChunk to: next given: prevFree.
					 next ~= 0 ifTrue:
						[self inSortedFreeListLink: next to: nextNext given: newChunk]]
				ifFalse:
					[self inSortedFreeListLink: prevFree to: next given: prevPrevFree.
					 next ~= 0 ifTrue:
						[self inSortedFreeListLink: next to: nextNext given: prevFree]].
			 "self checkTraversableSortedFreeList".
			 ^freeChunk].
		 prevPrevFree := prevFree.
		 prevFree := freeChunk.
		 freeChunk := next].
	^0