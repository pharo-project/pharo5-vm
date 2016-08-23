scavenger
rememberedSetObj: anObj
	self assert: (self isOldObject: anObj).
	self storePointerUnchecked: RememberedSetRootIndex ofObject: hiddenRootsObj withValue: anObj