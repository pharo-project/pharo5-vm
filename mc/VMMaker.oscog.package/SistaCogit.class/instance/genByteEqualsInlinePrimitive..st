inline primitive generators
genByteEqualsInlinePrimitive: prim

	"3021	Byte Object >> equals:length:	
	The receiver and the arguments are both byte objects and have both the same size (length in bytes). 
	The length argument is a smallinteger. 
	Answers true if all fields are equal, false if not. 
	Comparison is bulked to word comparison."
	
	"Overview: 
	 1.	The primitive is called like that: [byteObj1 equals: byteObj2 length: length].
	  	In the worst case we use 5 registers including TempReg 
		and we produce a loop bulk comparing words.
	 2.	The common case is a comparison against a cst: [byteString = 'foo'].
		which produces in Scorch [byteString equals: 'foo' length: 3].
		We try to generate fast code for this case with 3 heuristics:
		- specific fast code if len is a constant
		- unroll the loop if len < 2 * wordSize
		- compile-time reads if str1 or str2 is a constant and loop is unrolled.
		We use 3 registers including TempReg in the common case. 
		We could use 1 less reg if the loop is unrolled, the instr is followed by a branch
		AND one operand is a constant, but this is complicated enough.
	3.	We ignore the case where all operands are constants 
		(We assume Scorch simplifies it, it works but it is not optimised)"
		
	| str1Reg str2Reg lenReg extraReg jmp jmp2 adjust needjmpZeroSize needLoop unroll jmpZeroSize instr lenCst mask |
	<var: #jmp type: #'AbstractInstruction *'>
	<var: #instr type: #'AbstractInstruction *'>
	<var: #jmp2 type: #'AbstractInstruction *'>
	<var: #jmpZeroSize type: #'AbstractInstruction *'>

	"--- quick path for empty string---"
	"This path does not allocate registers and right shift on negative int later in the code.
	 Normally this is resolved by Scorch but we keep it for correctness and consistency"
	self ssTop type = SSConstant ifTrue: 
		[ lenCst := objectMemory integerValueOf: self ssTop constant.
		  lenCst = 0 ifTrue: [ self ssPop: 3. self ssPushConstant: objectMemory trueObject. ^ 0 ] ].

	"--- Allocating & loading registers --- "
	needLoop := (self ssTop type = SSConstant and: [ lenCst <= (objectMemory wordSize * 2) ]) not.
	unroll := needLoop not and: [lenCst > objectMemory wordSize ].
	needLoop 
		ifTrue: 
			[ str1Reg := self allocateRegForStackEntryAt: 1 notConflictingWith: self emptyRegisterMask.
			  str2Reg := self allocateRegForStackEntryAt: 2 notConflictingWith: (self registerMaskFor: str1Reg).
			  (self ssValue: 1) popToReg: str1Reg.
			  (self ssValue: 2) popToReg: str2Reg.
			  lenReg := self allocateRegForStackEntryAt: 0 notConflictingWith: (self registerMaskFor:str1Reg and: str2Reg).
			  extraReg := self allocateRegNotConflictingWith: (self registerMaskFor: str1Reg and: str2Reg and: lenReg)]
		ifFalse: 
			[ mask := self emptyRegisterMask.
			  (self ssValue: 1) type = SSConstant ifFalse: 
				[ str1Reg := self allocateRegForStackEntryAt: 1 notConflictingWith: mask.
				  (self ssValue: 1) popToReg: str1Reg.
				  mask := mask bitOr: (self registerMaskFor: str1Reg) ].
			  (self ssValue: 2) type = SSConstant ifFalse: 
				[ str2Reg := self allocateRegForStackEntryAt: 2 notConflictingWith: mask.
				  (self ssValue: 2) popToReg: str2Reg.
				  mask := mask bitOr: (self registerMaskFor: str2Reg) ].
			  extraReg := self allocateRegNotConflictingWith: mask].
	adjust := objectMemory baseHeaderSize >> objectMemory shiftForWord.
	
	"--- Loading LenReg (or statically resolving it) --- "
	"LenReg is loaded with (lenInBytes + objectMemory baseHeaderSize - 1 >> shiftForWord)
	 LenReg is the index for the last word to compare with MoveXwr:r:R:.
	 The loop iterates from LenReg to first word of ByteObj"
	self ssTop type = SSConstant 
		ifTrue: "common case, str = 'foo'. We can precompute lenReg."
			[ lenCst := lenCst + objectMemory baseHeaderSize - 1 >> objectMemory shiftForWord.
			  needLoop ifTrue: [self MoveCq: lenCst R: lenReg ].
			  needjmpZeroSize := false] 
		ifFalse: "uncommon case, str = str2. lenReg in word computed at runtime."
			[ objectRepresentation genConvertSmallIntegerToIntegerInReg: lenReg.
			  self CmpCq: 0 R: lenReg.
			  jmpZeroSize := self JumpZero: 0.
			  needjmpZeroSize := true.
			  self AddCq: objectMemory baseHeaderSize - 1 R: lenReg.
			  self ArithmeticShiftRightCq: objectMemory shiftForWord R: lenReg ].
	
	"--- Comparing the strings --- "
	"LenReg has the index of the last word to read (unless no loop). 
	 We decrement it to adjust -1 (0 in 64 bits) while comparing"
	needLoop 
		ifTrue:
			[instr := self MoveXwr: lenReg R: str1Reg R: extraReg.
			self MoveXwr: lenReg R: str2Reg R: TempReg.
			self CmpR: extraReg R: TempReg.
			jmp := self JumpNonZero: 0. "then string are not equal (jmp target)"
			self AddCq: -1 R: lenReg.
			self CmpCq: adjust-1 R: lenReg. "first word of ByteObj, stop looping - in 64 bits adjust - 1 is 0, quicker."
			self JumpNonZero: instr]
		ifFalse: "Common case, only 1 or 2 word to check: no lenReg allocation, cst micro optimisations"
			[self genByteEqualsInlinePrimitiveCmp: str1Reg with: str2Reg scratch1: extraReg scratch2: TempReg field: 0.
			jmp := self JumpNonZero: 0. "then string are not equal (jmp target)"
			unroll ifTrue: "unrolling more than twice generate more instructions than the loop so we don't do it"
				[self genByteEqualsInlinePrimitiveCmp: str1Reg with: str2Reg scratch1: extraReg scratch2: TempReg field: 1.
				jmp2 := self JumpNonZero: 0. "then string are not equal (jmp target)"]].
	needjmpZeroSize ifTrue: [ jmpZeroSize jmpTarget: self Label ].
	"fall through, strings are equal"
	
	"--- Pushing the result or pipelining a branch --- "	
	self ssPop: 3.
	self genByteEqualsInlinePrimitiveResult: jmp returnReg: extraReg.
	unroll ifTrue: [jmp2 jmpTarget: jmp getJmpTarget].
	^0