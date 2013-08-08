I/O primitives
primitiveSetDisplayMode
	"Set to OS to the requested display mode.
	See also DisplayScreen setDisplayDepth:extent:fullscreen:"
	| fsFlag h w d okay |
	fsFlag := self booleanValueOf: (self stackTop).
	h := self stackIntegerValue: 1.
	w := self stackIntegerValue: 2.
	d := self stackIntegerValue: 3.
	successFlag ifTrue: [okay := self cCode:'ioSetDisplayMode(w, h, d, fsFlag)'].
	successFlag ifTrue: [
		self pop: 5. "Pop args+rcvr"
		self pushBool: okay].