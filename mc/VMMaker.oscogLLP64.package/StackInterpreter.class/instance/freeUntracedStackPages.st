object memory support
freeUntracedStackPages
	"Free any untraced stack pages."
	<var: #thePage type: #'StackPage *'>
	<inline: false>

	0 to: numStackPages - 1 do:
		[:i| | thePage |
		thePage := stackPages stackPageAt: i.
		((stackPages isFree: thePage) not
		 and: [thePage trace = StackPageUnreached]) ifTrue:
			[self assert: (self noMarkedContextsOnPage: thePage).
			 stackPages freeStackPage: thePage].
		self assert: (thePage trace: StackPageTraceInvalid) ~= 0] "Invalidate the trace state for assertion checks"