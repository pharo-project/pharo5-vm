debug support
quickPrintBezier: index first: aBool
	aBool ifTrue:[Transcript cr].
	Transcript nextPut:$(;
		print: (self bzStartX: index)@(self bzStartY: index);
		space;
		print: (self bzViaX: index)@(self bzViaY: index);
		space;
		print: (self bzEndX: index)@(self bzEndY: index);
		nextPut:$).
	Transcript endEntry.