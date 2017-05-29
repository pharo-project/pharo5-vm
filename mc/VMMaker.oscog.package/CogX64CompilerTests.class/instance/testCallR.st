tests
testCallR
	"self new testCallR"
	self concreteCompilerClass registersWithNamesDo:
		[:reg :regname| | inst len|
			inst := self gen: CallR operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := 'call ', regname.
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]