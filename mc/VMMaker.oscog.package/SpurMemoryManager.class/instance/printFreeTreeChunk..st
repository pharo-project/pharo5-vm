debug printing
printFreeTreeChunk: chunkOrZero
	<inline: false> "Slang is blind-sided by the inlining of printFreeTreeChunk: into printFreeTree."
	chunkOrZero > 0 ifTrue:
		[self printFreeTreeChunk: (self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: chunkOrZero).
		 self printFreeChunk: chunkOrZero.
		 self printFreeTreeChunk: (self fetchPointer: self freeChunkLargerIndex ofFreeChunk: chunkOrZero)]