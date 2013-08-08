generate machine code
concretizeFillFromWord
	| word |
	<var: #word type: #'unsigned long'>
	self assert: maxSize == 4.
	word := (operands at: 0) + (operands at: 1).
	0 to: 3 do:
		[:i|
		machineCode at: i put: (word bitAnd: 16rFF).
		word := word >> 8].
	^machineCodeSize := maxSize