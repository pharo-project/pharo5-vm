tests
testMoveCwR
	"self new testMoveCwR"
	
	| memory |
	memory := ByteArray new: 16.
	#(16rFF00FF00 16r00000012 16r12345678) do:
		[:n| | inst len |
		self concreteCompilerClass dataRegistersWithAccessorsDo: 
			[ :r :rgetter :rset |
			inst := self gen: MoveCwR operand: n operand: r.
			len := inst concretizeAt: 0.
			memory replaceFrom: 1 to: len with: inst machineCode object startingAt: 1.
			self processor
				reset.
			[[processor pc < len] whileTrue:
				[self processor singleStepIn: memory]]
				on: Error
				do: [:ex| ].
			self concreteCompilerClass dataRegistersWithAccessorsDo:
				[:ireg :getter :setter| | expected |
				expected := getter == rgetter ifTrue: [ n ] ifFalse: [0].
				self assert: (self processor perform: getter) = expected].
			self assert: self processor pc = 16]]
