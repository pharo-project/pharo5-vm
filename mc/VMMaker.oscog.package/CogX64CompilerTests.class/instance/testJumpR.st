tests
testJumpR
	"self new testJumpR"
	self concreteCompilerClass registersWithNamesDo:
		[:reg :regname| | inst len|
			inst := self gen: JumpR operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := 'jmp ', regname.
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]