instruction decoding
sendToAbsentDynamicSuperclass: selector numArgs: numArgs
	"Dynamic Superclass Send Message With Selector, selector, to absent implicit receiver bytecode."
	self drop: numArgs - 1 "e.g. if no args pushes a result"