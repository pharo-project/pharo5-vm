I/O primitives deprecated
primitiveSetWindowSize
	"Primitive. Answer the OS window's size (extent)"
	<export: true>
	self primitiveFailFor: PrimErrUnsupported.