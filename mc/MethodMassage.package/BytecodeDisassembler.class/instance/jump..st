instruction decoding
jump: offset
	"Print the Unconditional Jump bytecode."

	labelling
		ifTrue:
			[labels at: instrs pc + offset put: true]
		ifFalse:
			[instructions
				at: thePC
				put: (Message
						selector: #jump:
						argument: (labels at: instrs pc + offset))]