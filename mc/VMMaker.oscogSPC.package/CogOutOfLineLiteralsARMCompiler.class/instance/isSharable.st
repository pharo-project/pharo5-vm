generate machine code
isSharable
	"Hack:  To know if a literal should be unique (not shared) mark the second operand."
	<inline: true>
	self assert: opcode = Literal.
	^operands at: 1