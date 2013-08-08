system control primitives
primitiveNoop
	"A placeholder for primitives that haven't been implemented or are being withdrawn gradually. Just absorbs any arguments and returns the receiver."

	self pop: argumentCount.  "pop args, leave rcvr on stack"