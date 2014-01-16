I/O primitives deprecated
primitiveMousePoint
	"Obsolete on virtually all platforms; old style input polling code.
	Return a Point indicating current position of the mouse. Note that mouse coordinates may be negative if the mouse moves above or to the left of the top-left corner of the Smalltalk window."

	self primitiveFailFor: PrimErrUnsupported.