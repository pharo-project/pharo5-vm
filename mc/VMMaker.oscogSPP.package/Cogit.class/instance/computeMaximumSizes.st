generate machine code
computeMaximumSizes
	"This pass assigns maximum sizes to all abstract instructions and eliminates jump fixups.
	 It hence assigns the maximum address an instruction will occur at which allows the next
	 pass to conservatively size jumps."
	<inline: false>
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	| relativeAddress |
	literalsManager dumpLiterals: false.
	relativeAddress := 0.
	0 to: opcodeIndex - 1 do:
		[:i| | abstractInstruction |
		abstractInstruction := self abstractInstructionAt: i.
		abstractInstruction
			address: relativeAddress;
			maxSize: abstractInstruction computeMaximumSize.
		relativeAddress := relativeAddress + abstractInstruction maxSize]