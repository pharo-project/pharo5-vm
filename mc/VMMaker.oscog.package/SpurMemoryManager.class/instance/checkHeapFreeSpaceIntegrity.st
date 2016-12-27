debug support
checkHeapFreeSpaceIntegrity
	"Perform an integrity/leak check using the heapMap.  Assume clearLeakMapAndMapAccessibleFreeSpace
	 has set a bit at each free chunk's header.  Scan all objects in the heap checking that no pointer points
	 to a free chunk and that all free chunks that refer to others refer to marked chunks.  Answer if all checks pass."
	| ok total |
	<inline: false>
	<var: 'total' type: #usqInt>
	ok := true.
	total := 0.
	0 to: self numFreeLists - 1 do:
		[:i|
		(freeLists at: i) ~= 0 ifTrue:
			[(heapMap heapMapAtWord: (self pointerForOop: (freeLists at: i))) = 0 ifTrue:
				[coInterpreter print: 'leak in free list '; printNum: i; print: ' to non-free '; printHex: (freeLists at: i); cr.
				 self eek.
				 ok := false]]].

	"Excuse the duplication but performance is at a premium and we avoid
	 some tests by splitting the newSpace and oldSpace enumerations."
	self allNewSpaceEntitiesDo:
		[:obj| | fieldOop |
		 (self isFreeObject: obj)
			ifTrue:
				[coInterpreter print: 'young object '; printHex: obj; print: ' is free'; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[0 to: (self numPointerSlotsOf: obj) - 1 do:
					[:fi|
					 fieldOop := self fetchPointer: fi ofObject: obj.
					 (self isNonImmediate: fieldOop) ifTrue:
						[(heapMap heapMapAtWord: (self pointerForOop: fieldOop)) ~= 0 ifTrue:
							[coInterpreter print: 'object leak in '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; print: ' is free'; cr.
							 self eek.
							 ok := false]]]]].
	self allOldSpaceEntitiesDo:
		[:obj| | fieldOop |
		(self isFreeObject: obj)
			ifTrue:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0 ifTrue:
					[coInterpreter print: 'leak in free chunk '; printHex: obj; print: ' is unmapped?! '; cr.
					 self eek.
					 ok := false].
				 fieldOop := self fetchPointer: self freeChunkNextIndex ofFreeChunk: obj.
				 (fieldOop ~= 0
				 and: [(heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0]) ifTrue:
					[coInterpreter print: 'leak in free chunk '; printHex: obj; print: ' @ 0 = '; printHex: fieldOop; print: ' is unmapped'; cr.
					 self eek.
					 ok := false].
				(self isLargeFreeObject: obj) ifTrue:
					[self freeChunkParentIndex to: self freeChunkLargerIndex do:
						[:fi|
						 fieldOop := self fetchPointer: fi ofFreeChunk: obj.
						 (fieldOop ~= 0
						 and: [(heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0]) ifTrue:
							[coInterpreter print: 'leak in free chunk '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; print: ' is unmapped'; cr.
							 self eek.
							 ok := false]]].
				total := total + (self bytesInObject: obj)]
			ifFalse:
				[0 to: (self numPointerSlotsOf: obj) - 1 do:
					[:fi|
					 fieldOop := self fetchPointer: fi ofObject: obj.
					 (self isNonImmediate: fieldOop) ifTrue:
						[(heapMap heapMapAtWord: (self pointerForOop: fieldOop)) ~= 0 ifTrue:
							[coInterpreter print: 'object leak in '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; print: ' is free'; cr.
							 self eek.
							 ok := false]]]]].
	total ~= totalFreeOldSpace ifTrue:
		[coInterpreter print: 'incorrect totalFreeOldSpace; expected '; printNum: totalFreeOldSpace; print: ' found '; printNum: total; cr.
		 self eek.
		 ok := false].
	^ok