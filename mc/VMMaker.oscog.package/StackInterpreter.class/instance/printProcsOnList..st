debug printing
printProcsOnList: procList
	<api>
	<inline: false>
	| proc firstProc |
	proc := firstProc := objectMemory followField: FirstLinkIndex ofObject: procList.
	[proc = objectMemory nilObject] whileFalse:
		[self printProcessStack: proc.
		 proc := objectMemory followField: NextLinkIndex ofObject: proc.
		 proc = firstProc ifTrue:
			[self warning: 'circular process list!!'.
			 ^nil]]