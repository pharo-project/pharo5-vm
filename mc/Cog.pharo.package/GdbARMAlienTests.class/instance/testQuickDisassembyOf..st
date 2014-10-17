execution
testQuickDisassembyOf: word
	"self new testQuickDisassembyOf: 3858758348"

	| memory result |
	memory := WordArray new: 2.
	memory at: 1 put: word.
	result := self processor
		disassembleInstructionAt: 0 
		In: memory 
		into: [:str :len | 
			^str].