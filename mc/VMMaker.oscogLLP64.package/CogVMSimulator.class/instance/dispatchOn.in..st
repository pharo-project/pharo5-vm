interpreter shell
dispatchOn: anInteger in: selectorArray
	"Simulate a case statement via selector table lookup.
	The given integer must be between 0 and selectorArray size-1, inclusive.
	For speed, no range test is done, since it is done by the at: operation.
	Note that, unlike many other arrays used in the Interpreter, this method expect NO CArrayAccessor wrapping - it would duplicate the +1. Maybe this would be better updated to make it all uniform"
	cogit breakPC ifNil:
		[cogit breakBlock ifNotNil:
			[:bb| (bb value: cogit) ifTrue: [self halt: 'breakpoint reached']]].
	self perform: (selectorArray at: (anInteger + 1)).