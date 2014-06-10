object memory support
markAndTraceAndMaybeFreeStackPages: fullGCFlag
	"Read markAndTraceStackPages:'s comment.  Finish tracing to-be-traced pages.
	 Then free any untraced pages."
	<var: #thePage type: #'StackPage *'>
	<inline: false>
	fullGCFlag ifFalse:
		[0 to: numStackPages - 1 do:
			[:i| | thePage |
			thePage := stackPages stackPageAt: i.
			self assert: (thePage trace: -1) ~= 0]. "Invalidate the trace state for assertion checks"
		^nil].

	self markAndTraceUntracedReachableStackPages.
	self freeUntracedStackPages