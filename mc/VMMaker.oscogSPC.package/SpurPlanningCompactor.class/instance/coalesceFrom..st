private
coalesceFrom: maybeFirstFree
	"manager printOopsFrom: maybeFirstFree to: manager endOfMemory"
	<var: 'maybeFirstFree' type: #usqInt>
	| obj next |
	<var: 'obj' type: #usqInt>
	<var: 'next' type: #usqInt>
	maybeFirstFree >= manager endOfMemory ifTrue:
		[^self].
	obj := maybeFirstFree.
	[next := manager oldSpaceObjectAfter: obj.
	 next < manager endOfMemory] whileTrue:
		[((manager isFreeObject: obj) and: [manager isFreeObject: next])
			ifTrue:
				[manager
					unlinkFreeChunk: obj;
					unlinkFreeChunk: next;
					freeChunkWithBytes: (manager bytesInObject: obj) + (manager bytesInObject: next) at: (manager startOfObject: obj)]
			ifFalse:
				[obj := next]]