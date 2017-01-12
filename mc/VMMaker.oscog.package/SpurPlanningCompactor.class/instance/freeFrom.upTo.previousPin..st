private
freeFrom: toFinger upTo: limit previousPin: previousPinOrNil
	"Free from toFinger up to limit, dealing with a possible intervening run of pinned objects starting at previousPinOrNil."
	| effectiveToFinger firstUnpinned |
	self cCode: [] inSmalltalk:
		[coInterpreter cr; cr; print: 'freeing at '; printHexnp: toFinger; print: ' up to '; printHexnp: limit; print: ' pin '; printHexnp: previousPinOrNil; cr].
	effectiveToFinger := toFinger.
	previousPinOrNil ifNotNil:
		[manager addFreeChunkWithBytes: (manager startOfObject: previousPinOrNil) - toFinger at: toFinger.
		 firstUnpinned := self unmarkPinnedObjectsAndFindFirstUnpinnedObjectFollowing: previousPinOrNil.
		 firstUnpinned >= limit ifTrue:
			[^self].
		 effectiveToFinger := manager startOfObject: firstUnpinned].
	manager addFreeChunkWithBytes: limit - effectiveToFinger at: effectiveToFinger