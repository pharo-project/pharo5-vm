generate machine code
concretizeFill16
	<inline: true>
	| word |
	<var: #word type: 'unsigned short'>
	self assert: maxSize == 2.
	word := operands at: 0.
	machineCode at: 0 put: (word bitAnd: 16rFF).
	machineCode at: 1 put: word >> 8.
	^machineCodeSize := 2