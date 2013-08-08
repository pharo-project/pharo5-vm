running
runBinaryConditionalJumps: assertPrintBar
	"self defaultTester runBinaryConditionalJumps: false"
	| mask reg1 reg2 reg3 |
	mask := (1 << self processor bitsInWord) - 1.
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:n :get :set|
		n = 0 ifTrue: [reg1 := get].
		n = 1 ifTrue: [reg2 := set].
		n = 2 ifTrue: [reg3 := set]].
	#(	(JumpAbove > unsigned)			(JumpBelowOrEqual <= unsigned)
		(JumpBelow < unsigned)			(JumpAboveOrEqual >= unsigned)
		(JumpGreater > signed)			(JumpLessOrEqual <= signed)
		(JumpLess < signed)				(JumpGreaterOrEqual >= signed)
		(JumpZero = signed)				(JumpNonZero ~= signed)) do:
		[:triple|
		[:opName :relation :signednessOrResult| | opcode jumpNotTaken jumpTaken nop memory bogus |
		self resetGen.
		opcode := CogRTLOpcodes classPool at: opName.
		self gen: CmpRR operand: 2 operand: 1.
		jumpTaken := self gen: opcode.
		self gen: MoveCqR operand: 0 operand: 0.
		jumpNotTaken := self gen: Jump.
		jumpTaken jmpTarget: (self gen: MoveCqR operand: 1 operand: 0).
		jumpNotTaken jmpTarget: (nop := self gen: Nop).
		memory := self generateInstructions.
		"self processor disassembleFrom: 0 to: memory size in: memory on: Transcript"
		bogus := false.
		self pairs: (-2 to: 2)  do:
			[:a :b| | taken |
			self processor
				reset;
				perform: reg2 with: a signedIntToLong;
				perform: reg3 with: b signedIntToLong.
			[self processor singleStepIn: memory.
			 self processor pc ~= nop address] whileTrue.
			taken := (self processor perform: reg1) = 1.
			assertPrintBar
				ifTrue:
					[self assert: taken = (signednessOrResult == #unsigned
											ifTrue: [(a bitAnd: mask) perform: relation with: (b bitAnd: mask)]
											ifFalse: [a perform: relation with: b])]
				ifFalse:
					[Transcript
						nextPutAll: reg2; nextPut: $(; print: a; nextPutAll: ') '; nextPutAll: relation; space;
						nextPutAll: reg3; nextPut: $(; print: b; nextPutAll: ') = ';
						print: taken; cr; flush.
					 taken = (signednessOrResult == #unsigned
											ifTrue: [(a bitAnd: mask) perform: relation with: (b bitAnd: mask)]
											ifFalse: [a perform: relation with: b]) ifFalse:
						[bogus := true]]].
			 bogus ifTrue:
				[self processor printRegistersOn: Transcript.
				 Transcript show: (self processor disassembleInstructionAt: jumpTaken address In: memory); cr]]
					valueWithArguments: triple]