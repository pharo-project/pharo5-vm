simulation
ioNewOS: function Thread: vmThread
	"Fork a new thread to evaluate function with the supplied argument.
	 Return 0 on success and non-zero on error.  The only errors equate
	 to running out of resources, ie. memory.
	 See platforms/Cross/vm/sq.h for the real definition."
	 
	<doNotGenerate>
	[self perform: function with: vmThread] fork.
	^0