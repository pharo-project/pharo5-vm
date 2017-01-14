free space
initializeOldSpaceFirstFree: startOfFreeOldSpace
	<var: 'startOfFreeOldSpace' type: #usqInt>
	| limit freeOldStart freeChunk |
	<var: 'limit' type: #usqInt>
	<var: 'freeOldStart' type: #usqInt>
	limit := endOfMemory - self bridgeSize.
	limit > startOfFreeOldSpace ifTrue:
		[totalFreeOldSpace := totalFreeOldSpace + (limit - startOfFreeOldSpace).
		 freeOldStart := startOfFreeOldSpace.
		 self wordSize > 4 ifTrue:
			[[limit - freeOldStart >= (1 << 32)] whileTrue:
				[freeChunk := self freeChunkWithBytes: (1 << 32) at: freeOldStart.
				 freeOldStart := freeOldStart + (1 << 32).
				 self assert: freeOldStart = (self addressAfter: freeChunk)]].
		freeOldStart < limit ifTrue:
			[freeChunk := self freeChunkWithBytes: limit - freeOldStart at: freeOldStart.
			 self assert: (self addressAfter: freeChunk) = limit]].
	endOfMemory := endOfMemory - self bridgeSize.
	freeOldSpaceStart := endOfMemory.
	self checkFreeSpace: GCModeFreeSpace