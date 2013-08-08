debug printing
printProcsOnList: procList
	<api>
	<inline: false>
	| proc firstProc |
	proc := firstProc := objectMemory fetchPointer: FirstLinkIndex ofObject: procList.
	[proc = objectMemory nilObject] whileFalse:
		[self printProcessStack: proc.
		 proc := objectMemory fetchPointer: NextLinkIndex ofObject: proc.
		 proc = firstProc ifTrue:
			[self warning: 'circular process list!!'.
			 ^nil]]