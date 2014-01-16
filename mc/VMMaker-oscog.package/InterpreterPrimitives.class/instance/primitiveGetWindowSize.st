I/O primitives deprecated
primitiveGetWindowSize
	"Primitive. Answer the OS window's size (extent)"
	<export: true>
	self primitiveFailFor: PrimErrUnsupported.