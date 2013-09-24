debug printing
printFreeChunk: freeChunk
	<doNotGenerate>
	| numBytes |
	numBytes := self bytesInObject: freeChunk.
	coInterpreter
		print: 'freeChunk @ '; printHexPtr: freeChunk;
		print: ' bytes '; printNum: numBytes;
		print: ' next '; print: (self fetchPointer: self freeChunkNextIndex
									ofFreeChunk: freeChunk) hex.
	numBytes / self allocationUnit > NumFreeLists ifTrue:
		[coInterpreter
			print: ' ^ '; print: (self fetchPointer: self freeChunkParentIndex
									ofFreeChunk: freeChunk) hex;
			print: ' < '; print: (self fetchPointer: self freeChunkSmallerIndex
									ofFreeChunk: freeChunk) hex;
			print: ' > '; print: (self fetchPointer: self freeChunkLargerIndex
									ofFreeChunk: freeChunk) hex].
	coInterpreter cr