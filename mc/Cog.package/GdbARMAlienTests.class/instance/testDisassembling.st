tests
testDisassembling
	"self new testDisassembling"

	| memory result |
	memory := WordArray new: 2.
	memory at: 1 put: 3800756324.
	result := self processor
		disassembleInstructionAt: 0 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str = '00000000: add	pc, sl, #100	; 0x64'].