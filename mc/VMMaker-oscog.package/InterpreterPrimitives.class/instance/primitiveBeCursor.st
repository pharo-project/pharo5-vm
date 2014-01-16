I/O primitives deprecated
primitiveBeCursor
	"Set the cursor to the given shape. The Mac only supports 16x16 pixel cursors. Cursor offsets are handled by Smalltalk."

	self primitiveFailFor: PrimErrUnsupported.