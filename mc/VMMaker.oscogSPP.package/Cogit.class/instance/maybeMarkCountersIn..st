garbage collection
maybeMarkCountersIn: cogMethod
	"In SIsta Spur counters are held on the heap in pinned objects which must be marked
	 to avoid them being garbage collected.  This is the hook through which that happens."
	<var: #cogMethod type: #'CogMethod *'>