accessing
allObjects
	| strongReferences |
	accessProtect critical: 
		[ strongReferences := Array new: lastUsedIndex.
		strongReferences 
			replaceFrom: 1
			to: lastUsedIndex
			with: weakArray
			startingAt: 1 ].
	^ strongReferences reject: [ :each | each isNil ]