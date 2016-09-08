debug support
printGET

	| edge |
	Transcript cr; show:'************* GlobalEdgeTable **************'.
	0 to: self getUsedGet - 1 do:[:i|
		edge := getBuffer at: i.
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