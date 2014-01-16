I/O primitives deprecated
primitiveGetNextEvent
	"Primitive. Return the next input event from the VM event queue."
	self primitiveFailFor: PrimErrUnsupported.
	