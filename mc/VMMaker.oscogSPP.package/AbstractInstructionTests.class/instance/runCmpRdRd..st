running
runCmpRdRd: assertPrintBar
	"self defaultTester runCmpRdRd: false"
	"self defaultTester runCmpRdRd: true"
	| resultReg result reg1 reg2 setreg1 setreg2 |
	self concreteCompilerClass new hasDoublePrecisionFloatingPointSupport ifFalse: [^true].
	resultReg := 0.
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:n :get :set| n = resultReg ifTrue: [result := get]].
	self concreteCompilerClass fp64RegistersWithAccessorsDo:
		[:n :get :set|
		n = DPFPReg0 ifTrue: [reg1 := get. setreg1 := set].
		n = DPFPReg1 ifTrue: [reg2 := set. setreg2 := set]].
	#(	(genJumpFPGreater: > false nan)	(genJumpFPLessOrEqual: <= false nil)
		(genJumpFPLess: < false nil)				(genJumpFPGreaterOrEqual: <= true nan)
		(genJumpFPGreater: < true nan)		(genJumpFPGreaterOrEqual: >= false nan)
		(genJumpFPEqual: = false nan)		(genJumpFPNotEqual: ~= false nan)) do:
		[:tuple|
		[:opName :relation :invert :nan| | them inst jumpNotTaken jumpTaken nop memory |
		them := nan ifNil: [-2.0 to: 2.0] ifNotNil: [(-2.0 to: 2.0), { Float nan }].
		self resetGen.
		inst := invert
				ifTrue: [self gen: CmpRdRd operand: DPFPReg0 operand: DPFPReg1]
				ifFalse: [self gen: CmpRdRd operand: DPFPReg1 operand: DPFPReg0].
		jumpTaken := inst perform: opName with: 0.
		self gen: MoveCqR operand: 0 operand: resultReg.
		jumpNotTaken := self gen: Jump.
		jumpTaken jmpTarget: (self gen: MoveCqR operand: 1 operand: resultReg).
		jumpNotTaken jmpTarget: (nop := self gen: Nop).
		memory := self generateInstructions.
		assertPrintBar ifFalse:
			[Transcript print: tuple; cr.
			 self disassembleOpcodesIn: memory to: Transcript].
		them do:
			[:a|
			them do:
				[:b| | taken expected |
				self processor
					reset;
					perform: setreg1 with: a asIEEE64BitWord;
					perform: setreg2 with: b asIEEE64BitWord.
				[self processor singleStepIn: memory.
				 self processor pc ~= nop address] whileTrue.
				taken := (self processor perform: result) = 1.
				expected := a perform: relation with: b.
				assertPrintBar
					ifTrue:
						[self assert: taken = expected]
					ifFalse:
						[Transcript
							nextPutAll: 'CmpRdRd ', reg1, ' ', reg2; tab; tab;
							nextPutAll: reg1; nextPut: $(; print: a; nextPut: $); space;
							nextPutAll: relation; space;
							nextPutAll: reg2; nextPut: $(; print: b; nextPut: $); space;
							nextPutAll: ' = '; print: taken;  nextPutAll: ' ('; print: expected; nextPut: $).
						 taken ~= expected ifTrue:
							[Transcript nextPutAll: ' !!'; cr.
							 self processor printRegistersOn: Transcript.].
						 Transcript cr; flush]]]]
						valueWithArguments: tuple]