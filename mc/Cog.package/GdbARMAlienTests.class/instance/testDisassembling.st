tests
testDisassembling

	| memory result |
	memory := WordArray new: 2.
	memory at: 1 put: 16rEF200000.
	result := self processor
		disassembleInstructionAt: 0 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str = '0x00000000: svc	0x00200000'].