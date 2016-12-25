compaction
nextInSortedFreeListLink: freeChunk given: prevFree
	 "Answer the next free free chunk using the xor trick to use only one field, see e.g.
		The Art of Computer Programming, Vol 1, D.E. Knuth, 3rd Ed, Sec 2.2.4 `Circular Lists', exercise. 18
		http://en.wikipedia.org/wiki/XOR_linked_list."
	<inline: true>
	^((manager fetchPointer: manager freeChunkNextIndex ofFreeChunk: freeChunk) bitXor: prevFree) asUnsignedInteger