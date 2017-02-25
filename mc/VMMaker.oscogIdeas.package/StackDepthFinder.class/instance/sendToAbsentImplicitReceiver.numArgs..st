instruction decoding
sendToAbsentImplicitReceiver: selector numArgs: numArgs
	"Send Message With Selector, selector, to absent implicit receiver bytecode."
	self drop: numArgs - 1 "e.g. if no args pushes a result"