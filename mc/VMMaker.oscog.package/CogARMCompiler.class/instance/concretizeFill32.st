generate machine code
concretizeFill32
	"fill with operand 0 according to the processor's endianness"
	| word |
	<var: #word type: #'unsigned long'>
	word := operands at: 0.
	machineCode at: 0 put: (word bitAnd: 16rFF).
	machineCode at: 1 put: (word >> 8bitAnd: 16rFF)..
	machineCode at: 2 put: (word >> 16bitAnd: 16rFF)..
	machineCode at: 3 put: (word >> 24bitAnd: 16rFF)..
	^machineCodeSize := 4