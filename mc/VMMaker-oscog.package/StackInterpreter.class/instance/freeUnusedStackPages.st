object memory support
freeUnusedStackPages
	"free any untraced pages. Note: used only during full GC "
	| thePage |
	<var: #thePage type: #'StackPage *'>
	<inline: false>

	0 to: numStackPages - 1 do:
		[:i|
		thePage := stackPages stackPageAt: i.
		((stackPages isFree: thePage) not
		 and: [thePage trace = 0]) ifTrue:
			[self assert: (self noMarkedContextsOnPage: thePage).
			 stackPages freeStackPage: thePage].
		self assert: (thePage trace: -1) ~= 0] "Invalidate the trace state for assertion checks"