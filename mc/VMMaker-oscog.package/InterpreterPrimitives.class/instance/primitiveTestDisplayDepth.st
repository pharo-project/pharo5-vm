I/O primitives deprecated
primitiveTestDisplayDepth
	"Return true if the host OS does support the given display depth."
	self primitiveFailFor: PrimErrUnsupported.