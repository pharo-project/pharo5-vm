private
coalesceFrom: maybeStartOfFree
	"manager printOopsFrom: maybeStartOfFree to: manager endOfMemory"
	<var: 'maybeStartOfFree' type: #usqInt>
	| obj next |
	<var: 'obj' type: #usqInt>
	<var: 'next' type: #usqInt>
	maybeStartOfFree >= manager endOfMemory ifTrue:
		[^self].
	obj := manager objectStartingAt: maybeStartOfFree.
	[next := manager oldSpaceObjectAfter: obj.
	 next < manager endOfMemory] whileTrue:
		[((manager isFreeObject: obj) and: [manager isFreeObject: next])
			ifTrue:
				[manager unlinkFreeChunk: obj.
				 manager unlinkFreeChunk: next.
				 obj := manager freeChunkWithBytes: (manager bytesInObject: obj) + (manager bytesInObject: next) at: (manager startOfObject: obj)]
			ifFalse:
				[obj := next]]