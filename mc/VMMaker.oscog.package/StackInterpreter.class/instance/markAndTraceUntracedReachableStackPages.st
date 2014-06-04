object memory support
markAndTraceUntracedReachableStackPages
	"Trace any untraced pages"
	| thePage foundToBeTracedPage |
	<var: #thePage type: #'StackPage *'>
	<inline: false>

	[foundToBeTracedPage := false.
	0 to: numStackPages - 1 do:
		[:i|
		thePage := stackPages stackPageAt: i.
		((stackPages isFree: thePage) not
		 and: [thePage trace = StackPageReachedButUntraced]) ifTrue:
			[foundToBeTracedPage := true.
			 self markAndTraceStackPage: thePage]].
	foundToBeTracedPage] whileTrue