running
testNegateR
	"self defaultTester testNegateR"
	| memory |
	memory := ByteArray new: self concreteCompilerClass new machineCodeBytes.
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:reg :rgetter :rsetter|
		-2 to: 2 do:
			[:a| | inst len |
			inst := self gen: NegateR operand: reg.
			len := inst concretizeAt: 0.
			memory replaceFrom: 1 to: len with: inst machineCode object startingAt: 1.
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