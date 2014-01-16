I/O primitives deprecated
primitiveGetWindowLabel
	"Primitive. Answer the OS window's label"
	<export: true>
	self primitiveFailFor: PrimErrUnsupported.