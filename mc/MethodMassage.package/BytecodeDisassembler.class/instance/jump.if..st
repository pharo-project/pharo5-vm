instruction decoding
jump: offset if: condition
	"Disassemble the Conditional Jump bytecode."

	labelling
		ifTrue:
			[labels at: instrs pc + offset put: true]
		ifFalse:
			[instructions
				at: thePC
				put: (Message
						selector: #jump:if:
						arguments: { labels at: instrs pc + offset. condition })]