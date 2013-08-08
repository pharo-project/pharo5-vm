tests
testArithmeticShiftRightRR
	"CogIA32CompilerTests new testArithmeticShiftRightRR"
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:sreg :srgetter :srsetter|
		self concreteCompilerClass dataRegistersWithAccessorsDo:
			[:dreg :drgetter :drsetter| | inst len |
			inst := self gen: ArithmeticShiftRightRR operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			self assert: len = (srgetter = #ecx
								ifTrue: [2]
								ifFalse:
									[srgetter = #eax
										ifTrue: [4]
										ifFalse: [6]])
			"self processor disassembleFrom: 0 to: inst machineCodeSize in: inst machineCode object on: Transcript"]]