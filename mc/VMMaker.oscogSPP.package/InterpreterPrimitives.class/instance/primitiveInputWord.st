I/O primitives
primitiveInputWord
	"Return an integer indicating the reason for the most recent input interrupt."

	self pop: 1 thenPushInteger: 0.	"noop for now"