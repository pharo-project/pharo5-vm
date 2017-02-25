tests
testArithmeticShiftRightRR
	"CogX64CompilerTests new testArithmeticShiftRightRR"
	self concreteCompilerClass dataRegistersWithAccessorsDo:
		[:sreg :srgetter :srsetter|
		self concreteCompilerClass dataRegistersWithAccessorsDo:
			[:dreg :drgetter :drsetter| | inst len |
			inst := self gen: ArithmeticShiftRightRR operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			self assert: len = (srgetter = #rcx
								ifTrue: [3]
								ifFalse:
									[srgetter = #rax
										ifTrue: [7]
										ifFalse: [9]])
			"self processor disassembleFrom: 0 to: inst machineCodeSize in: inst machineCode object on: Transcript"]]