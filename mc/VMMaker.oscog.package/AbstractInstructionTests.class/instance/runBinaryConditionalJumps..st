running
runBinaryConditionalJumps: assertPrintBar
	"self defaultTester runBinaryConditionalJumps: false"
	| mask count reg1 reg2 reg3 reg1Getter reg2Setter reg3Setter |
	mask := (1 << self processor bitsInWord) - 1.
	count := 0.
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:n :get :set|
		count = 0 ifTrue: [reg1 := n. reg1Getter := get].
		count = 1 ifTrue: [reg2 := n. reg2Setter := set].
		count = 2 ifTrue: [reg3 := n. reg3Setter := set].
		count := count + 1].
	self assert: reg1 ~= nil.
	self assert: reg2 ~= nil.
	self assert: reg3 ~= nil.
	#(	(JumpAbove > unsigned)			(JumpBelowOrEqual <= unsigned)
		(JumpBelow < unsigned)			(JumpAboveOrEqual >= unsigned)
		(JumpGreater > signed)			(JumpLessOrEqual <= signed)
		(JumpLess < signed)				(JumpGreaterOrEqual >= signed)
		(JumpZero = signed)				(JumpNonZero ~= signed)) do:
		[:triple|
		[:opName :relation :signednessOrResult| | opcode jumpNotTaken jumpTaken nop memory bogus |
		self resetGen.
		opcode := CogRTLOpcodes classPool at: opName.
		self gen: CmpRR operand: reg3 operand: reg2.
		jumpTaken := self genConditionalBranch: opcode operand: 0.
		self gen: MoveCqR operand: 0 operand: reg1.
		jumpNotTaken := self gen: Jump.
		jumpTaken jmpTarget: (self gen: MoveCqR operand: 1 operand: reg1).
		jumpNotTaken jmpTarget: (nop := self gen: Nop).
		memory := self generateInstructions.
		"self processor disassembleFrom: 0 to: memory size in: memory on: Transcript."
		bogus := false.
		self pairs: (-2 to: 2)  do:
			[:a :b| | taken |
			self processor
				reset;
				perform: reg2Setter with: (processor convertIntegerToInternal: a);
				perform: reg3Setter with: (processor convertIntegerToInternal: b).
			[self processor singleStepIn: memory.
			 self processor pc ~= nop address] whileTrue.
			taken := (self processor perform: reg1Getter) = 1.
			assertPrintBar
				ifTrue:
					[self assert: taken equals: (signednessOrResult == #unsigned
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