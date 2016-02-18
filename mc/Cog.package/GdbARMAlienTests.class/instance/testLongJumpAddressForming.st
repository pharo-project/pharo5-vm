tests
testLongJumpAddressForming
	"self new testLongJumpAddressForming"
	"test of the somewhat loopy code used in CogARMCompiler>concretizeConditionalJumpLong: to generate the oading of a long address for jumps"
	| memory |
	memory := self memory.
	self processor reset.
	memory unsignedLongAt: 1 put: (CogARMCompiler new mov: 10 imm: 16r7F ror: 8)  bigEndian: false. 
	memory unsignedLongAt: 5 put: (CogARMCompiler new orr: 10 imm: 16rFF ror: 16) bigEndian: false.
	memory unsignedLongAt: 9 put: (CogARMCompiler new orr: 10 imm: 16rFE ror: 24) bigEndian: false. 
	memory unsignedLongAt: 13 put: (CogARMCompiler new orr: 10 imm: 16r68 ror: 0) bigEndian: false. 

	self processor
		disassembleInstructionAt: 0 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '00000000: mov	sl, #2130706432	; 0x7f000000'].
	self processor
		disassembleInstructionAt: 4 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '00000004: orr	sl, sl, #16711680	; 0xff0000'].
	self processor
		disassembleInstructionAt: 8 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '00000008: orr	sl, sl, #65024	; 0xfe00'].
	self processor
		disassembleInstructionAt: 12 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '0000000c: orr	sl, sl, #104	; 0x68'].
	self processor
		pc: 0;
		singleStepIn: memory;
		singleStepIn: memory;
		singleStepIn: memory;
		singleStepIn: memory.
	self 
		assert: self processor pc = 16;
		assert: self processor sl = 16r7FFFFE68;
		assert: self processor zflag = 0;
		assert: self processor cflag = 0;
		assert: self processor vflag = 0;
		assert: self processor nflag = 0.
