compaction
inSortedFreeListLink: freeChunk to: nextFree given: prevFree
	 "Doubly-link the free chunk in address order through the freeChunkNextIndex field using the
	  xor trick to use only one field, see e.g.
		The Art of Computer Programming, Vol 1, D.E. Knuth, 3rd Ed, Sec 2.2.4 `Circular Lists', exercise. 18
		http://en.wikipedia.org/wiki/XOR_linked_list."
	freeChunk = 0
		ifTrue:
			[firstFreeChunk := nextFree]
		ifFalse:
			[manager storePointer: manager freeChunkNextIndex
				ofFreeChunk: freeChunk
				withUncheckedValue: (prevFree bitXor: nextFree)]