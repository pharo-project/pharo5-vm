private
freeFrom: toFinger upTo: limit previousPin: previousPinOrNil
	"Free from toFinger up to limit, dealing with a possible intervening run of pinned objects starting at previousPinOrNil."
	<inline: false>
	| effectiveToFinger pin nextUnpinned start seg |
	<var: #seg type: #'SpurSegmentInfo *'>
	self cCode: [] inSmalltalk:
		[coInterpreter cr; cr; print: 'freeing at '; printHexnp: toFinger; print: ' up to '; printHexnp: limit; print: ' pin '; printHexnp: previousPinOrNil; cr].
	effectiveToFinger := toFinger.
	pin := previousPinOrNil.
	"If the range toFinger to limit spans segments but there is no pin (as when freeing to the end of memory)
	 segment boundaries must still be observed.  So in this case use the nearest bridge above toFinger as the pin."
	pin ifNil:
		[seg := manager segmentManager segmentContainingObj: toFinger.
		 seg segLimit < limit ifTrue:
			[pin := manager segmentManager bridgeFor: seg]].
	[pin notNil] whileTrue:
		[(start := manager startOfObject: pin) > toFinger ifTrue:
			[manager addFreeChunkWithBytes: start - effectiveToFinger at: effectiveToFinger].
		 nextUnpinned := self unmarkPinnedObjectsAndFindFirstUnpinnedOrFreeEntityFollowing: pin.
		 nextUnpinned >= limit ifTrue:
			[^self].
		 effectiveToFinger := manager startOfObject: nextUnpinned.
		 pin := self findNextMarkedPinnedAfter: nextUnpinned].
	manager addFreeChunkWithBytes: limit - effectiveToFinger at: effectiveToFinger