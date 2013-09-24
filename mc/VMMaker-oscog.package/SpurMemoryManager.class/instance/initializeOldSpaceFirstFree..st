free space
initializeOldSpaceFirstFree: startOfFreeOldSpace
	<var: 'startOfFreeOldSpace' type: #usqLong>
	| freeOldStart freeChunk |
	<var: 'freeOldStart' type: #usqLong>
	
	endOfMemory > startOfFreeOldSpace ifTrue:
		[totalFreeOldSpace := totalFreeOldSpace + (endOfMemory - startOfFreeOldSpace).
		 freeOldStart := startOfFreeOldSpace.
		 [endOfMemory - freeOldStart >= (2 raisedTo: 32)] whileTrue:
			[freeChunk := self freeChunkWithBytes: (2 raisedTo: 32) at: freeOldStart.
			 freeOldStart := freeOldStart + (2 raisedTo: 32).
			 self assert: freeOldStart = (self addressAfter: freeChunk)].
		freeOldStart < endOfMemory ifTrue:
			[freeChunk := self freeChunkWithBytes: endOfMemory - freeOldStart at: freeOldStart.
			 self assert: (self addressAfter: freeChunk) = endOfMemory]].
	freeOldSpaceStart := endOfMemory.
	self assert: totalFreeOldSpace = self totalFreeListBytes