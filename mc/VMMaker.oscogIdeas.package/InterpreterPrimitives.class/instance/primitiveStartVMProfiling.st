process primitives
primitiveStartVMProfiling
	"Primitive. Start the VM profiler."
	self cCode: 'ioControlProfile(1,0,0,0,0)'.
	self pop: argumentCount