debug support
printAET

	| edge |
	Transcript cr; show:'************* ActiveEdgeTable **************'.
	0 to: self aetUsedGet - 1 do:[:i|
		edge := aetBuffer at: i.
		Transcript cr;
			print: i; space;
			nextPutAll:'edge #';print: edge; space;
			nextPutAll:'x: '; print: (self edgeXValueOf: edge); space;
			nextPutAll:'y: '; print: (self edgeYValueOf: edge); space;
			nextPutAll:'z: '; print: (self edgeZValueOf: edge); space;
			nextPutAll:'fill0: '; print: (self edgeLeftFillOf: edge); space;
			nextPutAll:'fill1: '; print: (self edgeRightFillOf: edge); space;
			nextPutAll:'lines: '; print: (self edgeNumLinesOf: edge); space.
		(self areEdgeFillsValid: edge) ifFalse:[Transcript nextPutAll:' disabled'].
		Transcript endEntry.
	].