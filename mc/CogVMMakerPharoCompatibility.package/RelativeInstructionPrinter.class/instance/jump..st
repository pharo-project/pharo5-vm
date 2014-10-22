instruction decoding
jump: offset
	"Print the Unconditional Jump bytecode."

	labelling
		ifTrue:
			[labels at: scanner pc + offset + 1 put: true.
			 self print: 'jumpBy: ', offset printString,
				' to: ', (scanner pc + offset - method initialPC) printString]
		ifFalse:
			[self print: 'jumpTo: ', (labels at: scanner pc + offset + 1)]