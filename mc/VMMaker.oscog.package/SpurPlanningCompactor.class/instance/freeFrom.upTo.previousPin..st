private
freeFrom: toFinger upTo: limit previousPin: previousPinOrNil
	"Free from toFinger up to limit, dealing with a possible intervening run of pinned objects starting at previousPinOrNil."
	<inline: false>
	| effectiveToFinger pin nextUnpinned start |
	self cCode: [] inSmalltalk:
		[coInterpreter cr; cr; print: 'freeing at '; printHexnp: toFinger; print: ' up to '; printHexnp: limit; print: ' pin '; printHexnp: previousPinOrNil; cr].
	effectiveToFinger := toFinger.
	pin := previousPinOrNil.
	[pin notNil] whileTrue:
		[(start := manager startOfObject: pin) > toFinger ifTrue:
			[manager addFreeChunkWithBytes: start - effectiveToFinger at: effectiveToFinger].
		 nextUnpinned := self unmarkPinnedObjectsAndFindFirstUnpinnedOrFreeEntityFollowing: pin.
		 nextUnpinned >= limit ifTrue:
			[^self].
		 effectiveToFinger := manager startOfObject: nextUnpinned.
		 pin := self findNextMarkedPinnedAfter: nextUnpinned].
	manager addFreeChunkWithBytes: limit - effectiveToFinger at: effectiveToFinger