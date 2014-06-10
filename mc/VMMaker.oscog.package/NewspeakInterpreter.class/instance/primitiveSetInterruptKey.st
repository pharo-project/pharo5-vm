I/O primitives
primitiveSetInterruptKey
	"Set the user interrupt keycode. The keycode is an integer whose encoding is described in the comment for primitiveKbdNext."

	| keycode |
	keycode := self popInteger.
	self successful
		ifTrue: [ interruptKeycode := keycode ]
		ifFalse: [ self unPop: 1 ].