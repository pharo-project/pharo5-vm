I/O primitives deprecated
primitiveFormPrint
	"On platforms that support it, this primitive prints the receiver, assumed to be a Form, to the default printer."
	self primitiveFailFor: PrimErrUnsupported.
	