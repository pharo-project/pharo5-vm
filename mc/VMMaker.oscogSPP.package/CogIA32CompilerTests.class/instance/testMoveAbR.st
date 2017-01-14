tests
testMoveAbR
	"self new testMoveAbR"
	CogIA32CompilerForTests registersWithNamesDo:
		[:reg :regname|
		#(16r555555 16rAAAAAA) do:
			[:addr| | inst len |
			inst := self gen: MoveAbR operand: addr operand: reg.
			len := inst concretizeAt: 0.
			self assert: inst byteReadsZeroExtend.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := 'movzbl 0x', (addr hex allButFirst: 3), ', ', regname.
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]