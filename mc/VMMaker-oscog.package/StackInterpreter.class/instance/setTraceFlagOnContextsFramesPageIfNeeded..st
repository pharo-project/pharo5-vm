object memory support
setTraceFlagOnContextsFramesPageIfNeeded: aContext
	| thePage |
	<var: #thePage type: #'StackPage *'>
	(self isStillMarriedContext: aContext) ifTrue:
		[thePage := stackPages stackPageFor: (self frameOfMarriedContext: aContext).
		 self assert: (thePage trace between: 0 and: 2).
		 thePage trace = 0 ifTrue:
			[thePage trace: 1]]