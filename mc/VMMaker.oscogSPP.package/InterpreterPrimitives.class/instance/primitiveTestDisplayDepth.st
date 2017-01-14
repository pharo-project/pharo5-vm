I/O primitives
primitiveTestDisplayDepth
	"Return true if the host OS does support the given display depth."
	| bitsPerPixel okay|
	bitsPerPixel := self stackIntegerValue: 0.
	self successful ifTrue: [okay := self ioHasDisplayDepth: bitsPerPixel].
	self successful ifTrue: [self pop: 2 thenPushBool: okay"Pop arg+rcvr"]