I/O primitives
primitiveTestDisplayDepth
	"Return true if the host OS does support the given display depth."
	| bitsPerPixel okay|
	bitsPerPixel := self stackIntegerValue: 0.
	successFlag ifTrue: [okay := self ioHasDisplayDepth: bitsPerPixel].
	successFlag ifTrue: [
		self pop: 2. "Pop arg+rcvr"
		self pushBool: okay].