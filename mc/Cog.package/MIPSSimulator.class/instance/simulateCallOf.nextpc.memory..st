processor api
simulateCallOf: address nextpc: nextpc memory: aMemory
	"Simulate a frame-building call of address.  Build a frame since
	a) this is used for calls into the run-time which are unlikely to be leaf-calls"
	
	self flag: #todo. "Why are we building a frame exactly? Frame building is a callee's job, which I'd expect to be done by some code under simulation. --rmacnak"
	
	self pushWord: self ra in: aMemory.
	self pushWord: self fp in: aMemory.
	self fp: self sp.
	pc := address.