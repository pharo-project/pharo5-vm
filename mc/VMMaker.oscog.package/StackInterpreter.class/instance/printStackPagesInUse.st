debug printing
printStackPagesInUse
	| n |
	n := 0.
	0 to: numStackPages - 1 do:
		[:i|
		(stackPages isFree: (stackPages stackPageAt: i)) ifFalse:
			[self printStackPage: (stackPages stackPageAt: i) useCount: (n := n + 1); cr]]