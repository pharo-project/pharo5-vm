munging
indexOfSelector: selectorOop in: methodDict
	SelectorStart to: (heap numSlotsOf: methodDict) - 1 do:
		[:i|
		(heap fetchPointer: i ofObject: methodDict) = selectorOop ifTrue:
			[^i]].
	self error: 'could not find selector in method dict'