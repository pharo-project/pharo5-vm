private
freeFrom: initialToFinger upTo: limit nextObject: nextObject
	"Free from toFinger up to limit, dealing with possible intervening pinned objects."
	<inline: false>
	<var: 'limit' type: #usqInt>
	<var: 'initialToFinger' type: #usqInt>
	| toFinger obj objStart |
	<var: 'objStart' type: #usqInt>
	<var: 'toFinger' type: #usqInt>
	self cCode: [] inSmalltalk:
		[coInterpreter cr; cr; print: 'freeing at '; printHexnp: initialToFinger; print: ' up to '; printHexnp: limit; cr].
	toFinger := initialToFinger.
	objStart := manager startOfObject: nextObject.
	toFinger < objStart ifTrue:
		[manager addFreeChunkWithBytes: objStart - toFinger at: toFinger].
	toFinger := objStart.
	[objStart < limit] whileTrue:
		[obj := manager objectStartingAt: objStart.
		 ((manager isMarked: obj) and: [manager isPinned: obj])
			ifTrue:
				[self unmarkPinned: obj.
				 toFinger < objStart ifTrue:
					[manager addFreeChunkWithBytes: objStart - toFinger at: toFinger].
				 toFinger := objStart := manager addressAfter: obj]
			ifFalse:
				[objStart := manager addressAfter: obj]].
	limit > toFinger ifTrue:
		[manager addFreeChunkWithBytes: limit - toFinger at: toFinger]