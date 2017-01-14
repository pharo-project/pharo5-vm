debug support
bitsSetInFreeSpaceMaskForAllFreeLists
	0 to: self numFreeLists - 1 do:
		[:i|
		((freeLists at: i) ~= 0
		 and: [1 << i noMask: freeListsMask]) ifTrue:
			[^false]].
	^true