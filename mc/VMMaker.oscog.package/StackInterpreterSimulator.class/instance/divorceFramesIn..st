debugging traps
divorceFramesIn: aStackPage
	"| thisPage |
	(self checkIsStillMarriedContext: 22189568 currentFP: framePointer) ifTrue:
		[thisPage := stackPages stackPageFor: (self frameOfMarriedContext: 22189568).
		 aStackPage == thisPage ifTrue:
			[self halt]]."
	^super divorceFramesIn: aStackPage