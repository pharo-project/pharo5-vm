control primitives
primitiveFindHandlerContext
	"Primitive. Search up the context stack for the next method context marked
	 for exception handling starting at the receiver. Return nil if none found"
	self subclassResponsibility