I/O primitives
primitiveSetDisplayMode
	"Set to OS to the requested display mode.
	See also DisplayScreen setDisplayDepth:extent:fullscreen:"
	| fsFlag h w d okay |
	fsFlag := self booleanValueOf: (self stackTop).
	h := self stackIntegerValue: 1.
	w := self stackIntegerValue: 2.
	d := self stackIntegerValue: 3.
	self successful ifTrue: [okay := self cCode:'ioSetDisplayMode(w, h, d, fsFlag)'].
	self successful ifTrue: [self pop: 5 thenPushBool: okay "Pop args+rcvr"]