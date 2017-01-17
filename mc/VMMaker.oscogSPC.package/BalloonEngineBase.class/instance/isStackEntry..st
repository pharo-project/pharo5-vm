testing
isStackEntry: entry
	^entry >= self wbTopGet and:[entry < self wbSizeGet]