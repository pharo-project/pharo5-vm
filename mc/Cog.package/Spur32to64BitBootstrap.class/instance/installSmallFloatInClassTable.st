bootstrap image
installSmallFloatInClassTable
	| firstPage |
	firstPage := heap64 fetchPointer: 0 ofObject: heap64 classTableRootObj.
	heap64
		storePointer: heap64 smallFloatTag
		ofObject: firstPage
		withValue: self smallFloatClass