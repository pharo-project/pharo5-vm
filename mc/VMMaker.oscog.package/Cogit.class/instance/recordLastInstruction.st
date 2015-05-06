simulation only
recordLastInstruction
	<doNotGenerate>
	^self recordInstruction: (processor
								disassembleNextInstructionIn: coInterpreter memory
								for: ((EagerInstructionDecoration or: [printInstructions]) ifTrue: [self]))