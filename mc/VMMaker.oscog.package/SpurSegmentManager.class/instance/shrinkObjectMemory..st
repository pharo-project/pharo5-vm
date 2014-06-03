growing/shrinking memory
shrinkObjectMemory: delta
	| shrinkage emptySeg |
	<var: #emptySeg type: #'SpurSegmentInfo *'>
	shrinkage := delta.
	[emptySeg := self findEmptySegNearestInSizeTo: shrinkage.
	 emptySeg notNil] whileTrue:
		[shrinkage := shrinkage - emptySeg segSize.
		 manager detachFreeObject: (manager objectStartingAt: emptySeg segStart).
		 self removeSegment: emptySeg]