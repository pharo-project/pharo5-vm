running
testNegateR
	"self defaultTester testNegateR"
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:reg :rgetter :rsetter|
		-2 to: 2 do:
			[:a| | inst len memory |
			inst := self gen: NegateR operand: reg.
			len := inst concretizeAt: 0.
			memory := self memoryAsBytes: inst machineCode.
			self processor
				reset;
				perform: rsetter with: (processor convertIntegerToInternal: a).
			[[processor pc < len] whileTrue:
				[self processor singleStepIn: memory]]
				on: Error
				do: [:ex| ].
			"self processor printRegistersOn: Transcript.
			 Transcript show: (self processor disassembleInstructionAt: 0 In: memory); cr"
			self assert: processor pc equals: inst machineCodeSize.
			self concreteCompilerClass dataRegistersWithAccessorsDo:
				[:ireg :getter :setter| | expected |
				expected := getter == rgetter ifTrue: [ a negated ] ifFalse: [0].
				self assert: (processor convertInternalToInteger: (processor perform: getter)) equals: expected]]]