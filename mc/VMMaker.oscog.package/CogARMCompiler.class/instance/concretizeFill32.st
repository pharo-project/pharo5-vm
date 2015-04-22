generate machine code
concretizeFill32
	"fill with operand 0 according to the processor's endianness"
	| word |
	<var: #word type: #'unsigned long'>
	word := operands at: 0.
	self machineCodeAt: 0 put: word.
	^machineCodeSize := 4