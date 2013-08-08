object memory support
invalidateStackPagesTraceState
	"Invalidate the trace state for assertion checks.
	Runs only during incremental GC"
	| thePage |
	<var: #thePage type: #'StackPage *'>
	<inline: false>

	0 to: numStackPages - 1 do:
		[:i|
			thePage := stackPages stackPageAt: i.
			self assert: (thePage trace: -1) ~= 0]
