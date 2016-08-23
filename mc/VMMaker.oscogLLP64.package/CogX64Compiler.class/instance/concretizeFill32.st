generate machine code
concretizeFill32
	<inline: true>
	| word |
	<var: #word type: #'usqIntptr_t'>
	word := operands at: 0.
	machineCode at: 0 put: (word bitAnd: 16rFF).
	machineCode at: 1 put: (word >> 8 bitAnd: 16rFF).
	machineCode at: 2 put: (word >> 16 bitAnd: 16rFF).
	machineCode at: 3 put: (word >> 24 bitAnd: 16rFF).
	^machineCodeSize := 4