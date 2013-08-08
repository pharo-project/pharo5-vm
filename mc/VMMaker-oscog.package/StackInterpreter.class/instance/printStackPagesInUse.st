debug printing
printStackPagesInUse
	0 to: numStackPages - 1 do:
		[:i|
		(stackPages isFree: (stackPages stackPageAt: i)) ifFalse:
			[self printStackPage: (stackPages stackPageAt: i).
			 self cr]]