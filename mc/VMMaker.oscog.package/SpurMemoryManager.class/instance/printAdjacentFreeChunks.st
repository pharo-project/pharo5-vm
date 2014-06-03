debug support
printAdjacentFreeChunks
	"self printAdjacentFreeChunks"
	<doNotGenerate>
	| uncoalesced |
	uncoalesced := OrderedCollection new.
	self allOldSpaceEntitiesDo:
		[:e| | s |
		((self isFreeObject: e)
		 and: [(s := self objectAfter: e limit: endOfMemory) < endOfMemory
		 and: [self isFreeObject: s]]) ifTrue:
			[uncoalesced addLast: e]].
	uncoalesced do:
		[:f|
		self printFreeChunk: f. coInterpreter printHexnp: (self objectAfter: f limit: endOfMemory); cr] 
