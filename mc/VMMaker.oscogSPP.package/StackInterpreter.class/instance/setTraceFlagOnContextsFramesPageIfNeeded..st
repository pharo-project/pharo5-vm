object memory support
setTraceFlagOnContextsFramesPageIfNeeded: aContext
	| thePage |
	<inline: false>
	<var: #thePage type: #'StackPage *'>
	(self isStillMarriedContextDuringGC: aContext) ifTrue:
		[thePage := stackPages stackPageFor: (self frameOfMarriedContext: aContext).
		 self assert: (thePage trace between: StackPageUnreached and: StackPageTraced).
		 thePage trace = StackPageUnreached ifTrue:
			[thePage trace: StackPageReachedButUntraced]]