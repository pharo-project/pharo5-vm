spur primitive compilation
accessorChainsForMethod: method interpreterClass: interpreterClass
	inProgressSelectors := Set new.
	^[super accessorChainsForMethod: method interpreterClass: interpreterClass] ensure:
		[inProgressSelectors := nil]