free space
freeListHeadsEmpty
	0 to: self numFreeLists - 1 do:
		[:i| (freeLists at: i) ~= 0 ifTrue: [^false]].
	^true