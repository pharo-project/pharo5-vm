primitives-FT2Version
primitiveLibraryHandle
	"Fill in the handle in an FT2Library structure with a copy of our global pointer."
	| rcvr |

	rcvr := self
				primitive: 'primitiveLibraryHandle'
				parameters: #()
				receiver: #FT2Library.
	errorCode := 0.

	self ftAllocateHandleInReceiverForPointer: library

