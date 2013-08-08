tests
testFlags
	"self new testFlags"
	| memory |
	memory := Bitmap new: 3.
	memory longAt: 1 put: 16rE3A03001 bigEndian: false. "MOV r3, #1"
	memory longAt: 5 put: 16rE3530001 bigEndian: false. "CMP r3, #1"
	memory := memory asByteArray.
	self processor
		disassembleInstructionAt: 0 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '0x00000000: mov	r3, #1'].
	self processor
		disassembleInstructionAt: 4 
		In: memory 
		into: [:str :len | 
			self 
				assert: len = 4;
				assert: str equals: '0x00000004: cmp	r3, #1'].
	self processor
		pc: 0;
		singleStepIn: memory;
		singleStepIn: memory.
	self 
		assert: self processor pc = 16r8;
		assert: self processor r3 = 1;
		assert: self processor zflag = 1;
		assert: self processor cflag = 1;
		assert: self processor vflag = 0;
		assert: self processor nflag = 0.
	self processor reset.
	self assert: self processor eflags = 3. "IFFlags are both set."