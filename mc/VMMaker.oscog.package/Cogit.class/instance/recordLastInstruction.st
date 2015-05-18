simulation only
recordLastInstruction
	<doNotGenerate>
	| inst pc |
	(EagerInstructionDecoration or: [printInstructions])
		ifTrue:
			[inst := processor
						disassembleNextInstructionIn: coInterpreter memory
						for: self.
			 printInstructions ifTrue:
				[pc := Integer readFrom: (ReadStream on: inst from: 1 to: (inst indexOf: $:) - 1) base: 16.
				 (self relativeLabelForPC: pc) ifNotNil:
					[:label| inst := inst, ' ', label]]]
		ifFalse:
			[inst := processor
						disassembleNextInstructionIn: coInterpreter memory
						for: nil].
	^self recordInstruction: inst