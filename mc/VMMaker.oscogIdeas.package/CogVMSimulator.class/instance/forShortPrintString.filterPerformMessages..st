control primitives
forShortPrintString: shortPrintString filterPerformMessages: aCollection
	performFilters ifNil:
		[performFilters := Dictionary new].
	performFilters at: shortPrintString put: aCollection