running
runArithmeticShiftRightRR: assertPrintBar
	"self defaultTester runArithmeticShiftRightRR: false"
	"self defaultTester runArithmeticShiftRightRR: true"
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:sreg :srgetter :srsetter|
		self concreteCompilerClass dataRegistersWithAccessorsDo:
			[:dreg :drgetter :drsetter| | inst len memory |
			inst := self gen: ArithmeticShiftRightRR operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			memory := self memoryAsBytes: inst machineCode.
			self pairs: (-5 to: 19 by: 6)  do:
				[:a :b| | bogus |
				(a >= 0 and: [sreg ~= dreg or: [b >= 0]]) ifTrue:
					[self processor
						reset;
						perform: srsetter with: (processor convertIntegerToInternal: a);
						perform: drsetter with: (processor convertIntegerToInternal: b).
					[self processor singleStepIn: memory.
					 self processor pc ~= inst machineCodeSize] whileTrue.
					"self processor printRegistersOn: Transcript.
					 self processor disassembleFrom: 0 to: inst machineCodeSize in: memory on: Transcript"
					assertPrintBar
						ifTrue: [self assert: processor pc = inst machineCodeSize]
						ifFalse: [bogus := processor pc ~= inst machineCodeSize].
					self concreteCompilerClass dataRegistersWithAccessorsDo:
						[:ireg :getter :setter| | expected |
						expected := getter == drgetter
										ifTrue: [srgetter == drgetter
													ifTrue: [b >> b]
													ifFalse: [b >> a]]
										ifFalse: [getter = srgetter
													ifTrue: [a]
													ifFalse: [0]].
						assertPrintBar
							ifTrue: [self assert: (self processor convertInternalToInteger: (self processor perform: getter)) equals: expected]
							ifFalse:
								[(self processor convertInternalToInteger: (self processor perform: getter)) ~= expected ifTrue:
								[bogus := true]]].
						assertPrintBar ifFalse:
							[Transcript
								nextPutAll: drgetter; nextPut: $(; print: b; nextPutAll: ') >> ';
								nextPutAll: srgetter; nextPut: $(; print: a; nextPutAll: ') = ';
								print: (self processor convertInternalToInteger: (self processor perform: drgetter)); cr; flush.
							 bogus ifTrue:
								[self processor printRegistersOn: Transcript.
								 self processor disassembleFrom: 0 to: inst machineCodeSize in: memory on: Transcript]]]]]]