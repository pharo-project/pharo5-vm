generate machine code - concretize
concretizeFill32
	"fill with operand 0 according to the processor's endianness"
	| word |
	<var: #word type: #'unsigned long'>
	
	self flag: #bogus. "Gaps in the instruction stream should be filled with the stop instruction."
	
	word := operands at: 0.
	self machineCodeAt: 0 put: word.
	^machineCodeSize := 4