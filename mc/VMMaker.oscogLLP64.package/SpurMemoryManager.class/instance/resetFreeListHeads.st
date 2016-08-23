free space
resetFreeListHeads
	0 to: self numFreeLists - 1 do:
		[:i| freeLists at: i put: 0]