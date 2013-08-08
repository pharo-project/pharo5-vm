running
runSubRR: assertPrintBar
	"self defaultTester runSubRR: false"
	| memory |
	memory := ByteArray new: self concreteCompilerClass new machineCodeBytes.
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:sreg :srgetter :srsetter|
		self concreteCompilerClass dataRegistersWithAccessorsDo:
			[:dreg :drgetter :drsetter| | inst len |
			inst := self gen: SubRR operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			memory replaceFrom: 1 to: len with: inst machineCode object startingAt: 1.
			self pairs: (-2 to: 2)  do:
				[:a :b| | bogus |
				self processor
					reset;
					perform: srsetter with: a signedIntToLong;
					perform: drsetter with: b signedIntToLong.
				[[processor pc < len] whileTrue:
					[self processor singleStepIn: memory]]
					on: Error
					do: [:ex| ].
				"self processor printRegistersOn: Transcript.
				 Transcript show: (self processor disassembleInstructionAt: 0 In: memory); cr"
				assertPrintBar
					ifTrue: [self assert: processor pc = inst machineCodeSize]
					ifFalse: [bogus := processor pc ~= inst machineCodeSize].
				self concreteCompilerClass dataRegistersWithAccessorsDo:
					[:ireg :getter :setter| | expected |
					expected := drgetter == srgetter
									ifTrue: [0]
									ifFalse:
										[getter == drgetter
											ifTrue: [b - a]
											ifFalse: [getter = srgetter
														ifTrue: [a]
														ifFalse: [0]]].
					assertPrintBar
						ifTrue: [self assert: (self processor perform: getter) signedIntFromLong = expected]
						ifFalse:
							[(self processor perform: getter) signedIntFromLong ~= expected ifTrue:
								[bogus := true]]].
					assertPrintBar ifFalse:
						[Transcript
							nextPutAll: drgetter; nextPut: $(; print: b; nextPutAll: ') - ';
							nextPutAll: srgetter; nextPut: $(; print: a; nextPutAll: ') = ';
							print: (self processor perform: drgetter) signedIntFromLong; cr; flush.
						 bogus ifTrue:
							[self processor printRegistersOn: Transcript.
							 Transcript show: (self processor disassembleInstructionAt: 0 In: memory); cr]]]]]