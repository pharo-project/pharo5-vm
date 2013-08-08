running
runArithmeticShiftRightRR: assertPrintBar
	"self defaultTester runArithmeticShiftRightRR: false"
	"self defaultTester runArithmeticShiftRightRR: true"
	| memory |
	memory := ByteArray new: 16.
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:sreg :srgetter :srsetter|
		self concreteCompilerClass dataRegistersWithAccessorsDo:
			[:dreg :drgetter :drsetter| | inst len |
			inst := self gen: ArithmeticShiftRightRR operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			memory replaceFrom: 1 to: len with: inst machineCode object startingAt: 1.
			self pairs: (-5 to: 19 by: 6)  do:
				[:a :b| | bogus |
				(a >= 0 and: [sreg ~= dreg or: [b >= 0]]) ifTrue:
					[self processor
						reset;
						perform: srsetter with: a signedIntToLong;
						perform: drsetter with: b signedIntToLong.
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
							ifTrue: [self assert: (self processor perform: getter) signedIntFromLong = expected]
							ifFalse:
								[(self processor perform: getter) signedIntFromLong ~= expected ifTrue:
									[bogus := true]]].
						assertPrintBar ifFalse:
							[Transcript
								nextPutAll: drgetter; nextPut: $(; print: b; nextPutAll: ') >> ';
								nextPutAll: srgetter; nextPut: $(; print: a; nextPutAll: ') = ';
								print: (self processor perform: drgetter) signedIntFromLong; cr; flush.
							 bogus ifTrue:
								[self processor printRegistersOn: Transcript.
								 self processor disassembleFrom: 0 to: inst machineCodeSize in: memory on: Transcript]]]]]]