tests
testQuickDisassemby
	"self new testQuickDisassemby"

	| memory result |
	memory := WordArray new: 2.
	memory at: 1 put: 3858758348.
	result := self processor
		disassembleInstructionAt: 0 
		In: memory 
		into: [:str :len | 
			^str].