debug support
quickPrintBezier: bezier
	Transcript cr.
	Transcript nextPut:$(;
		print: (self edgeXValueOf: bezier)@(self edgeYValueOf: bezier);
		space;
		print: (self bezierViaXOf: bezier)@(self bezierViaYOf: bezier);
		space;
		print: (self bezierEndXOf: bezier)@(self bezierEndYOf: bezier);
		nextPut:$).
	Transcript endEntry.