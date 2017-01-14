debug support
printFreeChunks
	"This version goes through memory, printing all free chunks.
	 Other versions go through the free lists.  This one will show
	 all free chunks even if the free lists are corrupt."
	<api>
	| seenNewFreeChunk |
	seenNewFreeChunk := false.
	self allNewSpaceEntitiesDo:
		[:o|
		(self isFreeObject: o) ifTrue:
			[seenNewFreeChunk ifFalse:
				[coInterpreter print: 'NewSpace CONTAINS FREE OBJECT(S)!!'; cr.
				 seenNewFreeChunk := true].
			 self printFreeChunk: o]].
	self allOldSpaceEntitiesDo:
		[:o|
		(self isFreeObject: o) ifTrue:
			[self printFreeChunk: o]]