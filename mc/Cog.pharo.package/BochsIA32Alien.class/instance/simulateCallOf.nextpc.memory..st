execution
simulateCallOf: address nextpc: nextpc memory: aMemory
	"Simulate a frame-building call of address.  Build a frame since
	a) this is used for calls into the run-time which are unlikely to be leaf-calls, and
	b) stack alignment needs to be realistic for assert checking for platforms such as Mac OS X"
	self pushWord: nextpc in: aMemory.
	self pushWord: self ebp in: aMemory.
	self ebp: self esp.
	PostBuildStackDelta ~= 0 ifTrue:
		[self esp: self esp - PostBuildStackDelta].
	self eip: address