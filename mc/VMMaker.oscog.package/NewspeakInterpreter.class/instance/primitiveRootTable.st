memory space primitives
primitiveRootTable
	"Primitive. Answer a copy (snapshot) element of the root table.
	The primitive can cause GC itself and if so the return value may
	be inaccurate - in this case one should guard the read operation
	by looking at the gc counter statistics."
	self pop: argumentCount + 1 thenPush: self rootTableObject