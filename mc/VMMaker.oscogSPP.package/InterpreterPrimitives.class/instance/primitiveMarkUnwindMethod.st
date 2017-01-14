control primitives
primitiveMarkUnwindMethod
	"Primitive. Mark the method for exception unwinding. The primitive must fail after marking the context so that the regular code is run.  It must also *not* allow a context switch."
	<inline: false>
	^self primitiveFail