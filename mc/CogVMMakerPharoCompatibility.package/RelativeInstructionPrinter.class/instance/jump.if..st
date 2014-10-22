instruction decoding
jump: offset if: condition 
	"Print the Conditional Jump bytecode."

	labelling
		ifTrue:
			[labels at: scanner pc + offset + 1 put: true.
			 self print: 
				(condition ifTrue: ['jumpTrueBy: '] ifFalse: ['jumpFalseBy: ']), offset printString,
				' to: ', (labelling
							ifTrue: [(scanner pc + offset - method initialPC) printString]
							ifFalse: [labels at: scanner pc + offset])]
		ifFalse:
			[self print: 
				(condition ifTrue: ['jumpTrueTo: '] ifFalse: ['jumpFalseTo: ']), (labels at: scanner pc + offset + 1)]