debug printing
printProcsOnList: procList
	<api>
	<inline: false>
	| proc firstProc |
	proc := firstProc := self fetchPointer: FirstLinkIndex ofObject: procList.
	[proc = self nilObject] whileFalse:
		[self printProcessStack: proc.
		 proc := self fetchPointer: NextLinkIndex ofObject: proc.
		 proc = firstProc ifTrue:
			[self warning: 'circular process list!!'.
			 ^nil]]