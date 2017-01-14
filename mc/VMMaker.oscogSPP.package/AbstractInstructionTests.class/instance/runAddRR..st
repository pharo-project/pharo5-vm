running
runAddRR: assertPrintBar
	"self defaultTester runAddRR: false"
	"self defaultTester runAddRR: true"
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:sreg :srgetter :srsetter|
		self concreteCompilerClass dataRegistersWithAccessorsDo:
			[:dreg :drgetter :drsetter| | inst len memory |
			inst := self gen: AddRR operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			memory := self memoryAsBytes: inst machineCode.
			self pairs: (-2 to: 2)  do:
				[:a :b| | bogus |
				self processor
					reset;
					perform: srsetter with: (processor convertIntegerToInternal: a);
					perform: drsetter with: (processor convertIntegerToInternal: b).
				[[processor pc < len] whileTrue:
					[self processor singleStepIn: memory]]
					on: Error
					do: [:ex| ].
				"self processor printRegistersOn: Transcript.
				 Transcript show: (self processor disassembleInstructionAt: 0 In: memory); cr"
				assertPrintBar
					ifTrue: [self assert: processor pc equals: inst machineCodeSize]
					ifFalse: [bogus := processor pc ~= inst machineCodeSize].
				self concreteCompilerClass dataRegistersWithAccessorsDo:
					[:ireg :getter :setter| | expected |
					expected := getter == drgetter
									ifTrue: [srgetter == drgetter
												ifTrue: [b + b]
												ifFalse: [a + b]]
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
							nextPutAll: drgetter; nextPut: $(; print: b; nextPutAll: ') + ';
							nextPutAll: srgetter; nextPut: $(; print: a; nextPutAll: ') = ';
							print: (self processor convertInternalToInteger: (self processor perform: drgetter)); cr; flush.
						 bogus ifTrue:
							[self processor printRegistersOn: Transcript.
							 Transcript show: (self processor disassembleInstructionAt: 0 In: memory); cr]]]]]