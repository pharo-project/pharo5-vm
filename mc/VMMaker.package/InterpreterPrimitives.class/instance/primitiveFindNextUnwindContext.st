control primitives
primitiveFindNextUnwindContext
	"Primitive. Search up the context stack for the next method context marked for unwind
	 handling from the receiver up to but not including the argument. Return nil if none found."
	self subclassResponsibility