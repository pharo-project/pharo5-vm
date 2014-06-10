tests
testFlags
"test the processor flag state reading and setting"
	"self new testFlags"
	| memory |
	memory := Bitmap new: 5.
	self processor reset.
	memory longAt: 1 put: 16rE3A03001 bigEndian: false. "MOV r3, #1"
	memory longAt: 5 put: 16rE3530001 bigEndian: false. "CMP r3, #1"
	memory longAt: 9 put: 16r13A00003 bigEndian: false. "MOVNE r0, #3"
	memory longAt: 13 put: 16r03A00005 bigEndian: false. "MOVEQ r0, #5"
	memory := memory asByteArray.
	self processor
		disassembleInstructionAt: 0 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '00000000: mov	r3, #1'].
	self processor
		disassembleInstructionAt: 4 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '00000004: cmp	r3, #1'].
	self processor
		disassembleInstructionAt: 8 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '00000008: movne	r0, #3'].
	self processor
		disassembleInstructionAt: 12 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '0000000c: moveq	r0, #5'].
	self processor
		pc: 0;
		singleStepIn: memory;
		singleStepIn: memory;
		singleStepIn: memory;
		assert: self processor r0 = 0;
		singleStepIn: memory.
	self 
		assert: self processor pc = 16;
		assert: self processor r3 = 1;
		assert: self processor r0 = 5;
		assert: self processor zflag = 1;
		assert: self processor cflag = 1;
		assert: self processor vflag = 0;
		assert: self processor nflag = 0.
	self processor reset.
	self assert: self processor eflags = 3. "IFFlags are both set."