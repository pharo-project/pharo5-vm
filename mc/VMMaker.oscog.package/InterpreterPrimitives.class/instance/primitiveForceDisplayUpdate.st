I/O primitives deprecated
primitiveForceDisplayUpdate
	"On some platforms, this primitive forces enqueued display updates to be processed immediately. On others, it does nothing."
	self primitiveFailFor: PrimErrUnsupported.