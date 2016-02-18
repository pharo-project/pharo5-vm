free space
freeObject: objOop
	"Free an object in oldSpace.  Coalesce if possible to reduce fragmentation."
	<api>
	<inline: false>
	| bytes start next |
	self assert: (self isInOldSpace: objOop).
	(self isRemembered: objOop) ifTrue:
		[scavenger forgetObject: objOop].
	bytes := self bytesInObject: objOop.
	start := self startOfObject: objOop.
	next := self objectStartingAt: start + bytes.
	(self isFreeObject: next) ifTrue:
		[self detachFreeObject: next.
		 bytes := bytes + (self bytesInObject: next)].
	totalFreeOldSpace := totalFreeOldSpace + bytes.
	^self freeChunkWithBytes: bytes at: start