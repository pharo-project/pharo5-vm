execution
simulateCallOf: address nextpc: nextpc memory: aMemory
	"Simulate a frame-building call of address.  Build a frame since
	a) this is used for calls into the run-time which are unlikely to be leaf-calls, and
	b) stack alignment needs to be realistic for assert checking

	From the System V ABI:
	 3.2.2 The Stack Frame
	 ...	The end of the input argument area shall be aligned on a 16 (32, if __m256 is
		passed on stack) byte boundary. In other words, the value (%rsp + 8) is always
		a multiple of 16 (32) when control is transferred to the function entry point."
	self pushWord: nextpc in: aMemory.
	self pushWord: self rbp in: aMemory.
	self rbp: self rsp.
	PostBuildStackDelta ~= 0 ifTrue:
		[self rsp: self rsp - PostBuildStackDelta].
	self rip: address