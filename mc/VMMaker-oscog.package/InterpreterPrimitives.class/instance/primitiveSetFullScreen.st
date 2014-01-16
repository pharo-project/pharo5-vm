I/O primitives deprecated
primitiveSetFullScreen
	"On platforms that support it, set full-screen mode to the value of the boolean argument."

	self primitiveFailFor: PrimErrUnsupported.