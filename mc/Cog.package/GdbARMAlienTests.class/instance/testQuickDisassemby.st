tests
testQuickDisassemby
	"self new testQuickDisassemby"

	| memory result |
	memory := WordArray new: 2.
	memory at: 1 put: (CogARMCompiler new orr: 6  imm: 16r3F ror: 16).
	result := self processor
		disassembleInstructionAt: 0 
		In: memory 
		into: [:str :len | 
			^str =  '00000000: orr	r6, r6, #4128768	; 0x3f0000'].