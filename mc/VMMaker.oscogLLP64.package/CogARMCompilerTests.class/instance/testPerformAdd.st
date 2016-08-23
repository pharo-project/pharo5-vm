tests
testPerformAdd
	"self new testPerformAdd"
	
	| memory |
	#(16rFF00FF00 16r00000012 16r12345678) do:
		[:n| | |
		self concreteCompilerClass dataRegistersWithAccessorsDo: 
			[ :r :rgetter :rset |
			self resetGen. "initialise important stuff"
 			self gen: MoveCwR operand: n operand: r.
			self gen: AddCqR operand: 42 operand: r.
			memory := self generateInstructions.
			"self disassembleOpcodesIn: memory to: Transcript."
			self processor
				reset.
			[[processor pc < memory size] whileTrue:
				[self processor singleStepIn: memory]]
				on: Error
				do: [:ex| ].
			self concreteCompilerClass dataRegistersWithAccessorsDo:
				[:ireg :getter :setter| | expected |
				expected := getter == rgetter ifTrue: [ n + 42] ifFalse: [0].
				self assert: (self processor perform: getter) = expected].
			self assert: self processor pc = 20]]
