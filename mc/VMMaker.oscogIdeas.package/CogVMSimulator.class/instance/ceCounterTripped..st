cog jit support
ceCounterTripped: condition
	| counterTrippedSelector |
	self transcript cr; nextPutAll: 'counter tripped in '.
	self shortPrintFrame: framePointer.
	counterTrippedSelector := objectMemory maybeSplObj: SelectorCounterTripped.
	(counterTrippedSelector isNil
	or: [counterTrippedSelector = objectMemory nilObject]) ifFalse:
		[self halt: 'counter tripped'].
	^super ceCounterTripped: condition