growing/shrinking memory
shrinkObjectMemory: delta
	"Answer if any shrinkage was achieved."
	<inline: false>
	<var: #delta type: #usqInt>
	| shrinkage emptySeg |
	<var: #shrinkage type: #usqInt>
	<var: #emptySeg type: #'SpurSegmentInfo *'>
	manager checkFreeSpace: GCModeFreeSpace.
	shrinkage := delta.
	[emptySeg := self findEmptySegNearestInSizeTo: shrinkage.
	 (emptySeg isNil
	  or: [emptySeg segSize > shrinkage]) ifTrue:
		[manager checkFreeSpace: GCModeFreeSpace.
		 ^shrinkage < delta].
	 shrinkage := shrinkage - emptySeg segSize.
	 manager detachFreeObject: (manager objectStartingAt: emptySeg segStart).
	 self removeSegment: emptySeg] repeat