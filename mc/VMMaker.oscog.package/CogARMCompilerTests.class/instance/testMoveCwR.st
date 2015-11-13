tests
testMoveCwR
	"self new testMoveCwR"
	
	#(16rFF00FF00 16r00000012 16r12345678) do:
		[:n|
		self concreteCompilerClass dataRegistersWithAccessorsDo: 
			[ :r :rgetter :rset | | inst len memory |
			inst := self gen: MoveCwR operand: n operand: r.
			len := inst concretizeAt: 0.
			memory := self memoryAsBytes: inst machineCode.
			self processor
				reset.
			[[processor pc < inst machineCodeSize] whileTrue:
				[self processor singleStepIn: memory]]
				on: Error
				do: [:ex| ].
			self concreteCompilerClass dataRegistersWithAccessorsDo:
				[:ireg :getter :setter| | expected |
				expected := getter == rgetter ifTrue: [ n ] ifFalse: [0].
				self assert: (self processor perform: getter) = expected].
			self assert: self processor pc = 16]]
