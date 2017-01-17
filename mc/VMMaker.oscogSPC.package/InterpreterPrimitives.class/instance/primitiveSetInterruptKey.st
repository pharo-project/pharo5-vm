I/O primitives
primitiveSetInterruptKey
	"Set the user interrupt keycode. The keycode is an integer whose encoding is described in the comment for primitiveKbdNext."

	| keycode |
	keycode := self stackIntegerValue: 0.
	self successful ifTrue:
		[self setInterruptKeycode: keycode.
		 self pop: argumentCount]