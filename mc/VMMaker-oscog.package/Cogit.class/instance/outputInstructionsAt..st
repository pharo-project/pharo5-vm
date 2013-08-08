generate machine code
outputInstructionsAt: startAddress
	"Store the generated machine code, answering the last address"
	| absoluteAddress |
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	absoluteAddress := startAddress.
	0 to: opcodeIndex - 1 do:
		[:i| | abstractInstruction |
		abstractInstruction := self abstractInstructionAt: i.
		self assert: abstractInstruction address = absoluteAddress.
		0 to: abstractInstruction machineCodeSize - 1 do:
			[:j|
			objectMemory byteAt: absoluteAddress put: (abstractInstruction machineCode at: j).
			absoluteAddress := absoluteAddress + 1]].
	^absoluteAddress