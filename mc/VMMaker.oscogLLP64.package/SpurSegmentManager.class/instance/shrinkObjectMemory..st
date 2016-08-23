growing/shrinking memory
shrinkObjectMemory: delta
	<inline: false>
	<var: #delta type: #usqInt>
	| shrinkage emptySeg |
	<var: #shrinkage type: #usqInt>
	<var: #emptySeg type: #'SpurSegmentInfo *'>
	shrinkage := delta.
	[emptySeg := self findEmptySegNearestInSizeTo: shrinkage.
	 emptySeg notNil] whileTrue:
		[emptySeg segSize > shrinkage ifTrue:
			[^self].
		 shrinkage := shrinkage - emptySeg segSize.
		 manager detachFreeObject: (manager objectStartingAt: emptySeg segStart).
		 self removeSegment: emptySeg]