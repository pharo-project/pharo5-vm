running
runSubCqR: assertPrintBar
	"self defaultTester runSubCqR: false"
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:reg :rgetter :rsetter|
		self pairs: (-2 to: 2)  do:
			[:a :b| | inst len bogus memory |
			inst := self gen: SubCqR operand: a operand: reg.
			len := inst concretizeAt: 0.
			memory := self memoryAsBytes: inst machineCode.
			self processor
				reset;
				perform: rsetter with: (processor convertIntegerToInternal: b).
			[[processor pc < len] whileTrue:
				[self processor singleStepIn: memory]]
				on: Error
				do: [:ex| ].
			"self processor printRegistersOn: Transcript.
			 Transcript show: (self processor disassembleInstructionAt: 0 In: memory); cr"
			assertPrintBar
				ifTrue: [self assert: processor pc = inst machineCodeSize.
						self assertCheckQuickArithOpCodeSize: inst machineCodeSize]
				ifFalse: [bogus := processor pc ~= inst machineCodeSize].
			self concreteCompilerClass dataRegistersWithAccessorsDo:
				[:ireg :getter :setter| | expected |
				expected := getter == rgetter ifTrue: [b - a] ifFalse: [0].
				assertPrintBar
					ifTrue: [self assert: (self processor convertInternalToInteger: (self processor perform: getter)) equals: expected]
					ifFalse:
						[(self processor convertInternalToInteger: (self processor perform: getter)) ~= expected ifTrue:
							[bogus := true]]].
				assertPrintBar ifFalse:
					[Transcript
						nextPutAll: rgetter; nextPut: $(; print: b; nextPutAll: ') - '; print: a; nextPutAll: ' = ';
						print: (self processor convertInternalToInteger: (self processor perform: rgetter)); cr; flush.
					 bogus ifTrue:
						[self processor printRegistersOn: Transcript.
						 Transcript show: (self processor disassembleInstructionAt: 0 In: memory); cr]]]]