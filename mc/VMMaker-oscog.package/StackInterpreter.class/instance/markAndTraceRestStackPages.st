object memory support
markAndTraceRestStackPages
	"Read markAndTraceStackPages:'s comment.  
	Finish tracing to-be-traced pages.
	Runs only during full GC"
	
	| thePage foundToBeTracedPage |
	<var: #thePage type: #'StackPage *'>
	<inline: false>

	[foundToBeTracedPage := false.
	0 to: numStackPages - 1 do:
		[:i|
		thePage := stackPages stackPageAt: i.
		((stackPages isFree: thePage) not
		 and: [thePage trace = 1]) ifTrue:
			[foundToBeTracedPage := true.
			 thePage trace: 2.
			 self markAndTraceStackPage: thePage]].
	foundToBeTracedPage] whileTrue.
