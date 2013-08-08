running
runSubCqR: assertPrintBar
	"self defaultTester runSubCqR: false"
	| memory |
	memory := ByteArray new: 16.
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:reg :rgetter :rsetter|
		self pairs: (-2 to: 2)  do:
			[:a :b| | inst len bogus |
			inst := self gen: SubCqR operand: a operand: reg.
			len := inst concretizeAt: 0.
			memory replaceFrom: 1 to: len with: inst machineCode object startingAt: 1.
			self processor
				reset;
				perform: rsetter with: b signedIntToLong.
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
					ifTrue: [self assert: (self processor perform: getter) signedIntFromLong = expected]
					ifFalse:
						[(self processor perform: getter) signedIntFromLong ~= expected ifTrue:
							[bogus := true]]].
				assertPrintBar ifFalse:
					[Transcript
						nextPutAll: rgetter; nextPut: $(; print: b; nextPutAll: ') - '; print: a; nextPutAll: ' = ';
						print: (self processor perform: rgetter) signedIntFromLong; cr; flush.
					 bogus ifTrue:
						[self processor printRegistersOn: Transcript.
						 Transcript show: (self processor disassembleInstructionAt: 0 In: memory); cr]]]]