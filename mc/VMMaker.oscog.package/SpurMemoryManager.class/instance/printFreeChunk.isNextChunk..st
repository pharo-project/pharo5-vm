debug printing
printFreeChunk: freeChunk isNextChunk: isNextChunk
	| numBytes |
	numBytes := self bytesInObject: freeChunk.
	coInterpreter
		print: 'freeChunk '; printHexPtrnp: freeChunk;
		print: ' bytes '; printNum: numBytes;
		print: ' next '; printHexPtrnp: (self fetchPointer: self freeChunkNextIndex
											ofFreeChunk: freeChunk).
	(numBytes >= (self numFreeLists * self allocationUnit)
	 and: [isNextChunk not]) ifTrue:
		[coInterpreter
			print: ' ^ '; printHexPtrnp: (self fetchPointer: self freeChunkParentIndex
											ofFreeChunk: freeChunk);
			print: ' < '; printHexPtrnp: (self fetchPointer: self freeChunkSmallerIndex
											ofFreeChunk: freeChunk);
			print: ' > '; printHexPtrnp: (self fetchPointer: self freeChunkLargerIndex
											ofFreeChunk: freeChunk)].
	coInterpreter cr