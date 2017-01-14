interpreter shell
dispatchOn: anInteger in: selectorArray
	"Simulate a case statement via selector table lookup.
	The given integer must be between 0 and selectorArray size-1, inclusive.
	For speed, no range test is done, since it is done by the at: operation.
	Note that, unlike many other arrays used in the Interpreter, this method expect NO CArrayAccessor wrapping - it would duplicate the +1. Maybe this would be better updated to make it all uniform"
	selectorArray == BytecodeTable ifTrue:
		[self assert: (anInteger between: bytecodeSetSelector and: bytecodeSetSelector + 255)].
	self perform: (selectorArray at: (anInteger + 1)).