bootstrap methods
indexOfSelector: selectorOop in: methodDict
	SelectorStart to: (oldHeap numSlotsOf: methodDict) - 1 do:
		[:i|
		(oldHeap fetchPointer: i ofObject: methodDict) = selectorOop ifTrue:
			[^i]].
	self error: 'could not find selector in method dict'