running
runBinaryConditionalJumpsViaSubCqR: assertPrintBar
	"self defaultTester runBinaryConditionalJumpsViaSubCqR: false"
	| mask count reg1 reg2 setreg2 resultRegNum operandRegNum |
	mask := (1 << self processor bitsInWord) - 1.
	count := 0.
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:n :get :set|
		count = 0 ifTrue: [resultRegNum := n. reg1 := get].
		count = 1 ifTrue: [operandRegNum := n. reg2 := get. setreg2 := set].
		count := count + 1].
	self assert: resultRegNum ~= nil.
	self assert: operandRegNum ~= nil.
	
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
			self gen: SubCqR operand: b operand: operandRegNum.
			jumpTaken := self genConditionalBranch: opcode operand: 0.
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
				[:a| | taken result expected |
				self processor
					reset;
					perform: setreg2 with: (self processor convertIntegerToInternal: a).
				[self processor singleStepIn: memory.
				 self processor pc ~= nop address] whileTrue.
				taken := (self processor perform: reg1) = 1.
				result := signednessOrResult == #unsigned
							ifTrue: [(a bitAnd: mask) - (b bitAnd: mask)]
							ifFalse: [a - b].
				expected := result perform: relation with: 0.
				assertPrintBar
					ifTrue:
						[self assert: (taken = expected
									  and: [(result bitAnd: mask) = (processor perform: reg2)])]
					ifFalse:
						[Transcript
							nextPutAll: 'SubCqR '; print: b; space; nextPutAll: reg2; tab; tab;
							print: b; space; nextPutAll: relation; space;
							nextPutAll: reg2; nextPut: $(; print: a; nextPutAll: ') = ';
							print: taken;  nextPutAll: ' ('; print: expected; nextPut: $).
						 taken ~= expected ifTrue:
							[Transcript nextPutAll: ' !!'.
							 bogus := true].
						 Transcript cr; flush]].
				bogus ifTrue:
					[self processor printRegistersOn: Transcript.
					 Transcript nextPutAll: jumpTaken symbolic; tab; show: (self processor disassembleInstructionAt: jumpTaken address In: memory); cr]]]
						valueWithArguments: triple]