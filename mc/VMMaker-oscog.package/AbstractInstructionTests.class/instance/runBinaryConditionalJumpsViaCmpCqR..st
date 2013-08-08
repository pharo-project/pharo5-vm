running
runBinaryConditionalJumpsViaCmpCqR: assertPrintBar
	"self defaultTester runBinaryConditionalJumpsViaCmpCqR: false"
	| mask reg1 reg2 resultRegNum operandRegNum |
	mask := (1 << self processor bitsInWord) - 1.
	resultRegNum := 0.
	operandRegNum := 1.
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:n :get :set|
		n = resultRegNum ifTrue: [reg1 := get].
		n = operandRegNum ifTrue: [reg2 := set]].
	#(	(JumpAbove > unsigned)			(JumpBelowOrEqual <= unsigned)
		(JumpBelow < unsigned)			(JumpAboveOrEqual >= unsigned)
		(JumpGreater > signed)			(JumpLessOrEqual <= signed)
		(JumpLess < signed)				(JumpGreaterOrEqual >= signed)
		(JumpZero = signed)				(JumpNonZero ~= signed)) do:
		[:triple|
		[:opName :relation :signednessOrResult| | opcode |
		opcode := CogRTLOpcodes classPool at: opName.
		(-2 to: 2) do:
			[:b| | jumpNotTaken jumpTaken nop memory bogus |
			self resetGen.
			self gen: CmpCqR operand: b operand: operandRegNum.
			jumpTaken := self gen: opcode.
			self gen: MoveCqR operand: 0 operand: resultRegNum.
			jumpNotTaken := self gen: Jump.
			jumpTaken jmpTarget: (self gen: MoveCqR operand: 1 operand: resultRegNum).
			jumpNotTaken jmpTarget: (nop := self gen: Nop).
			memory := self generateInstructions.
			assertPrintBar ifFalse:
				[Transcript print: triple; cr.
				 self disassembleOpcodesIn: memory to: Transcript].
			bogus := false.
			(-2 to: 2) do:
				[:a| | taken expected |
				self processor
					reset;
					perform: reg2 with: a signedIntToLong.
				[self processor singleStepIn: memory.
				 self processor pc ~= nop address] whileTrue.
				taken := (self processor perform: reg1) = 1.
				expected := signednessOrResult == #unsigned
								ifTrue: [(a bitAnd: mask) perform: relation with: (b bitAnd: mask)]
								ifFalse: [a perform: relation with: b].
				assertPrintBar
					ifTrue:
						[self assert: taken = expected]
					ifFalse:
						[Transcript
							nextPutAll: 'CmpCqR '; print: b; space; nextPutAll: reg2; tab; tab;
							nextPutAll: reg2; nextPut: $(; print: a; nextPut: $); space;
							nextPutAll: relation; space; print: b; nextPutAll: ' = ';
							print: taken;  nextPutAll: ' ('; print: expected; nextPut: $).
						 taken ~= expected ifTrue:
							[Transcript nextPutAll: ' !!'.
							 bogus := true].
						 Transcript cr; flush]].
				bogus ifTrue:
					[self processor printRegistersOn: Transcript.
					 Transcript nextPutAll: jumpTaken symbolic; tab; show: (self processor disassembleInstructionAt: jumpTaken address In: memory); cr]]]
						valueWithArguments: triple]