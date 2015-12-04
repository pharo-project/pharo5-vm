tests
testAndRR
	"CogX64CompilerTests new testAndRR"
	self concreteCompilerClass registersWithNamesDo:
		[:sreg :sregname|
		self concreteCompilerClass registersWithNamesDo:
			[:dreg :dregname| | inst len |
			inst := self gen: AndRR operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := 'andq ', sregname, ', ', dregname.
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]